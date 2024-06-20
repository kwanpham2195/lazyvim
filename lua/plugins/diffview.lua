local M = {
  "sindrets/diffview.nvim",
  keys = {
    { "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "Open" },
    { "<leader>gdx", "<cmd>set hidden<cr><cmd>DiffviewClose<cr><cmd>set nohidden<cr>", desc = "Close" },
    { "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "History current file" },
    { "<leader>gdb", "<cmd>DiffviewFileHistory<cr>", desc = "History current branch" },
  },
  config = function()
    local actions = require("diffview.actions")
    require("diffview").setup({
      view = {
        default = {
          layout = "diff2_horizontal",
        },
        merge_tool = {
          layout = "diff3_mixed",
        },
      },
      keymaps = {
        disable_defaults = true, -- Disable the default keymaps
        view = {
          {
            "n",
            "<leader>gx",
            actions.cycle_layout,
            { desc = "Cycle through available layouts." },
          },
          { "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          {
            "n",
            "<s-tab>",
            actions.select_prev_entry,
            { desc = "Open the diff for the previous file" },
          },
          {
            "n",
            "[x",
            actions.prev_conflict,
            { desc = "In the merge-tool: jump to the previous conflict" },
          },
          {
            "n",
            "]x",
            actions.next_conflict,
            { desc = "In the merge-tool: jump to the next conflict" },
          },
          {
            "n",
            "<leader>gdo",
            actions.conflict_choose("ours"),
            { desc = "Choose the OURS version of a conflict" },
          },
          {
            "n",
            "<leader>gdt",
            actions.conflict_choose("theirs"),
            { desc = "Choose the THEIRS version of a conflict" },
          },
          {
            "n",
            "<leader>gdb",
            actions.conflict_choose("base"),
            { desc = "Choose the BASE version of a conflict" },
          },
          {
            "n",
            "<leader>gda",
            actions.conflict_choose("all"),
            { desc = "Choose all the versions of a conflict" },
          },

          {
            "n",
            "<leader>gdO",
            actions.conflict_choose_all("ours"),
            { desc = "Choose the OURS version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>gdT",
            actions.conflict_choose_all("theirs"),
            { desc = "Choose the THEIRS version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>gdB",
            actions.conflict_choose_all("base"),
            { desc = "Choose the BASE version of a conflict for the whole file" },
          },
          {
            "n",
            "<leader>gdA",
            actions.conflict_choose_all("all"),
            { desc = "Choose all the versions of a conflict for the whole file" },
          },
        },
        diff1 = {
          -- Mappings in single window diff layouts
          { "n", "g?", actions.help({ "view", "diff1" }), { desc = "Open the help panel" } },
        },
        diff2 = {
          -- Mappings in 2-way diff layouts
          { "n", "g?", actions.help({ "view", "diff2" }), { desc = "Open the help panel" } },
        },
        diff3 = {
          -- Mappings in 3-way diff layouts
          { "n", "g?", actions.help({ "view", "diff3" }), { desc = "Open the help panel" } },
        },
        file_panel = {
          {
            "n",
            "j",
            actions.next_entry,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "<down>",
            actions.next_entry,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "k",
            actions.prev_entry,
            { desc = "Bring the cursor to the previous file entry" },
          },
          {
            "n",
            "<up>",
            actions.prev_entry,
            { desc = "Bring the cursor to the previous file entry" },
          },
          {
            "n",
            "<cr>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry" },
          },
          {
            "n",
            "o",
            actions.select_entry,
            { desc = "Open the diff for the selected entry" },
          },
          {
            "n",
            "<2-LeftMouse>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry" },
          },
          { "n", "L", actions.open_commit_log, { desc = "Open the commit log panel" } },
          { "n", "zo", actions.open_fold, { desc = "Expand fold" } },
          { "n", "h", actions.close_fold, { desc = "Collapse fold" } },
          { "n", "zc", actions.close_fold, { desc = "Collapse fold" } },
          { "n", "za", actions.toggle_fold, { desc = "Toggle fold" } },
          { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
          { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
          {
            "n",
            "<tab>",
            actions.select_next_entry,
            { desc = "Open the diff for the next file" },
          },
          {
            "n",
            "<s-tab>",
            actions.select_prev_entry,
            { desc = "Open the diff for the previous file" },
          },
          {
            "n",
            "R",
            actions.refresh_files,
            { desc = "Update stats and entries in the file list" },
          },
          { "n", "g?", actions.help("file_panel"), { desc = "Open the help panel" } },
        },
        file_history_panel = {
          { "n", "g!", actions.options, { desc = "Open the option panel" } },
          {
            "n",
            "<C-A-d>",
            actions.open_in_diffview,
            { desc = "Open the entry under the cursor in a diffview" },
          },
          {
            "n",
            "y",
            actions.copy_hash,
            { desc = "Copy the commit hash of the entry under the cursor" },
          },
          { "n", "L", actions.open_commit_log, { desc = "Show commit details" } },
          { "n", "zR", actions.open_all_folds, { desc = "Expand all folds" } },
          { "n", "zM", actions.close_all_folds, { desc = "Collapse all folds" } },
          {
            "n",
            "j",
            actions.next_entry,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "<down>",
            actions.next_entry,
            { desc = "Bring the cursor to the next file entry" },
          },
          {
            "n",
            "k",
            actions.prev_entry,
            { desc = "Bring the cursor to the previous file entry." },
          },
          {
            "n",
            "<up>",
            actions.prev_entry,
            { desc = "Bring the cursor to the previous file entry." },
          },
          {
            "n",
            "<cr>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry." },
          },
          {
            "n",
            "<2-LeftMouse>",
            actions.select_entry,
            { desc = "Open the diff for the selected entry." },
          },
          { "n", "<tab>", actions.select_next_entry, { desc = "Open the diff for the next file" } },
          {
            "n",
            "<s-tab>",
            actions.select_prev_entry,
            { desc = "Open the diff for the previous file" },
          },
          { "n", "g?", actions.help("file_history_panel"), { desc = "Open the help panel" } },
        },
        option_panel = {
          { "n", "<tab>", actions.select_entry, { desc = "Change the current option" } },
          { "n", "q", actions.close, { desc = "Close the panel" } },
          { "n", "g?", actions.help("option_panel"), { desc = "Open the help panel" } },
        },
        help_panel = {
          { "n", "q", actions.close, { desc = "Close help menu" } },
          { "n", "<esc>", actions.close, { desc = "Close help menu" } },
        },
      },
    })
  end,
}

return M
