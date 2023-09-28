return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        clangd = {},
        jsonls = {
          mason = false,
        },
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                -- linter
                flake8 = { enabled = true },
                pycodestyle = { enabled = false },
                -- type checker
                pylsp_mypy = { enabled = true },
                -- auto-completion options
                jedi_completion = { fuzzy = true },
              },
            },
          },
        },
      },
      setup = {
        clangd = function(_, opts)
          opts.cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion",
            "never",
          }
        end,
      },
    },
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "clangd",
        "clang-format",
        "go-debug-adapter",
        "gopls",
        "rust-analyzer",
        "rustfmt",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
}
