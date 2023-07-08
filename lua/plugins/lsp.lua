-- override keymaps for lsp
return {
  "neovim/nvim-lspconfig",
  init = function()
    local keymaps = require("lazyvim.plugins.lsp.keymaps")
    local keys = keymaps.get()
    keys = {
      { "<leader>lD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
      { "<leader>ll", vim.diagnostic.open_float, desc = "Line Diagnostics" },
      { "<leader>li", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "<leader>ld", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" },
      { "<leader>lr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
      { "<leader>lI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
      { "<leader>lt", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto Type Definition" },
      { "<leader>lk", vim.lsp.buf.hover, desc = "Hover" },
      { "<leader>lS", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
      { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
      { "<leader>ln", vim.diagnostic.goto_next, desc = "Next Diagnostic" },
      { "<leader>lp", vim.diagnostic.goto_prev, desc = "Prev Diagnostic" },
      { "<leader>la", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
      { "<leader>le", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
      { "<leader>lq", vim.diagnostic.setloclist, desc = "Diagnostics in qflist" },
      { "<leader>lws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", desc = "Workspace Symbols" },
      { "<leader>lwd", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Symbols" },
      { "<leader>lwa", vim.lsp.buf.add_workspace_folder, desc = "Add Folder" },
      { "<leader>lwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>", desc = "List Folders" },
      { "<leader>lwr", vim.lsp.buf.remove_workspace_folder, desc = "Remove Folder" },
    }
    if require("lazyvim.util").has("inc-rename.nvim") then
      keys[#keys + 1] = {
        "<leader>lR",
        function()
          local inc_rename = require("inc_rename")
          return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
        end,
        expr = true,
        desc = "Rename",
        has = "rename",
      }
    else
      keys[#keys + 1] = { "<leader>lR", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
    end
    require("lazyvim.plugins.lsp.keymaps")._keys = keys
  end,
}
