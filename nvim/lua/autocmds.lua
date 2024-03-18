local augroup = vim.api.nvim_create_augroup("config", { clear = true })

vim.api.nvim_create_autocmd("VimLeavePre", {
	group = augroup,
	desc = "(tmp fix) close asm_lsp",
	callback = function (ev)
		local asm_lsp_client = GetLspClientByName("asm_lsp")
		if not asm_lsp_client then
			return
		end
		vim.lsp.stop_client(asm_lsp_client.id, false)
	end
})
