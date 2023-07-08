return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      -- Formatter
      "stylua",
      "shfmt",
      -- Linter
      "shellcheck",
    },
  },
}
