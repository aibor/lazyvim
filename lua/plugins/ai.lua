local codecompanion_default_adapter = vim.env.OPENWEBUI_URL and "openwebui" or "mistral"
local codecompanion_api_key_cached = ""

-- Retrieves the API key for the given adapter from the system's secret storage.
-- If the key is not already cached, it fetches it using the 'secret-tool' command.
-- @param adapter: The adapter object containing the name of the adapter.
-- @return: The API key as a string.
local function codecompanion_api_key(adapter)
  if codecompanion_api_key_cached == "" then
    codecompanion_api_key_cached = vim.fn.system({
      "secret-tool",
      "lookup",
      "api_key",
      adapter.name,
    })
  end

  return codecompanion_api_key_cached
end

return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      table.insert(opts.spec, 0, { "<leader>a", group = "ai" })
    end,
  },
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    cmd = {
      "CodeCompanion",
      "CodeCompanionActions",
      "CodeCompanionChat",
      "CodeCompanionCmd",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<CR>", desc = "CodeCompanion Actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<CR>", desc = "CodeCompanion Toggle Chat" },
      { "<leader>ar", "<cmd>CodeCompanionChat RefreshCache<CR>", desc = "CodeCompanion Refresh Chat" },
      { "<leader>aa", "<cmd>CodeCompanionChat Add<CR>", mode = "v", desc = "CodeCompanion Add to Chat" },
    },
    opts = {
      interactions = {
        chat = {
          adapter = codecompanion_default_adapter,
        },
        inline = {
          adapter = codecompanion_default_adapter,
          keymaps = {
            accept_change = {
              modes = { n = "<leader>ada" }, -- Remember this as DiffAccept
            },
            reject_change = {
              modes = { n = "<leader>adr" }, -- Remember this as DiffReject
            },
            always_accept = {
              modes = { n = "<leader>ady" }, -- Remember this as DiffYolo
            },
            stop = {
              modes = { n = "<leader>as" },
            },
          },
        },
        cmd = {
          adapter = codecompanion_default_adapter,
        },
      },
      adapters = {
        acp = {
          opts = {
            show_presets = false,
          },
        },
        http = {
          opts = {
            show_presets = false,
            show_model_choices = true,
          },
          mistral = function()
            return require("codecompanion.adapters").extend("mistral", {
              opts = {
                stream = true,
                tools = true,
                vision = false,
              },
              env = {
                api_key = codecompanion_api_key,
              },
            })
          end,
          -- https://github.com/olimorris/codecompanion.nvim/discussions/790#discussioncomment-14269215
          openwebui = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              name = "openwebui",
              formatted_name = "OpenWebUI",
              opts = {
                stream = true,
                tools = true,
                vision = false,
              },
              url = "${url}${chat_url}",
              env = {
                api_key = codecompanion_api_key,
                url = "OPENWEBUI_URL",
                chat_url = "/api/chat/completions", -- from docs
                models_endpoint = "/api/models",
              },
              headers = {
                ["Content-Type"] = "application/json",
                Authorization = "Bearer ${api_key}",
              },
              schema = {
                model = {
                  default = "gpt-oss:120b",
                },
              },
            })
          end,
        },
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    optional = true,
    opts = {
      file_types = { "markdown", "codecompanion" },
    },
    ft = { "markdown", "codecompanion" },
  },
}
