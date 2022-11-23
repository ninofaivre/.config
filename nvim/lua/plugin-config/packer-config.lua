return require 'packer'.startup(function()
	-- Packer
	--
	use 'wbthomason/packer.nvim'
	--
	-- Packer

	-- Themes
	--
	--use 'folke/tokyonight.nvim'
	use "EdenEast/nightfox.nvim"
	--
	-- Themes

	-- Plugins
	use 'ninofaivre/Header42.nvim' -- mine
	use 'dense-analysis/ale' -- syntax analyzer
	use "nvim-lua/plenary.nvim"
	use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }  -- git diff and conflict resolver
	use
	{
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}
    use
	{
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
	use
	{
		'romgrk/barbar.nvim',
		requires = { 'nvim-tree/nvim-web-devicons' }
	}
	-- nvim-cmp
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip'
	-- nvim-cmp
	use
	{
		"windwp/nvim-autopairs",
		config = function() require("nvim-autopairs").setup { map_cr = true } end
	}
	-- Plugins Dependency
	use 'nvim-tree/nvim-web-devicons'
	-- Plugins Dependency
	-- Plugins
end)
