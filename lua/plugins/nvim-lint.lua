return {
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = function(_, opts)
      -- Remove golangci-lint from Go linters
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.go = nil
      return opts
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      -- Filter out golangci-lint from ensure_installed
      opts.ensure_installed = opts.ensure_installed or {}
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return tool ~= "golangci-lint"
      end, opts.ensure_installed)
      return opts
    end,
  },
}
