-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use 'edgedb/edgedb-vim'

	-- theme
	use 'EdenEast/nightfox.nvim'

	use
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.0',
		-- or                            , branch = '0.1.x',
		  requires = { {'nvim-lua/plenary.nvim'} }
	}

	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use 'mbbill/undotree'

	use 'tpope/vim-fugitive'

	-- LSP Support
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig.nvim'
	use 'neovim/nvim-lspconfig'

			-- Autocompletion
	use 'hrsh7th/nvim-cmp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'saadparwaiz1/cmp_luasnip'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lua'

			-- Snippets
	use 'L3MON4D3/LuaSnip'
	use 'rafamadriz/friendly-snippets'

	use '~/Prog/Personal/42Header.nvim'
	use
	{
		'ninofaivre/DarkLightToggle.nvim',
		config = function () require("DarkLightToggle").setup("dayfox", "nightfox", { ["start"] = { hour = 6 }, ["end"] = { hour = 20 } }) end
	}

	use
	{
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- use 'windwp/nvim-projectconfig'
	use 'ahmedkhalf/project.nvim'
	use(
	{
		'numToStr/Comment.nvim',
		config = function() require('Comment').setup() end
	})
	-- use "nvim-neorg/neorg"

	use 'godlygeek/tabular'
	use 'elzr/vim-json'
	use 'plasticboy/vim-markdown'

	use 'davidgranstrom/nvim-markdown-preview'

end)
