return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      mappings = {
        -- conflict with flash.nvim
        ["s"] = "noop",
        ["S"] = "noop",
        -- use different binding
        ["|"] = "open_vsplit",
        ["-"] = "open_split",
      },
    },
  },
}
