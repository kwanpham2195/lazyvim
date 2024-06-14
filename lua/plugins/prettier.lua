return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        prettier = {
          cwd = require("conform.util").root_file({ ".prettierrc", ".prettierrc.json" }),
          require_cwd = true,
        },
      },
    },
  },
}
