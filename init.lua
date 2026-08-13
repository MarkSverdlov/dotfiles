vim.pack.add { "https://github.com/morhetz/gruvbox" }

-- sourcing my vimrc
local vimrc = "~/.vimrc"
vim.cmd.source(vimrc)


-- lualine.nvim
vim.pack.add{ "https://github.com/nvim-lualine/lualine.nvim" }
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


-- orgmode
vim.pack.add{ "https://github.com/nvim-orgmode/orgmode" }
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
vim.pack.add{ "https://github.com/mikesmithgh/kitty-scrollback.nvim" }
require("kitty-scrollback").setup()


-- Set up lspconfig.
-- blink.cmp
vim.pack.add{ 'https://github.com/saghen/blink.lib',
'https://github.com/saghen/blink.cmp'}
local cmp = require('blink.cmp')
cmp.build():pwait()
cmp.setup()
local capabilities = cmp.get_lsp_capabilities()
vim.lsp.config('pylsp', {
capabilities = capabilities,
})
vim.lsp.config('lua_ls', {
capabilities = capabilities
})
vim.lsp.config('texlab', {
capabilities = capabilities
})
vim.lsp.enable('pylsp')
vim.lsp.enable('lua_ls')
vim.lsp.enable('texlab')


-- REPL windows
vim.pack.add{ "https://github.com/Vigemus/iron.nvim" }
local iron = require("iron.core")
local view = require("iron.view")
local common = require("iron.fts.common")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"bash"}
      },
      python = {
        command = { "uv", "run", "python" },
        format = common.bracketed_paste_python,
        block_dividers = { "# %%", "#%%" },
        env = {PYTHON_BASIC_REPL = "1"} --this is needed for python3.13 and up.
      },
      R = {
          command = { "R" }
      }
    },
    -- set the file type of the newly created repl to ft
    -- bufnr is the buffer id of the REPL and ft is the filetype of the
    -- language being used for the REPL.
    repl_filetype = function(bufnr, ft)
      return "iron"
      -- or return a string name such as the following
      -- return "iron"
    end,
    -- Send selections to the DAP repl if an nvim-dap session is running.
    dap_integration = true,
    -- How the repl window will be displayed
    -- See below for more information
    repl_open_cmd = view.split.vertical.botright(0.61903398875),

    -- repl_open_cmd can also be an array-style table so that multiple
    -- repl_open_commands can be given.
    -- When repl_open_cmd is given as a table, the first command given will
    -- be the command that `IronRepl` initially toggles.
    -- Moreover, when repl_open_cmd is a table, each key will automatically
    -- be available as a keymap (see `keymaps` below) with the names
    -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
    -- For example,
    --
    -- repl_open_cmd = {
    --   view.split.vertical.rightbelow("%40"), -- cmd_1: open a repl to the right
    --   view.split.rightbelow("%25")  -- cmd_2: open a repl below
    -- }

  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    toggle_repl = "<localleader>rr", -- toggles the repl open and closed.
    -- If repl_open_command is a table as above, then the following keymaps are
    -- available
    -- toggle_repl_with_cmd_1 = "<localleader>rv",
    -- toggle_repl_with_cmd_2 = "<localleader>rh",
    restart_repl = "<localleader>rR", -- calls `IronRestart` to restart the repl
    send_motion = "<localleader>sc",
    visual_send = "<localleader>sc",
    send_file = "<localleader>sf",
    send_line = "<localleader>sl",
    send_paragraph = "<localleader>sp",
    send_until_cursor = "<localleader>su",
    send_mark = "<localleader>sm",
    send_code_block = "<localleader>sb",
    send_code_block_and_move = "<localleader>sn",
    mark_motion = "<localleader>mc",
    mark_visual = "<localleader>mc",
    remove_mark = "<localleader>md",
    cr = "<localleader>s<cr>",
    interrupt = "<localleader>s<space>",
    exit = "<localleader>sq",
    clear = "<localleader>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<localleader>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<localleader>rh', '<cmd>IronHide<cr>')

-- guttermarks configuration
vim.pack.add { "https://github.com/dimtion/guttermarks.nvim" }
require("guttermarks").setup {
    global_mark = { enabled = false },
}


vim.pack.add{ "https://github.com/github/copilot.vim",
"https://github.com/dense-analysis/ale",
"https://github.com/kien/ctrlp.vim",
"https://github.com/rktjmp/lush.nvim",
"https://github.com/preservim/nerdtree",
"https://github.com/neovim/nvim-lspconfig",
"https://github.com/tmhedberg/simpylfold",
"https://github.com/godlygeek/tabular",
"https://github.com/SirVer/ultisnips",
"https://github.com/EgZvor/vim-black",
"https://github.com/tpope/vim-commentary",
"https://github.com/tpope/vim-dispatch",
"https://github.com/tpope/vim-fugitive",
"https://github.com/jeetsukumaran/vim-pythonsense",
"https://github.com/tpope/vim-repeat",
"https://github.com/tpope/vim-surround",
"https://github.com/lervag/vimtex",
"https://github.com/zenbones-theme/zenbones.nvim" }
