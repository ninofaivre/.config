local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

vim.g.mapleader = ' ' -- define space as leader key
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

map('n', '<c-t>', '<Cmd>tabnew<CR>', opts)
map('n', '<c-j>', '<Cmd>tabp<CR>', opts)
map('n', '<c-k>', '<Cmd>tabn<CR>', opts)
map('n', '<c-&>', '<Cmd>tabfirst<CR>1gt', opts)
map('n', '<c-é>', '<Cmd>tabfirst<CR>2gt', opts)
map('n', '<c-">', '<Cmd>tabfirst<CR>3gt', opts)
map('n', '<c-\'>', '<Cmd>tabfirst<CR>4gt', opts)
map('n', '<c-(>', '<Cmd>tabfirst<CR>5gt', opts)
map('n', '<c-->', '<Cmd>tabfirst<CR>6gt', opts)
map('n', '<c-è>', '<Cmd>tabfirst<CR>7gt', opts)
map('n', '<c-_>', '<Cmd>tabfirst<CR>8gt', opts)
map('n', '<c-ç>', '<Cmd>tabfirst<CR>9gt', opts)
