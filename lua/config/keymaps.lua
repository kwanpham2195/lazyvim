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

-- paste over currently selected text without yanking it
map("v", "p", '"_dp')
map("v", "P", '"_dP')

-- tmux navigation
if not vim.g.vscode then
  map("n", "<C-h>", "<cmd>lua require('Navigator').left()<CR>", { noremap = true, silent = true })
  map("n", "<C-k>", "<cmd>lua require('Navigator').up()<CR>", { noremap = true, silent = true })
  map("n", "<C-l>", "<cmd>lua require('Navigator').right()<CR>", { noremap = true, silent = true })
  map("n", "<C-j>", "<cmd>lua require('Navigator').down()<CR>", { noremap = true, silent = true })
end

-- By default, CTRL-U and CTRL-D scroll by half a screen (50% of the window height)
-- Scroll by 35% of the window height and keep the cursor centered
local scroll_percentage = 0.35
-- Scroll by a percentage of the window height and keep the cursor centered
vim.keymap.set("n", "<C-d>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "jzz")
end, { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", function()
  local lines = math.floor(vim.api.nvim_win_get_height(0) * scroll_percentage)
  vim.cmd("normal! " .. lines .. "kzz")
end, { noremap = true, silent = true })

-- When jumping with ctrl+d and u the cursors stays in the middle
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

map("n", "<leader>gb", function()
  Snacks.git.blame_line()
end, { desc = "Git Blame Line" })

-- Copy file paths
map("n", "<leader>yp", "<cmd>CopyRelPath<CR>", { desc = "Yank relative path" })
map("n", "<leader>yP", "<cmd>CopyAbsPath<CR>", { desc = "Yank absolute path" })
