return {
  "epwalsh/obsidian.nvim",
  enabled = true,
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "/vaults/personal/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
  },
  config = function(_, opts)
    -- Setup obsidian.nvim
    require("obsidian").setup(opts)
    -- Create which-key mappings for common commands.
    local wk = require("which-key")
    wk.add({
      { "<leader>o", group = "Obsidian" },
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open note" },
      { "<leader>od", "<cmd>ObsidianDailies -10 0<cr>", desc = "Daily notes" },
      { "<leader>op", "<cmd>ObsidianPasteImg<cr>", desc = "Paste image" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", desc = "Quick switch" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search" },
      { "<leader>ot", "<cmd>ObsidianTags<cr>", desc = "Tags" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>om", "<cmd>ObsidianTemplate<cr>", desc = "Template" },
      { "<leader>on", "<cmd>ObsidianQuickSwitch nav<cr>", desc = "Nav" },
      { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename" },
      { "<leader>oc", "<cmd>ObsidianTOC<cr>", desc = "Contents (TOC)" },
      { "<leader>ox", desc = "Toggle checkbox" },
      {
        "<leader>ow",
        function()
          local Note = require("obsidian.note")
          ---@type obsidian.Client
          local client = require("obsidian").get_client()
          assert(client)

          local picker = client:picker()
          if not picker then
            client.log.err("No picker configured")
            return
          end

          ---@param dt number
          ---@return obsidian.Path
          local function weekly_note_path(dt)
            return client.dir / os.date("notes/weekly/week-of-%Y-%m-%d.md", dt)
          end

          ---@param dt number
          ---@return string
          local function weekly_alias(dt)
            local alias = os.date("Week of %A %B %d, %Y", dt)
            assert(type(alias) == "string")
            return alias
          end

          local day_of_week = os.date("%A")
          assert(type(day_of_week) == "string")

          ---@type integer
          local offset_start
          if day_of_week == "Sunday" then
            offset_start = 1
          elseif day_of_week == "Monday" then
            offset_start = 0
          elseif day_of_week == "Tuesday" then
            offset_start = -1
          elseif day_of_week == "Wednesday" then
            offset_start = -2
          elseif day_of_week == "Thursday" then
            offset_start = -3
          elseif day_of_week == "Friday" then
            offset_start = -4
          elseif day_of_week == "Saturday" then
            offset_start = 2
          end
          assert(offset_start)

          local current_week_dt = os.time() + (offset_start * 3600 * 24)
          ---@type obsidian.PickerEntry
          local weeklies = {}
          for week_offset = 1, -2, -1 do
            local week_dt = current_week_dt + (week_offset * 3600 * 24 * 7)
            local week_alias = weekly_alias(week_dt)
            local week_display = week_alias
            local path = weekly_note_path(week_dt)

            if week_offset == 0 then
              week_display = week_display .. " @current"
            elseif week_offset == 1 then
              week_display = week_display .. " @next"
            elseif week_offset == -1 then
              week_display = week_display .. " @last"
            end

            if not path:is_file() then
              week_display = week_display .. " ➡️ create"
            end

            weeklies[#weeklies + 1] = {
              value = week_dt,
              display = week_display,
              ordinal = week_display,
              filename = tostring(path),
            }
          end

          picker:pick(weeklies, {
            prompt_title = "Weeklies",
            callback = function(dt)
              local path = weekly_note_path(dt)
              ---@type obsidian.Note
              local note
              if path:is_file() then
                note = Note.from_file(path)
              else
                note = client:create_note({
                  id = path.name,
                  dir = path:parent(),
                  title = weekly_alias(dt),
                  tags = { "weekly-notes" },
                })
              end
              client:open_note(note)
            end,
          })
        end,
        desc = "Weeklies",
      },
      {
        mode = { "v" },
        {
          "<leader>oe",
          function()
            local title = vim.fn.input({ prompt = "Enter title (optional): " })
            vim.cmd("ObsidianExtractNote " .. title)
          end,
          desc = "Extract text into new note",
        },
        {
          "<leader>ol",
          function()
            vim.cmd("ObsidianLink")
          end,
          desc = "Link text to an existing note",
        },
        {
          "<leader>on",
          function()
            vim.cmd("ObsidianLinkNew")
          end,
          desc = "Link text to a new note",
        },
        {
          "<leader>ot",
          function()
            vim.cmd("ObsidianTags")
          end,
          desc = "Tags",
        },
      },
    })
  end,
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
    },

    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "notes/daily",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, default tags to add to each new daily note created.
      default_tags = { "daily-notes" },
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = nil,
    },

    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ox"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- Smart action depending on context, either follow link or toggle checkbox.
      ["<cr>"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    new_notes_location = "notes_subdir",

    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,

    ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    ---@return string|obsidian.Path The full path to the new note.
    note_path_func = function(spec)
      -- This is equivalent to the default behavior.
      local path = spec.dir / tostring(spec.id)
      return path:with_suffix(".md")
    end,

    wiki_link_func = "prepend_note_id",

    templates = {
      folder = "Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    ---@param url string
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ "open", url }) -- Mac OS
      -- vim.fn.jobstart({"xdg-open", url})  -- linux
      -- vim.cmd(':silent exec "!start ' .. url .. '"') -- Windows
      -- vim.ui.open(url) -- need Neovim 0.10.0+
    end,

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = "fzf-lua",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-n>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },

    -- Optional, sort search results by "path", "modified", "accessed", or "created".
    -- The recommend value is "modified" and `true` for `sort_reversed`, which means, for example,
    -- that `:ObsidianQuickSwitch` will show the notes sorted by latest modified time
    sort_by = "modified",
    sort_reversed = true,

    -- Set the maximum number of lines to read from notes on disk when performing certain searches.
    search_max_lines = 1000,

    -- 1. "current" (the default) - to always open in the current window
    -- 2. "vsplit" - to open in a vertical split if there's not already a vertical split
    -- 3. "hsplit" - to open in a horizontal split if there's not already a horizontal split
    open_notes_in = "current",

    -- Specify how to handle attachments.
    attachments = {
      -- The default folder to place images in via `:ObsidianPasteImg`.
      -- If this is a relative path it will be interpreted as relative to the vault root.
      -- You can always override this per image by passing a full path to the command instead of just a filename.
      img_folder = "assets/imgs", -- This is the default

      -- Optional, customize the default name or prefix when pasting images via `:ObsidianPasteImg`.
      ---@return string
      img_name_func = function()
        ---@type obsidian.Client
        local client = require("obsidian").get_client()

        local note = client:current_note()
        if note then
          return string.format("%s-", note.id)
        else
          return string.format("%s-", os.time())
        end
      end,

      -- A function that determines the text to insert in the note when pasting an image.
      -- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
      -- This is the default implementation.
      ---@param client obsidian.Client
      ---@param path obsidian.Path the absolute path to the image file
      ---@return string
      img_text_func = function(client, path)
        path = client:vault_relative_path(path) or path
        return string.format("![%s](%s)", path.name, path)
      end,
    },
    ui = {
      enable = false,
    },
  },
}
