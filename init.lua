vim.o.number = true
vim.o.relativenumber = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.winborder = "rounded"
vim.o.pumborder = "rounded"
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.termguicolors = true


vim.o.cursorlineopt = "number"
vim.o.cursorline = true
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#EBCB8B", bold = true })

vim.keymap.set('n', '<ESC>', ':nohlsearch<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>qq', ':q<CR>')
vim.keymap.set('n', '<leader>hr', ':update<CR> :so<CR>')
vim.keymap.set('n', '<leader>fs', ':write<CR>')
vim.keymap.set('n', '<leader>fp', 
  function() 
    vim.cmd.edit(vim.fn.stdpath("config") .. "/init.lua") 
  end
)

vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/nvim-orgmode/orgmode' },
  { src = 'https://github.com/chipsenkbeil/org-roam.nvim' },
  { src = 'https://github.com/stevearc/oil.nvim' },
  { src = 'https://github.com/nvim-mini/mini.pairs' },
  { src = 'https://github.com/mfussenegger/nvim-jdtls' },
  { src = 'https://github.com/vague-theme/vague.nvim' },
  { src = 'https://github.com/ibhagwan/fzf-lua' },
})

require 'mini.pairs'.setup()
require 'oil'.setup()
require 'mason'.setup()

local fzf = require 'fzf-lua'

vim.keymap.set('n', '<leader>ff', fzf.files)
vim.keymap.set('n', '<leader>fh', fzf.helptags)
vim.keymap.set('n', '<leader>ca', fzf.lsp_code_actions)

vim.lsp.config('*', {
  root_markers = { '.git' },
})

vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp' },
})

vim.lsp.enable({ "clangd", "jdtls", })

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)

require('orgmode').setup({
  org_agenda_files = {'~/org/*', '~/my-orgs/**/*'},
  org_default_notes_file = '~/org/refile.org',
  mappings = {
    global = {
      org_agenda = '<leader>oa',
      org_capture = '<leader>oc'
    }
  },
  org_capture_templates = {
    T = {
      description = 'Test',
      template = '',
      target = '~/org/todo.org'
    },
  }
})
