-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- Copy relative path to clipboard
vim.api.nvim_create_user_command("CopyRelPath", function()
  local path = vim.fn.expand("%:.")
  vim.api.nvim_call_function("setreg", { "+", path })
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

-- Copy absolute path to clipboard
vim.api.nvim_create_user_command("CopyAbsPath", function()
  local path = vim.fn.expand("%:p")
  vim.api.nvim_call_function("setreg", { "+", path })
  vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesActionRename",
  callback = function(event)
    Snacks.rename.on_rename_file(event.data.from, event.data.to)
  end,
})
