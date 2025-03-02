local opt = vim.opt
-- opt is global options

opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.termguicolors = true

vim.g.mapleader = " "

require("config.lazy")

-- Choose colorscheme
-- Installed: nord, catppuccin, tokyonight
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
vim.api.nvim_set_keymap('n', '<leader>E', ':NvimTreeFocus<CR>', { noremap = true, silent = true })

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
require('mason-lspconfig').setup()

require("mason-lspconfig").setup_handlers {
        -- The first entry (without a key) will be the default handler
        -- and will be called for each installed server that doesn't have
        -- a dedicated handler.
        function (server_name) -- default handler (optional)
            require("lspconfig")[server_name].setup {}
        end,
    }

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

require('telescope').setup{
	pickers = {
		find_files = {
			theme = 'dropdown',
		},
	},
}

-- Mappings
-- Telescope
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })


-- Window navigation
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w>h', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w>k', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w>l', {noremap = true, silent = true})

-- Open error float
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)

vim.keymap.set({ 'n', 'v' }, '<leader>f', vim.lsp.buf.format, { desc = "Format buffer or selection"})
