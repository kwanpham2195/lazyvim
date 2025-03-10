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
        provider = "codestral",
        n_completions = 1,
        add_single_line_entry = false,
        virtualtext = {
          auto_trigger_ft = { "go" },
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
    opts = {
      model = "claude-3.5-sonnet",
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
    enabled = false,
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
      mappings = {
        ask = prefix .. "<CR>",
        edit = prefix .. "e",
        refresh = prefix .. "r",
        focus = prefix .. "f",
        toggle = {
          default = prefix .. "t",
          debug = prefix .. "d",
          hint = prefix .. "h",
          suggestion = prefix .. "s",
          repomap = prefix .. "R",
        },
        diff = {
          next = "]c",
          prev = "[c",
        },
        files = {
          add_current = prefix .. ".",
        },
      },
      behaviour = {
        auto_suggestions = false,
      },
      provider = "copilot",
      copilot = {
        model = "o3-mini",
        temperature = 0,
        max_tokens = 8192,
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    -- dynamically build it, taken from astronvim
    build = vim.fn.has("win32") == 1 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
      or "make",
    dependencies = {
      -- "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = {
          -- make sure rendering happens even without opening a markdown file first
          "yetone/avante.nvim",
        },
        opts = function(_, opts)
          opts.file_types = opts.file_types or { "markdown", "norg", "rmd", "org" }
          vim.list_extend(opts.file_types, { "Avante" })
        end,
      },
    },
  },
}
