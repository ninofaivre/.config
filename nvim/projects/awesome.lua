require('lspconfig')['sumneko_lua'].setup
{
	settings =
	{
		Lua =
		{
			runtime =
			{
				version = "Lua 5.4"
			},
			diagnostics =
			{
				globals = { 'awesome', 'client', 'root' }
			}
		}
	}
}

print("awesome")
