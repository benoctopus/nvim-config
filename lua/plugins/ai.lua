local local_ai = require("util.flags").use_local_ai()

return {
  {
    "yetone/avante.nvim",
    enabled = local_ai,
    opts = function(opts)
      -- vim.g.copilot_proxy = "http://localhost:11435"
      -- vim.g.copilot_proxy_strict_ssl = false
      return vim.tbl_deep_extend("force", opts, {
        -- auto_suggestions_provider = "lmstudiofast",

        build = "nix develop -c make BUILD_FROM_SOURCE=true",
        debug = true,
        behaviour = {
          enable_fastapply = true, -- Enable Fast Apply feature
          -- auto_suggestions = true,
        },
        selection = {
          hint_display = "immediate",
        },

        provider = "ollama",
        providers = {
          ollama = {
            endpoint = "http://127.0.0.1:11434", -- Note that there is no /v1 at the end.
            model = "qwen3.6:35b-a3b-coding-nvfp4",
          },
          lmstudio = {
            __inherited_from = "openai",
            api_key_name = "",
            endpoint = "http://localhost:1234/v1/",
            model = "qwen/qwen3-coder-next",
          },
          lmstudiofast = {
            __inherited_from = "openai",
            api_key_name = "",
            endpoint = "http://localhost:1234/v1/",
            model = "qwen3-coder-30b-a3b-instruct-mlx",
          },
        },
        -- rag_service = { -- RAG Service configuration
        --   enabled = true, -- Enables the RAG service
        --   host_mount = os.getenv("HOME"), -- Host mount path for the rag service (Docker will mount this path)
        --   runner = "docker", -- Runner for the RAG service (can use docker or nix)
        --
        --   llm = { -- Configuration for the Language Model (LLM) used by the RAG service
        --     provider = "ollama", -- The Embedding provider ("ollama")
        --     endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
        --     api_key = "", -- Ollama typically does not require an API key
        --     model = "qwen2.5-coder:7b", -- The Embedding model name (e.g., "nomic-embed-text")
        --     extra = { -- Extra configuration options for the Embed:ding model (optional)
        --       embed_batch_size = 10,
        --     },
        --   },
        --   embed = { -- Configuration for the Embedding Model used by the RAG service
        --     provider = "ollama", -- The Embedding provider ("ollama")
        --     endpoint = "http://localhost:11434", -- The Embedding API endpoint for Ollama
        --     api_key = "", -- Ollama typically does not require an API key
        --     model = "qwen3-embedding:0.6b", -- The Embedding model name (e.g., "nomic-embed-text")
        --     extra = { -- Extra configuration options for the Embedding model (optional)
        --       embed_batch_size = 10,
        --     },
        --   },
        -- },
      })
    end,
  },

  {
    "milanglacier/minuet-ai.nvim",
    enabled = local_ai,
    config = function()
      -- require("vectorcode").setup({
      --   -- number of retrieved documents
      --   n_query = 1,
      -- })
      --
      -- local has_vc, vectorcode_config = pcall(require, "vectorcode.config")
      -- print(has_vc)
      -- print(vectorcode_config)
      -- local vectorcode_cacher = nil
      -- if has_vc then
      --   vectorcode_cacher = vectorcode_config.get_cacher_backend()
      -- end
      -- local RAG_Context_Window_Size = 8000

      require("minuet").setup({
        -- provider = "openai_fim_compatible",
        provider = "openai_compatible",
        provider_options = {
          openai_compatible = {
            api_key = "OPENROUTER_API_KEY",
            end_point = "https://openrouter.ai/api/v1/chat/completions",
            model = "qwen/qwen3-coder",
            name = "Openrouter",
            optional = {
              max_tokens = 1024,
              top_p = 0.9,
              provider = {
                -- Prioritize throughput for faster completion
                sort = "throughput",
              },
              -- disable thinking to avoid first token latency
              reasoning_effort = "none",
            },
          },
          openai_fim_compatible = {
            api_key = function()
              return "lmao"
            end,
            -- template = {
            --   prompt = function(pref, suff, _)
            --     local prompt_message = ""
            --     if has_vc then
            --       for _, file in ipairs(vectorcode_cacher.query_from_cache(0)) do
            --         prompt_message = prompt_message .. "<|file_sep|>" .. file.path .. "\n" .. file.document
            --       end
            --     end
            --
            --     prompt_message = vim.fn.strcharpart(prompt_message, 0, RAG_Context_Window_Size)
            --     print(prompt_message)
            --
            --     return prompt_message .. "<|fim_prefix|>" .. pref .. "<|fim_suffix|>" .. suff .. "<|fim_middle|>"
            --   end,
            --   suffix = false,
            -- },
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:7b",
            optional = {
              max_tokens = 128,
              top_p = 0.9,
            },
          },
        },

        n_completions = 10,
        context_window = 2000,
        context_ratio = 0.75,
        throttle = 0, -- only send the request every x milliseconds, use 0 to disable throttle. he
        -- debounce the request in x milliseconds, set to 0 to disable debounce
        debounce = 0,
        virtualtext = {
          keymap = {
            -- accept whole completion
            accept = "<C-a>",
            -- accept one line
            accept_line = "<C-j>",
            -- accept n lines (prompts for number)
            -- e.g. "A-z 2 CR" will accept 2 lines
            accept_n_lines = "<C-z>",
            -- Cycle to prev completion item, or manually invoke completion
            prev = "<C-n>",
            -- Cycle to next completion item, or manually invoke completion
            next = "<C-p>",
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },
  -- {
  --   "Davidyz/VectorCode",
  --   enabled = local_ai,
  --   version = "*",
  --   build = "uv tool upgrade vectorcode", -- This helps keeping the CLI up-to-date
  --   -- build = "pipx upgrade vectorcode", -- If you used pipx to install the CLI
  --   dependencies = { "nvim-lua/plenary.nvim" },
  -- },
}
