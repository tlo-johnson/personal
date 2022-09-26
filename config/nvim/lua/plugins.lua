local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    profile = {
      enable = false,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    use {
      "edeneast/nightfox.nvim",
      disable = true,
      config = function()
        require('nightfox').setup({
          palettes = {
            all = {
              -- bg1 = "#000000"
            }
          }
        })

        vim.cmd "colorscheme duskfox"
      end,
    }

    -- WhichKey
    use {
      "folke/which-key.nvim",
       event = "VimEnter",
       config = function()
        require("config.whichkey").setup()
       end,
    }

    -- Better Comment
    use {
      "numToStr/Comment.nvim",
      opt = true,
      keys = { "gc", "gcc", "gbc" },
      config = function()
        require("Comment").setup {}
      end,
    }

    use {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      requires = { {'nvim-lua/plenary.nvim'} }
    }

		-- You don't need to install this if you already have fzf installed
		use { "junegunn/fzf", run = "./install --all" }

    use {
      'neovim/nvim-lspconfig',
      requires = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
      },
      config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({ automatic_installation = true })
        require('config.lsp').setup()
      end,
    }

    -- Completion
    use {
      "hrsh7th/nvim-cmp",
      -- event = "InsertEnter",
      -- opt = true,
      config = function()
        require("config.cmp").setup()
      end,
      requires = {
        'hrsh7th/nvim-cmp',
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-path",
        'neovim/nvim-lspconfig',
        {
          "L3MON4D3/LuaSnip",
          config = function()
            require("config.snip").setup()
          end,
        },
        "saadparwaiz1/cmp_luasnip",

        -- "davidsierradz/cmp-conventionalcommits",
        -- "lukas-reineke/cmp-rg",

        -- "hrsh7th/cmp-nvim-lua",
        -- "ray-x/cmp-treesitter",

        -- "onsails/lspkind-nvim",
        -- "hrsh7th/cmp-calc",
        -- "f3fora/cmp-spell",
        -- "hrsh7th/cmp-emoji",
        -- "rafamadriz/friendly-snippets",
        -- "honza/vim-snippets",
      },
    }

    use 'hashivim/vim-terraform'

    use 'ayu-theme/ayu-vim'

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end
  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
