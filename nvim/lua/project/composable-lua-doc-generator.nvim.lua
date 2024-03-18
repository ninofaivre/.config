local path = "/home/nino/Prog/Personal/composable-lua-doc-generator.nvim"

local function reloadDocBuffer()
  local bufnr = vim.fn.bufnr(path .. "/doc/composable-lua-doc-generator.txt")
  if bufnr == -1 then return end
  vim.api.nvim_buf_call(bufnr, function ()
      vim.cmd("e %")
    end)
end

local function generateDocAndReloadBuffer()
  vim.cmd("Lazy reload composable-lua-doc-generator.nvim")
  dofile(path .. "/scripts/doc.lua")(path, reloadDocBuffer)
end

return {
  path = path,
  hook = function ()
    vim.keymap.set('n', '<leader>Lr', generateDocAndReloadBuffer, {})
  end,
  clearHook = function ()
  end
}
