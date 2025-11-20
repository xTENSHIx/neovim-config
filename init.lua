vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.winborder = "rounded"

vim.pack.add ({
	{src = 'https://github.com/nvim-mini/mini.pick'},
	{src = 'https://github.com/vague-theme/vague.nvim'},
	{src = 'https://github.com/mfussenegger/nvim-jdtls'},
})

require "mini.pick".setup()

vim.lsp.enable({ "jdtls" })



vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method("textDocument/completion") then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger=true })
		end
	end,
})

vim.cmd[[set completeopt+=noselect]]

vim.cmd("colorscheme vague")
vim.cmd(":hi statusline guibg=NONE")
