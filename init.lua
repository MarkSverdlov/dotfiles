-- sourcing my vimrc
local vimrc = "~/.vimrc"
vim.cmd.source(vimrc)


-- lualine.nvim
vim.cmd("packadd lualine.nvim")
function time()
    return os.date("%H:%M")
end
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', {'fileformat', symbols = {unix='🐧'}}, 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {time},
        lualine_z = {'tabs'}
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- vim-tpipeline
vim.cmd("packadd vim-tpipeline")


-- orgmode
require('orgmode').setup {
    mappings = {
        org = {
            org_move_subtree_up = '<leader>k',
            org_move_subtree_down = '<leader>j'
        },
    },
    org_agenda_files = '~/orgfiles/**/*',
    org_default_notes_file = '~/orgfile/refile.org',
    org_capture_templates = {
        w = {
            description = 'Websites',
            template = '* %:description\n  %:link\n  %:date',
            targets = "~/orgfiles/websites.org",
        },
        b = {
            description = 'Books',
            template = '* %:description\n  %:path\n  %:date',
            targets = "~/orgfiles/books.org",
        },
    }
}

-- kitty-scrollback.nvim
vim.cmd("packadd kitty-scrollback.nvim")
require("kitty-scrollback").setup()

-- lsp servers

-- nvim.cmp
local cmp = require'cmp'

cmp.setup({
snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
    vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
},
window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
},
mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
}),
sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'ultisnips' }, -- For ultisnips users.
}, {
    { name = 'buffer' },
})
})

cmp.setup.cmdline({ '/', '?' }, {
mapping = cmp.mapping.preset.cmdline(),
sources = {
    { name = 'buffer' }
}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
mapping = cmp.mapping.preset.cmdline(),
sources = cmp.config.sources({
    { name = 'path' }
}, {
    { name = 'cmdline' }
}),
matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
vim.lsp.config('pylsp', {
capabilities = capabilities,
})
vim.lsp.config('lua_ls', {
capabilities = capabilities
})
vim.lsp.enable('pylsp')
vim.lsp.enable('lua_ls')
