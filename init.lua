-- sourcing my vimrc
local vimrc = "~/.vimrc"
vim.cmd.source(vimrc)


-- lualine.nvim
vim.cmd("packadd lualine.nvim")
require('lualine').setup {
    options = { theme = 'horizon' },
    tabline = {
        lualine_a = {'buffers'},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {'tabs'}
    }
}
