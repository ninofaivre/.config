require('lspconfig')['sumneko_lua'].setup
{
	settings =
	{
		Lua =
		{
			runtime =
			{
				version = "LuaJIT"
			},
			diagnostics =
			{
				globals = { 'vim' }
			}
		}
	}
}

print("nvim")
