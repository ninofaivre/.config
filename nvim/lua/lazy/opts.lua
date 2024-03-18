local opts = {
	root = vim.fn.stdpath("data") .. "/lazy",
	lockfile = vim.fn.stdpath("data") .. "/lazy" .. "/lazy-lock.json",
	install = {
		missing = true,
		colorscheme = { "nightfox" },
	},
	dev = {
		path = "~/Prog/Personal",
		patterns = { "ninofaivre" },
		fallback = false
	}
}

return opts
