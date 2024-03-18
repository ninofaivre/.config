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

return {
	path = "/home/nino/.config/nvim",
	lspConfigs = {
		['lua_ls'] = lua_ls_config
	},
	hook = nil,
	clearHook = nil,
	keys = nil
}
