local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP =
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
	print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerSync
  augroup end
]])

-- Only required if you have packer configured as `opt`
vim.cmd.packadd("packer.nvim")

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return require("packer").startup(function(use)
	-- Packer can manage itself
	use("wbthomason/packer.nvim")

	-- Colorschemes
	use({
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd("colorscheme tokyonight")
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		tag = "0.1.0",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-media-files.nvim",
			},
			{ "nvim-telescope/telescope-file-browser.nvim" },
		},
	})

	-- Treesitter
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })

	-- Harpoon
	use("theprimeagen/harpoon")

	-- Undotree
	use("mbbill/undotree")

	-- Git
	use("tpope/vim-fugitive")

	-- Null-ls
	use("jose-elias-alvarez/null-ls.nvim")

	-- LSP
	use({
		"VonHeikemen/lsp-zero.nvim",
		requires = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	})

	-- Commenter
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")

	-- Git
	use("lewis6991/gitsigns.nvim")
	use("nvim-tree/nvim-tree.lua")
	use("yamatsum/nvim-nonicons")
	-- Cokeline
	use({
		"noib3/nvim-cokeline",
		requires = "kyazdani42/nvim-web-devicons",
	})
	use("moll/vim-bbye")

	-- Status Bar
	use("feline-nvim/feline.nvim")

	-- VimBeGood
	use("ThePrimeagen/vim-be-good")

	-- WhichKey
	use("folke/which-key.nvim")

	-- Colorizer
	use("norcalli/nvim-colorizer.lua")

	-- Scollbar
	use("petertriho/nvim-scrollbar")
	use("kevinhwang91/nvim-hlslens")

	-- Autopair
	use("windwp/nvim-autopairs")

	-- Inline diagnostics
	use({
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
		end,
	})
end)
