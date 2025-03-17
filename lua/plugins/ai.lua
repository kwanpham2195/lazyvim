local prefix = "<Leader>a"
return {
  {
    "milanglacier/minuet-ai.nvim",
    event = "BufReadPre",
    config = function()
      local gemini_prompt = [[
You are the backend of an AI-powered code completion engine. Your task is to
provide code suggestions based on the user's input. The user's code will be
enclosed in markers:

- `<contextAfterCursor>`: Code context after the cursor
- `<cursorPosition>`: Current cursor location
- `<contextBeforeCursor>`: Code context before the cursor
]]

      local gemini_few_shots = {}

      gemini_few_shots[1] = {
        role = "user",
        content = [[
# language: python
<contextBeforeCursor>
def fibonacci(n):
    <cursorPosition>
<contextAfterCursor>

fib(5)]],
      }

      local gemini_chat_input_template =
        "{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}"

      gemini_few_shots[2] = require("minuet.config").default_few_shots[2]
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
            accept = "<Tab>",
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
            system = {
              prompt = gemini_prompt,
            },
            few_shots = gemini_few_shots,
            chat_input = {
              template = gemini_chat_input_template,
            },
            -- stream = true,
            api_key = "GEMINI_API_KEY",
            optional = {
              generationConfig = {
                maxOutputTokens = 256,
                topP = 0.9,
              },
              safetySettings = {
                {
                  category = "HARM_CATEGORY_DANGEROUS_CONTENT",
                  threshold = "BLOCK_NONE",
                },
                {
                  category = "HARM_CATEGORY_HATE_SPEECH",
                  threshold = "BLOCK_NONE",
                },
                {
                  category = "HARM_CATEGORY_HARASSMENT",
                  threshold = "BLOCK_NONE",
                },
                {
                  category = "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                  threshold = "BLOCK_NONE",
                },
              },
            },
          },
        },
      })
    end,
  },
  -- {
  --   "saghen/blink.cmp",
  --   optional = true,
  --   opts = {
  --     keymap = {
  --       ["<A-y>"] = {
  --         function(cmp)
  --           cmp.show({ providers = { "minuet" } })
  --         end,
  --       },
  --     },
  --     sources = {
  --       -- if you want to use auto-complete
  --       default = { "minuet" },
  --       providers = {
  --         minuet = {
  --           name = "minuet",
  --           module = "minuet.blink",
  --           score_offset = 100,
  --         },
  --       },
  --     },
  --   },
  -- },
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    dependencies = {
      "stevearc/dressing.nvim",
      "zbirenbaum/copilot.lua", -- for providers='copilot'
    },
    opts = {
      -- Default configuration
      hints = { enabled = false },

      ---@alias AvanteProvider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "copilot", -- Recommend using Claude
      auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      copilot = {
        model = "claude-3.7-sonnet",
        temperature = 0,
        max_tokens = 8192,
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
}
