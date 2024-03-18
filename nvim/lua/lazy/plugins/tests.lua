return {
	{
		"ninofaivre/neotest-criterion"
	}, {
    "ninofaivre/composable-lua-doc-generator.nvim",
    lazy = true
  }, {
		"nvim-neotest/neotest",
		config = function ()
			require("neotest").setup({
				diagnostic = {
					enabled = false
				},
				consumers = {
					require("neotest-criterion.patchedDiagnostics")
				},
				adapters = {
					require("neotest-criterion").setup({
            buildFunction = function (callback, root)
              vim.system({ "make", "test" }, { cwd = root }, function (res)
                callback(res.code == 0)
              end)
            end,
						errorMessages = {
							crash = " CRASH",
							unexpectedSignal = " Unexpected signal bellow 󱞤 ",
							group = true
						},
						testDir = "srcs/tests",
            excludeTestDir = "srcs/tests/utils",
						criterionLogErrorFailTest = true,
						noUnexpectedSignalAtStartOfTest = true,
						executable = {
              path = "./test",
              env = {
							  LD_LIBRARY_PATH = "./Criterion/build/src"
              }
            },
						color = true,
					})
				}
			})
		end,
		dependencies = { 'nvim-lua/plenary.nvim', 'antoinemadec/FixCursorHold.nvim', 'nvim-treesitter/nvim-treesitter', 'ninofaivre/neotest-criterion' } }
}
