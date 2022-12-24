local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- BARBAR --
--[[
map('n', '<c-j>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<c-k>', '<Cmd>BufferNext<CR>', opts)
map('n', '<c-c>', '<Cmd>BufferClose<CR><Cmd>close<CR>', opts)
map('n', '<c-&>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<c-é>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<c-">', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<c-\'>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<c-(>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<c-->', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<c-è>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<c-_>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<c-ç>', '<Cmd>BufferGoto 9<CR>', opts)
--]]
-- BARBAR --

-- try to replace barbar
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
