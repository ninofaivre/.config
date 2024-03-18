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

local path = "/home/nino/Prog/Personal/neotest-criterion"

local function reloadDocBuffer()
  local bufnr = vim.fn.bufnr(path .. "/doc/neotest-criterion.txt")
  if bufnr == -1 then return end
  vim.api.nvim_buf_call(bufnr, function ()
      vim.cmd("e %")
    end)
end

local function generateDocWithLemmyHelp()
    vim.system({ "lemmy-help", "-f", "-a", "-c", "-t", path .. "/lua/neotest-criterion/init.lua", path .. "/lua/neotest-criterion/settings/defaults.lua" }, { text = true },
      function (obj)
        local file = io.open(path .. "/doc/neotest-criterion.txt", "w")
        file:write(obj.stdout)
        file:close()
        vim.schedule(function ()
          vim.cmd("helptags " .. path .. "/doc")
          reloadDocBuffer()
        end)
      end)
end

local function generateDocWithTJ()
  require("notify")("generating doc...", "", { timeout = 100 })
  local docgen = require("docgen")

  local inputFiles = {
    path .. "/lua/neotest-criterion/init.lua",
    path .. "/lua/neotest-criterion/settings/defaults.lua"
  }

  local outputFile = path .. "/doc/neotest-criterion.txt"
  local outputFileHandle = io.open(outputFile, "w")
  if outputFileHandle == nil then return end

  for _, inputFile in ipairs(inputFiles) do
    docgen.write(inputFile, outputFileHandle)
  end

  outputFileHandle:write("vim:tw=78:ts=8:ft=help:norl:\n")
  outputFileHandle:close()

  reloadDocBuffer()
end

local Doc = {}

Doc.interpret = {
  ["write"] = function (data)
    return data.str .. "\n"
  end,
  ["separator"] = function (data)
    return string.rep(data.char, data.time) .. "\n"
  end,
  ["module"] = function (data, modules)
    table.insert(modules, data.name)
    local tag = "*" .. table.concat(modules, ".") .. "*"
    return data.name:upper() .. string.rep(" ", 80 - #data.name - (#tag - 2)) .. tag .. "\n\n"
  end,
  ["closeModule"] = function (_, modules)
    modules[#modules] = nil
  end,
  ["tag"] = function (data, modules)
    local tag = "*" .. table.concat(vim.tbl_flatten({ modules, data.name }), ".") .. "*"
    return string.rep(" ", 80 - (#tag - 2)) .. tag .. "\n"
  end,
  ["code"] = function (data)
    if not data.content:find("^%s") then
      data.content = " " .. data.content:gsub("\n", "\n ")
    end
    return ">" .. data.lang .. "\n" .. data.content .. "\n" .. "<" .. "\n"
  end,
  ["function"] = function (data, modules)
    local parameters = ""
    if #data.parameters ~= 0 then
      parameters = "{" .. table.concat(data.parameters, "}{") .. "}"
    end
    local exemple = "`" .. data.name .. "`(" .. parameters .. ")"
    local tag = "*" .. table.concat(vim.tbl_flatten({ modules, data.name }), ".") .. "()*"
    return exemple .. string.rep(" ", 80 - #exemple - (#tag - 2)) .. tag .. "\n"
  end
}

function Doc:new(outputHandle)
  local doc = {
    file = outputHandle,
    items = {}
  }
  setmetatable(doc, {
    __index = self
  })
  return doc
end

function Doc:write(str)
  table.insert(self.items, {
    type = "write",
    data = { str = str }
  })
end

function Doc:code(lang, content)
  table.insert(self.items, {
    type = "code",
    data = {
      lang = lang,
      content = content
    }
  })
end

function Doc:sep(char, time)
  table.insert(self.items, {
    type = "separator",
    data = {
      char = char or "=",
      time = time or 80
    }
  })
end

function Doc:module(name)
  self:sep()
  table.insert(self.items, {
    type = "module",
    data = { name = name }
  })
end

function Doc:closeModule()
  table.insert(self.items, {
    type = "closeModule"
  })
end

function Doc:tag(tag)
  table.insert(self.items, {
    type = "tag",
    data = { name = tag }
  })
end

function Doc:inspect(name, object)
  table.insert(self.items, {
    type = "code",
    data = {
      lang = "lua",
      content = "local " .. name .. " = " .. vim.inspect(object)
    }
  })
end

function Doc:func(name, ...)
  table.insert(self.items, {
    type = "function",
    data = {
      name = name,
      parameters = {...}
    }
  })
end

local function mineDocGen()
  require("notify")("generating doc...", "", { timeout = 100 })
  local outputFile = io.open(path .. "/doc/neotest-criterion.txt", "w")
  assert(outputFile ~= nil)
  local doc = Doc:new(outputFile)
  doc:write("*neotest-criterion.txt*    Simple criterion adapter for neotest plugin.\n")
  doc:module("neotest-criterion")
  doc:write([[WARNING

    This adapter is in a very early stage, bugs are to be expected !

    A custom diagnostic consumer is used to extend default one functionalities so
    you have to do the following to setup neotest-criterion adapter :]])

  doc:code("lua", [[
    require("neotest").setup({
      diagnostic = { enabled = false },
      consumers = { require("neotest-criterion.patchedDiagnostics") },
      adapters = {
        require("neotest-criterion").setup(myConfig)
      }
    })]])

  doc:write([[
    This custom consumer should behave normally with other adapters and extend
    the default diag consumer only for neotest-criterion adapter.
    It does not hook in to the default one for other adapters, it's just
    a good old copy paste of code because I'm not able to hook into the default consumer
    or to enable this custom one only for my adapter. The default consumer is only updated
    a few time a year and I intend to keep it up to date.
  ]])
  local hooks = vim.tbl_flatten({
    dofile(path .. "/lua/neotest-criterion/init.lua").genDoc,
    dofile(path .. "/lua/neotest-criterion/settings/defaults.lua").genDoc
  })
  for _, func in ipairs(hooks) do
    func(doc)
  end
  doc:write("vim:tw=78:ts=8:ft=help:norl:")
  local modules = {}
  local results = {}
  for _, item in ipairs(doc.items) do
    local func = Doc.interpret[item.type]
    assert(func ~= nil)
    local result = func(item.data, modules)
    if result ~= nil then
      table.insert(results, result)
    end
  end
  outputFile:write(table.concat(results))
  outputFile:close()
  reloadDocBuffer()
end

return {
  path = path,
	lspConfigs = {
		['lua_ls'] = lua_ls_config
	},
	hook = nil,
	clearHook = nil,
	keys = nil,
	autoCmdsHook = function (augroup)
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { path .. "/lua/neotest-criterion/init.lua", path .. "/lua/neotest-criterion/settings/defaults.lua" },
			group = augroup,
			desc = "regen doc",
			callback = mineDocGen
		})
	end,
}
