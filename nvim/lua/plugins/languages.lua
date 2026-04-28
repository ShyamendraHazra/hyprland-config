return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        -- frontend
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "json",

        -- systems
        "c",
        "cpp",
        "zig",

        -- core
        "lua",
        "bash",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- frontend
        html = {},

        cssls = {
          settings = {
            css = { validate = true },
            scss = { validate = true },
            less = { validate = true },
          },
        },

        tailwindcss = {},

        emmet_language_server = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "vue",
          },
        },

        ts_ls = {},
        eslint = {},
        jsonls = {},

        -- systems
        clangd = {},
        zls = {},
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}

      vim.list_extend(opts.ensure_installed, {
        -- frontend
        "html-lsp",
        "css-lsp",
        "tailwindcss-language-server",
        "emmet-language-server",
        "typescript-language-server",
        "eslint-lsp",
        "json-lsp",
        "prettier",

        -- systems
        "clangd",
        "clang-format",
        "zls",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },

        c = { "clang-format" },
        cpp = { "clang-format" },
        zig = { "zigfmt" },
      },
    },
  },

  {
    "catgoose/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("colorizer").setup({
        "css",
        "scss",
        "html",
        "javascript",
        "typescript",
        "lua",
      }, {
        RGB = true,
        RRGGBB = true,
        RRGGBBAA = true,
        names = true,
        rgb_fn = true,
        hsl_fn = true,
        css = true,
        css_fn = true,
      })
    end,
  },
}
