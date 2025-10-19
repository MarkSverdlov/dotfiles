-- sourcing my vimrc
local vimrc = "~/dotfiles/kitty-scrollback-nvim.vim"
vim.cmd.source(vimrc)

vim.cmd("packadd kitty-scrollback.nvim")
require("kitty-scrollback").setup()
