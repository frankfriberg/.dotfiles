return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
		"mrbjarksen/neo-tree-diagnostics.nvim",
	},
	config = function()
		vim.keymap.set("n", "<leader><leader>", ":Neotree toggle <cr>", { silent = true })
		local utils = require("neo-tree.utils")
		local events = require("neo-tree.events")
		local cmds = require("neo-tree.sources.filesystem.commands")
		local inputs = require("neo-tree.ui.inputs")

		local function on_file_remove(args)
			local ts_clients = vim.lsp.get_active_clients({ name = "tsserver" })
			for _, ts_client in ipairs(ts_clients) do
				ts_client.request("workspace/executeCommand", {
					command = "_typescript.applyRenameFile",
					arguments = {
						{
							sourceUri = vim.uri_from_fname(args.source),
							targetUri = vim.uri_from_fname(args.destination),
						},
					},
				})
			end
		end

		local function trash(state)
			local tree = state.tree
			local node = tree:get_node()
			if node.type == "message" then
				return
			end
			local _, name = utils.split_path(node.path)
			local msg = string.format("Are you sure you want to trash '%s'?", name)
			inputs.confirm(msg, function(confirmed)
				if not confirmed then
					return
				end
				vim.api.nvim_command("silent !trash -F " .. node.path)
				cmds.refresh(state)
			end)
		end

		require("neo-tree").setup({
			window = {
				width = 30,
			},
			buffers = {
				follow_current_file = true,
			},
			filesystem = {
				window = {
					mappings = {
						["d"] = trash,
					},
				},
				follow_current_file = true,
				filtered_items = {
					hide_gitignored = false,
					hide_dotfiles = false,
					hide_by_name = {
						"node_modules",
						".git",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
				},
				components = {
					harpoon_index = function(config, node)
						local Marked = require("harpoon.mark")
						local path = node:get_id()
						local succuss, index = pcall(Marked.get_index_of, path)
						if succuss and index and index > 0 then
							return {
								text = string.format("↦ %d", index),
								highlight = config.highlight or "NeoTreeDirectoryIcon",
							}
						else
							return {}
						end
					end,
				},
				renderers = {
					file = {
						{
							"container",
							width = "100%",
							content = {
								{ "icon", zindex = 0 },
								{ "name", use_git_status_colors = true, zindex = 0 },
								{ "harpoon_index", zindex = 10 },
								{ "diagnostics", align = "right", zindex = 20 },
								{ "git_status", align = "right", zindex = 20 },
							},
						},
					},
				},
			},
			sources = {
				"filesystem",
				"git_status",
				"diagnostics",
			},
			source_selector = {
				statusline = true,
				tab_labels = {
					filesystem = "",
					git_status = "󰘬",
					diagnostics = "󱌣",
				},
				content_layout = "center",
				tabs_layout = "equal",
				separator = nil,
				highlight_tab_active = "ColorColumn",
			},
			event_handlers = {
				{
					event = events.FILE_DELETED,
					handler = on_file_remove,
				},
				{
					event = events.FILE_RENAMED,
					handler = on_file_remove,
				},
				{
					event = events.FILE_OPENED,
					handler = function()
						require("neo-tree.sources.manager").close_all()
					end,
				},
			},
			default_component_configs = {
				icon = {
					folder_closed = "󰉋",
					folder_open = "󰝰",
					folder_empty = "󱧊",
				},
				git_status = {
					symbols = {
						added = "󰐕",
						deleted = "󰍴",
						modified = "󰇼",
						renamed = "󰁔",
						untracked = "󰈅",
						ignored = "",
						unstaged = "",
						staged = "",
						conflict = "󰦒",
					},
				},
			},
		})
	end,
}
