return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "f-person/auto-dark-mode.nvim",
    commit = "02ef955",
    lazy = false,
    priority = 1000,
    opts = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.api.nvim_set_option_value("background", "dark", {})
        vim.cmd.colorscheme("catppuccin-macchiato")
      end,
      set_light_mode = function()
        vim.api.nvim_set_option_value("background", "light", {})
        vim.cmd.colorscheme("catppuccin-latte")
      end,
    },
    fallback = "dark",
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    opts = {
      flavour = "auto", -- latte, frappe, macchiato, mocha
      background = { -- :h background
        light = "latte",
        dark = "macchiato",
      },
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      transparent_background = false, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      styles = {
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
      },
      color_overrides = {
        latte = {
          rosewater = "#cc7983",
          flamingo = "#bb5d60",
          pink = "#d54597",
          mauve = "#a65fd5",
          red = "#b7242f",
          maroon = "#db3e68",
          peach = "#e46f2a",
          yellow = "#bc8705",
          green = "#1a8e32",
          teal = "#00a390",
          sky = "#089ec0",
          sapphire = "#0ea0a0",
          blue = "#017bca",
          lavender = "#8584f7",
          text = "#444444",
          subtext1 = "#555555",
          subtext0 = "#666666",
          overlay2 = "#777777",
          overlay1 = "#888888",
          overlay0 = "#999999",
          surface2 = "#aaaaaa",
          surface1 = "#dddddd",
          surface0 = "#cccccc",
          base = "#ffffff",
          mantle = "#eeeeee",
          crust = "#dddddd",
        },
        frappe = {},
        macchiato = {},
        mocha = {},
      },
      integrations = {
        aerial = true,
        alpha = true,
        blink_cmp = true,
        cmp = true,
        diffview = true,
        flash = true,
        gitsigns = true,
        grug_far = true,
        harpoon = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        fzf = true,
        leap = true,
        lsp_trouble = true,
        mason = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        semantic_tokens = true,
        snacks = {
          enabled = true,
          indent_scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
        },
        telescope = true,
        treesitter = true,
        which_key = true,
      },
    },
  },
}
