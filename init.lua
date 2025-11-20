vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>qq', ':q<CR>')
vim.keymap.set('n', '<leader>hrr', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>fs', ':write<CR>')
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>')
vim.keymap.set('n', '<leader>fh', ':Pick help<CR>')
vim.keymap.set('n', '<leader>fp', 
  function() 
    vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua") 
  end
)

vim.pack.add ({
	{src = 'https://github.com/nvim-mini/mini.pick'},
	{src = 'https://github.com/nvim-mini/mini.pairs'},
	{src = 'https://github.com/vague-theme/vague.nvim'},
	{src = 'https://github.com/mfussenegger/nvim-jdtls'},
  {src = 'https://github.com/nvim-treesitter/nvim-treesitter'},
})

require "mini.pairs".setup()
require "mini.pick".setup({
	window = {
		config = function()
			local width = math.floor(vim.o.columns * 0.5)
			local height = 12
			local row = 3
			local col = math.floor((vim.o.columns - width) / 2)

			return {
	 			anchor = 'NW',
				border = 'rounded',
				width = width,
				height = height,
				row = row,
				col = col,
			}
		end,
}}) 

-- Colorscheme picker
local function list_colorschemes() 
  return vim.fn.getcompletion('', 'color')
end

local function pick_colorschemes()
  MiniPick.start({
    source = {
      items = list_colorschemes,
      name = "Colorschemes",
    },
    choose = function(item)
      vim.cmd.colorscheme(item)
    end,
  })
end

vim.keymap.set('n', '<leader>ht', pick_colorschemes)



vim.lsp.enable({ "jdtls" })

require "nvim-treesitter.configs".setup({
  ensure_installed = { 'java', 'xml', },

  highlight = { enable = true },

  indent = { enable = false },
}) 

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
