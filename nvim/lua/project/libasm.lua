local lua_ls_config = {
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT'
			},
			workspace = {
				checkThirdParty = false,
				library = vim.api.nvim_get_runtime_file("", true)
				-- library = {
				-- 	vim.env.VIMRUNTIME
				-- }
			}
		}
	}
}

local function makeBear()
	require("plenary.job"):new({
		command = 'make',
		args = { 'bear', '-j8' },
	}):start()
end

local function asmGetNearestGlobLabel()
	local parser = assert(vim.treesitter.get_parser())
	local tree = parser:parse()[1]
	local query = [[
		(
			(instruction
				kind: (word) @globKeyword (#eq? @globKeyword "global")
				(ident (reg (word) @globLabel ) )
			)
			(_)*
			(label
				(ident (reg (word) @globLabelDef (#eq? @globLabelDef @globLabel) ) )
			)
		)
	]]
	local parsedQuery = vim.treesitter.query.parse('asm', query)
	local vPos = vim.api.nvim_win_get_cursor(0)[1]
	local closestFunc = nil
	for pattern, match, metadata in parsedQuery:iter_matches(tree:root(), 0, 0, 0) do
		for id, node in pairs(match) do
			if parsedQuery.captures[id] == 'globLabelDef' then
				local currentFunc = {
					text = vim.treesitter.get_node_text(node, 0),
					range = vim.treesitter.get_node_range(node)
				}
				if (not closestFunc or (vPos - currentFunc.range < vPos - closestFunc.range) and (vPos - currentFunc.range > 0)) then
					closestFunc = currentFunc
				end
			end
		end
	end
	return closestFunc and closestFunc.text
end

local function neotestCriterionRunOneTestSuite(suiteName)
	local tree = require("neotest").run.get_tree_from_args({ suite = true })
	local idsToPath = {}
	local paths = {}
	for _, node in tree:iter_nodes() do
		local nodeData = node:data()
		if nodeData.type == "test" then
			if nodeData.suiteName == suiteName then
				idsToPath[nodeData.id] = nodeData.path
				if paths[nodeData.path] == nil then
					paths[nodeData.path] = true
				end
			else
				paths[nodeData.path] = false
			end
		end
	end
	for id, path in pairs(idsToPath) do
		if paths[path] == false then
			require("neotest").run.run({ id })
		end
	end
	for path, v in pairs(paths) do
		if v then
			require("neotest").run.run({ path })
		end
	end
end

local path =  "/home/nino/Prog/42/libasm"

---@type Project
return {
	name = "libasm",
	path = path,
	lspConfigs = {
		['lua_ls'] = lua_ls_config
	},
	hook = function ()
		vim.keymap.set('n', '<leader>t',
			function ()
				local suiteName = asmGetNearestGlobLabel()
				neotestCriterionRunOneTestSuite(suiteName)
			end, {})
	end,
	clearHook = function ()
	end,
	autoCmdsHook = function (augroup)
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { path .. "/Makefile" },
			group = augroup,
			desc = "run make bear to update compile_commands.json each time Makefile change",
			callback = makeBear
		})
	end,
}
