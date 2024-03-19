local function hook ()
	print("new test ????")
end

local lua_ls_config = {
	settings = {
    helloFromProjectConfig = "hello",
		Lua = {
			diagnostics = {
				globals = { 'TESTOA', 'TESTOC' }
			}
		}
	}
}

return {
	path = "/tmp/TEST/a",
	lspConfigs = {
		['lua_ls'] = lua_ls_config
	},
	hook = hook
}
