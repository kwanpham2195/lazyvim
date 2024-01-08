return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup({})
    -- REQUIRED

    vim.keymap.set("n", "<leader>ha", function()
      harpoon:list():append()
    end, { desc = "Add file" })
    vim.keymap.set("n", "<leader>hm", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = "Toggle quick menu" })

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>h[", function()
      harpoon:list():prev()
    end, { desc = "Previous" })

    vim.keymap.set("n", "<leader>h[", function()
      harpoon:list():next()
    end, { desc = "Next" })
  end,
}
