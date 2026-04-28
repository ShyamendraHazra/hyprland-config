-- ~/.config/nvim/lua/plugins/avante.lua
return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- use latest
    build = "make",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "stevearc/dressing.nvim",
      "zbirenbaum/copilot.lua", -- optional if using Copilot provider
      "MeanderingProgrammer/render-markdown.nvim",
      "HakonHarnes/img-clip.nvim",
    },

    opts = {
      provider = "ollama", -- change to claude/openai/copilot if needed

      providers = {
        ollama = {
          endpoint = "http://127.0.0.1:11434",
          model = "qwen2.5-coder:7b", -- or deepseek-coder / codellama
          timeout = 30000,
          temperature = 0,
          max_tokens = 4096,
        },

        openai = {
          endpoint = "https://api.openai.com/v1",
          model = "gpt-5.4-mini",
          timeout = 30000,
          temperature = 0,
          max_tokens = 4096,
        },

        claude = {
          endpoint = "https://api.anthropic.com",
          model = "claude-sonnet-4",
          timeout = 30000,
          temperature = 0,
          max_tokens = 4096,
        },
      },

      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = false,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = true,
      },

      windows = {
        position = "right",
        width = 42,
        wrap = true,
        sidebar_header = {
          enabled = true,
          align = "center",
          rounded = true,
        },
      },

      mappings = {
        ask = "<leader>aa",
        edit = "<leader>ae",
        refresh = "<leader>ar",
        focus = "<leader>af",
        stop = "<leader>as",
      },
    },

    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<cr>", desc = "Avante Ask" },
      { "<leader>ae", "<cmd>AvanteEdit<cr>", desc = "Avante Edit" },
      { "<leader>af", "<cmd>AvanteFocus<cr>", desc = "Avante Focus" },
      { "<leader>ar", "<cmd>AvanteRefresh<cr>", desc = "Avante Refresh" },
      { "<leader>as", "<cmd>AvanteStop<cr>", desc = "Avante Stop" },
    },
  },
}
