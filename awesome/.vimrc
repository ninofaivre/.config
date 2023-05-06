echo "awesome"
lua << EOF
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
				globals = { 'awesome' }
			}
		}
	}
}

print("awesome")
EOF
