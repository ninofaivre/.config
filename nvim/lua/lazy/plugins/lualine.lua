return {{
	'nvim-lualine/lualine.nvim', lazy = false, priority = 100,
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		require('lualine').setup()
	end
}}
