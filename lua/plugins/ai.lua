return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "BufReadPre",
    enabled = false,
    config = function()
      require("minuet").setup({
        -- Your configuration options here
        provider = "gemini",
        n_completions = 1,
        add_single_line_entry = false,
        virtualtext = {
          auto_trigger_ft = { "go", "md", "lua" },
          auto_trigger_ignore_ft = {},
          keymap = {
            -- accept whole completion
            accept = "<A-y>",
            -- accept one line
            accept_line = "<A-a>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<A-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<A-[>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<A-]>",
            dismiss = "<A-e>",
          },
        },
        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM", -- Please Don't change this, just use TERM should be fine.
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:7b",
            optional = {
              max_tokens = 256,
              top_p = 0.9,
            },
          },
          codestral = {
            optional = {
              max_tokens = 256,
              stop = { "\n\n" },
            },
          },
          gemini = {
            model = "gemini-2.0-flash",
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
              },
              safetySettings = {
                {
                  -- HARM_CATEGORY_HATE_SPEECH,
                  -- HARM_CATEGORY_HARASSMENT
                  -- HARM_CATEGORY_SEXUALLY_EXPLICIT
                  category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                  -- BLOCK_NONE
                  threshold = "BLOCK_ONLY_HIGH",
                },
              },
            },
          },
        },
      })
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    enabled = false,
    dependencies = {
      "stevearc/dressing.nvim",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    opts = {
      -- Default configuration
      hints = { enabled = false },

      ---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "deepseek",
      auto_suggestions_provider = nil,
      copilot = {
        model = "gpt-4o",
        temperature = 0,
        max_tokens = 8192,
      },
      openai = {
        model = "o3-mini",
        reasoning_effort = "high", -- low|medium|high, only used for reasoning models
      },
      vendors = {
        openrouter = {
          __inherited_from = "openai",
          endpoint = "https://openrouter.ai/api/v1",
          api_key_name = "OPENROUTER_API_KEY",
          model = "google/gemini-2.5-pro-exp-03-25:free",
        },
        deepseek = {
          __inherited_from = "openai",
          api_key_name = "DEEPSEEK_API_KEY",
          endpoint = "https://api.deepseek.com",
          model = "deepseek-chat",
          max_tokens = 8192,
        },
      },
      web_search_engine = {
        provider = "google", -- tavily, serpapi, searchapi, google or kagi
      },

      -- File selector configuration
      --- @alias FileSelectorProvider "native" | "fzf" | "mini.pick" | "snacks" | "telescope" | string
      file_selector = {
        provider = "snacks", -- Avoid native provider issues
        provider_opts = {},
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        enable_cursor_planning_mode = true,
        enable_token_counting = false, -- Whether to enable token counting. Default to true.
      },
      suggestion = {
        debounce = 600,
        throttle = 600,
      },
      windows = {
        width = 40,
      },
    },
    build = LazyVim.is_win() and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" or "make",
  },
  {
    "saghen/blink.cmp",
    lazy = true,
    dependencies = { "saghen/blink.compat" },
    opts = {
      sources = {
        default = { "avante_commands", "avante_mentions", "avante_files" },
        compat = {
          "avante_commands",
          "avante_mentions",
          "avante_files",
        },
        -- LSP score_offset is typically 60
        providers = {
          avante_commands = {
            name = "avante_commands",
            module = "blink.compat.source",
            score_offset = 90,
            opts = {},
          },
          avante_files = {
            name = "avante_files",
            module = "blink.compat.source",
            score_offset = 100,
            opts = {},
          },
          avante_mentions = {
            name = "avante_mentions",
            module = "blink.compat.source",
            score_offset = 1000,
            opts = {},
          },
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    ft = function(_, ft)
      vim.list_extend(ft, { "Avante" })
    end,
    opts = function(_, opts)
      opts.file_types = vim.list_extend(opts.file_types or {}, { "Avante" })
    end,
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      spec = {
        { "<leader>a", group = "ai" },
      },
    },
  },
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "BufReadPost",
    opts = {
      copilot_model = "gpt-4o-copilot",
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completion = true,
        debounce = 75,
        keymap = {
          accept = "<A-y>",
          accept_word = false,
          accept_line = "<A-a>",
          next = "<A-]>",
          prev = "<A-[>",
          dismiss = "<A-e>",
        },
      },
      panel = { enabled = false },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    enabled = false,
    opts = {
      model = "claude-3.7-sonnet",
      mappings = {
        reset = {
          normal = "<C-r>",
          insert = "<C-r>",
        },
        toggle_sticky = {
          normal = "grr",
        },
      },
    },
  },
}
