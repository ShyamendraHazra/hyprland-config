
-- File: lua/plugins/debugger.lua
-- Description: Comprehensive Neovim DAP setup using Lazy.nvim
-- Supports: C/C++ (via CodeLLDB), Rust, Python, PHP, JavaScript/TypeScript, and Lua
-- Dependencies: All official or actively maintained adapters
-- No Mason or Meson; executables are detected automatically
-- Includes UI controls, inline virtual text, REPL, hover inspect, and <leader>d keybindings

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Required for async job handling (used by dap)
      "nvim-neotest/nvim-nio",

      -- Full-featured UI (sidebar + REPL + controls)
      "rcarriga/nvim-dap-ui",

      -- Inline text annotations (e.g., variable values next to code)
      "theHamsta/nvim-dap-virtual-text",

      -- Lua adapter (debug Neovim itself)
      {
        "jbyuki/one-small-step-for-vimkind",
        config = false, -- osv does not expose setup()
      },

      -- CodeLLDB adapter for C, C++, and Rust
      {
        "julianolf/nvim-dap-lldb",
        config = function()
          require("dap-lldb").setup({})
        end,
      },

      -- Python adapter
      {
        "mfussenegger/nvim-dap-python",
        config = function()
          require("dap-python").setup("python3")
        end,
      },

      -- JS/TS adapter (vscode-js-debug)
      {
        "mxsdev/nvim-dap-vscode-js",
        dependencies = {
          {
            "microsoft/vscode-js-debug",
            build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
          },
        },
      },

      -- PHP adapter (requires manual cloning and build)
      {
        name = "vscode-php-debug",
        dir = vim.fn.stdpath("data") .. "/debug_adapters/vscode-php-debug",
        lazy = false,
        enabled = vim.fn.isdirectory(vim.fn.stdpath("data") .. "/debug_adapters/vscode-php-debug") == 1,
        build = "npm install && npm run build",
      },
    },

    config = function()
      local dap   = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      ------------------------------------------------------------------
      -- Keybindings: Debugging workflow (under <leader>d)
      ------------------------------------------------------------------
      local map = function(keys, func, desc)
        vim.keymap.set("n", "<leader>d" .. keys, func, { desc = desc })
      end

      map("c", function() dap.continue(); dapui.open() end, "Continue & Open UI")
      map("t", function() dap.terminate(); dapui.close() end, "Terminate & Close UI")
      map("b", dap.toggle_breakpoint, "Toggle Breakpoint")
      map("u", dapui.toggle, "Toggle DAP UI")
      map("o", dap.step_over, "Step Over")
      map("i", dap.step_into, "Step Into")
      map("O", dap.step_out, "Step Out")
      map("r", dap.run_to_cursor, "Run to Cursor")
      map("h", function() require("dap.ui.widgets").hover() end, "Hover Info")
      map("s", dap.repl.open, "Open REPL")
      map("q", dap.repl.close, "Close REPL")
      map("l", function()
        require("osv").launch({ port = 8086 })
      end, "Launch Lua Debug Server")

      ------------------------------------------------------------------
      -- Breakpoint signs in the gutter
      ------------------------------------------------------------------
      vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "Error" })
      vim.fn.sign_define("DapStopped",    { text = ">", texthl = "Success" })

      ------------------------------------------------------------------
      -- Adapter for CodeLLDB (must be in PATH)
      ------------------------------------------------------------------
      dap.adapters.codelldb = {
        type    = "executable",
        command = "codelldb",
      }

      ------------------------------------------------------------------
      -- Auto-detect C/C++ executables under bin/Linux/*_linux*
      ------------------------------------------------------------------
      dap.configurations.cpp = {
        {
          name    = "Launch C/C++ (CodeLLDB)",
          type    = "codelldb",
          request = "launch",
          program = function()
            local dir = vim.fn.getcwd() .. "/bin/Linux/"
            local exes = vim.fn.glob(dir .. "*_linux*", true, true)
            if vim.tbl_isempty(exes) then
              vim.notify("No executables found in bin/Linux/", vim.log.levels.ERROR)
              return
            end
            return vim.fn.input("Path to executable: ", exes[1], "file")
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          args        = {},
        },
      }
      dap.configurations.c = dap.configurations.cpp

      ------------------------------------------------------------------
      -- Rust configuration: detects binary using cargo metadata
      ------------------------------------------------------------------
      dap.configurations.rust = {
        {
          name    = "Debug Rust (CodeLLDB)",
          type    = "codelldb",
          request = "launch",
          program = function()
            local out = vim.fn.system("cargo metadata --format-version 1 --no-deps")
            local meta = vim.fn.json_decode(out)
            local bin  = meta.target_directory .. "/debug/" .. meta.packages[1].targets[1].name
            return bin
          end,
          cwd         = "${workspaceFolder}",
          stopOnEntry = false,
          args        = {},
        },
      }

      ------------------------------------------------------------------
      -- Lua: attach to a Neovim instance running debug server
      ------------------------------------------------------------------
      dap.adapters.nlua = function(callback)
        local uv = vim.loop
        local sock = uv.new_tcp()
        sock:connect("127.0.0.1", 8086, function(err)
          vim.schedule(function()
            if err then
              vim.notify("Neovim debug server is not running on port 8086", vim.log.levels.ERROR)
            else
              callback({ type = "server", host = "127.0.0.1", port = 8086 })
            end
          end)
          sock:close()
        end)
      end

      dap.configurations.lua = {
        {
          name    = "Attach to running Neovim",
          type    = "nlua",
          request = "attach",
        },
      }

      ------------------------------------------------------------------
      -- PHP: uses manually built vscode-php-debug
      ------------------------------------------------------------------
      dap.adapters.php = {
        type    = "executable",
        command = "node",
        args    = { vim.fn.stdpath("data") .. "/debug_adapters/vscode-php-debug/out/phpDebug.js" },
      }

      dap.configurations.php = {
        {
          type         = "php",
          request      = "launch",
          name         = "Listen for Xdebug",
          port         = 9003,
          pathMappings = { ["/var/www/html"] = "${workspaceFolder}" },
        },
      }

      ------------------------------------------------------------------
      -- JS/TS: set up vscode-js-debug adapters (multiple targets)
      ------------------------------------------------------------------
      require("dap-vscode-js").setup({
        debugger_path = vim.fn.stdpath("data") .. "/lazy/vscode-js-debug",
        adapters      = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal" },
      })

      for _, lang in ipairs({ "javascript", "typescript" }) do
        dap.configurations[lang] = {
          {
            name    = "Launch File",
            type    = "pwa-node",
            request = "launch",
            program = "${file}",
            cwd     = "${workspaceFolder}",
          },
          {
            name      = "Attach to Process",
            type      = "pwa-node",
            request   = "attach",
            processId = require("dap.utils").pick_process,
            cwd       = "${workspaceFolder}",
          },
        }
      end
    end,
  },
}

