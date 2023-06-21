return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Formatter
      "black",
      "prettierd",
      "stylua",
      "shfmt",
      -- Linter
      "eslint_d",
      "shellcheck",
      "tflint",
      "yamllint",
    },
  },
}
