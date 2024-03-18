local opts = require("lazy.opts")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- This line allows me to name the directory where I store
-- my lazy config + plugins "lazy" and not collide with the
-- require("lazy").setup
package.loaded["lazy"] = nil
require("lazy").setup("lazy.plugins", opts)
