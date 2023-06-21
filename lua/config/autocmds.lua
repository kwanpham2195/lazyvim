-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Copy relative path to clipboard
vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.fnamemodify(vim.fn.expand("%"), ":.")
  vim.api.nvim_call_function("setreg", { "+", path })
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
