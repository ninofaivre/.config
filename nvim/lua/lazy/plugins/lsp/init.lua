return  {
	{
		"williamboman/mason.nvim",
		config = function ()
			require("mason").setup()
		end
	}, {
    "ninofaivre/pProjectConfig.nvim",
    lazy = true,
    config = function ()
      require("pProjectConfig").setup({
        projectsPath = vim.fn.stdpath('config') .. '/lua/project/',
        lspConfigsPath = vim.fn.stdpath('config') .. '/lua/lazy/plugins/lsp/configs/',
        instantTrigger = true
      })
    end,
    keys = {
      { "<leader>Po", function () require("pProjectConfig").openOrCreateProject() end }
    }
  }, {
		"williamboman/mason-lspconfig.nvim",
		config = function ()
      local handlers = {
				function (serverName)
					require("lspconfig")[serverName].setup({
            settings = {
              helloFromLspDotLua = "hello"
            },
						capabilities = require("cmp_nvim_lsp").default_capabilities(),
            before_init = require("pProjectConfig").beforeInit()
					})
				end,
      }
			require("mason-lspconfig").setup({ handlers = handlers })
		end,
		dependencies = { 'williamboman/mason.nvim', 'hrsh7th/nvim-cmp', "pProjectConfig.nvim" }
	}, {
		"neovim/nvim-lspconfig",
		keys = {
			{ "<leader>lr", vim.lsp.buf.rename },
			{ "<leader>d", vim.diagnostic.open_float }
		}
	}, { -- TODO treesitter config in another file
		"rush-rs/tree-sitter-asm", lazy = true,
		ft = "asm",
		dependencies = { 'nvim-treesitter/nvim-treesitter' }
	}, {
		"nvim-treesitter/nvim-treesitter", lazy = true,
		event = "BufRead",
		build = ":TSUpdate",
		config = function ()
			require('nvim-treesitter.configs').setup({
				auto_install = true,
        ignore_install = {},
        ensure_installed = {},
        modules = {},
        sync_install = false,
				highlight = {
					enable = true
				}
			})

			local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

			parser_configs.asm = {
				install_info = {
					url = 'https://github.com/rush-rs/tree-sitter-asm.git',
					files = { 'src/parser.c' },
					branch = 'main'
				}
			}
		end
	}, {
		"mrded/nvim-lsp-notify", lazy = true,
		event = "LspAttach",
		dependencies = { 'rcarriga/nvim-notify', 'williamboman/mason-lspconfig.nvim' },
		config = function ()
			require("lsp-notify").setup({
				icons = false,
				notify = require("notify")
			})
		end
	}, {
		"rcarriga/nvim-notify", lazy = true
	}
}
