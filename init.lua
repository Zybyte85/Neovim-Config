local opt = vim.opt
-- opt is global options

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true

vim.g.mapleader = " "

require("config.lazy")

-- Choose colorscheme
-- Installed: nord, catppuccin (with it's flavors)
vim.cmd('colorscheme github_dark_dimmed') 

-- Treesitter config
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = false
  }
}

-- empty setup using defaults
require("nvim-tree").setup()
vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

local last_dir = vim.fn.stdpath('data') .. '/last_dir'

-- Save current directory on exit
vim.api.nvim_create_autocmd('VimLeavePre', {
	callback = function()
		local cwd = fn.getcwd()
		vim.fn.writefile({cwd}, last_dir)
	end
})

-- LSP stuff
require('mason').setup()

local cmp = require 'cmp'

cmp.setup {
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'path' },
		{ name = 'buffer' }
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
		["<C-p>"] = cmp.mapping.select_prev_item { bebavior = cmp.SelectBehavior.Insert },
		["<Tab>"] = cmp.mapping.confirm {
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		},
	},
}
