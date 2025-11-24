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
vim.lsp.enable('pyright')
vim.lsp.enable('lua_ls')
