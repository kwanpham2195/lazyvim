return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  spec = {
    defaults = {
      ["<leader>h"] = { name = "+harpoon" },
      ["<leader>gd"] = { name = "+diffview" },
      ["<leader>gh"] = { name = "+gitsign" },
    },
  },
}
