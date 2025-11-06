-- Luacheck configuration for Neovim
-- Ignore warnings about global variables that are defined by Neovim/LazyVim

-- Allow these globals to be read
globals = {
  "vim",
  "LazyVim",
  "Snacks",
}

-- Don't report unused self arguments for functions
self = false

-- Allow accessing undefined globals
std = "luajit"
