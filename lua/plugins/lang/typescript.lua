return {
  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = { "jose-elias-alvarez/typescript.nvim" },
    opts = {
      servers = {
        ---@type lspconfig.options.tsserver
        tsserver = {
          keys = {
            { "<leader>lo", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
            { "<leader>lR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
          },
        },
      },
    },
  },
}
