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
      "shellcheck",
      "tflint",
      "yamllint",
    },
  },
}
