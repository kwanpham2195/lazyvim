-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

-- disable keymap lazy of LazyVim
map("n", "<leader>l", "<Nop>")

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- tmux navigation
map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>", { noremap = true, silent = true })
map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", { noremap = true, silent = true })
map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>", { noremap = true, silent = true })
map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", { noremap = true, silent = true })
