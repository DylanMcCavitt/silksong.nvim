local M = {}

M.styles_list = { "marrow", "slab", "greymoor", "abyss", "memorium", "cradle", "weavenest" }

---Change silksong option (vim.g.silksong_config.option)
---It can't be changed directly by modifying that field due to a Neovim lua bug with global variables (onedark_config is a global variable)
---@param opt string: option name
---@param value any: new value
function M.set_options(opt, value)
	local cfg = vim.g.silksong_config
	cfg[opt] = value
	vim.g.silksong_config = cfg
end

---Apply the colorscheme (same as ':colorscheme silksong')
function M.colorscheme()
	vim.cmd("hi clear")
	if vim.fn.exists("syntax_on") then
		vim.cmd("syntax reset")
	end
	vim.o.termguicolors = true
	vim.g.colors_name = "silksong"
	if vim.o.background == "weavenest" then
		M.set_options("style", "weavenest")
	elseif vim.g.silksong_config.style == "weavenest" then
		M.set_options("style", "weavenest")
	end
	require("silksong.highlights").setup()
	require("silksong.terminal").setup()
end

---Toggle between silksong styles
function M.toggle()
	local index = vim.g.silksong_config.toggle_style_index + 1
	if index > #vim.g.silksong_config.toggle_style_list then
		index = 1
	end
	M.set_options("style", vim.g.silksong_config.toggle_style_list[index])
	M.set_options("toggle_style_index", index)
	if vim.g.silksong_config.style == "weavenest" then
		vim.o.background = "weavenest"
	else
		vim.o.background = "marrow"
	end
	vim.api.nvim_command("colorscheme silksong")
end

local default_config = {
	-- Main options --
	style = "marrow", -- choose between 'marrow(dark)', 'slab(darker)', 'greymor(cool)', 'abyss(deep)', 'memorium(warm)', 'cradle(warmer)' and 'weavenest(light)'
	toggle_style_key = nil,
	toggle_style_list = M.styles_list,
	transparent = false, -- don't set background
	term_colors = true, -- if true enable the terminal
	ending_tildes = false, -- show the end-of-buffer tildes
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

	-- Changing Formats --
	code_style = {
		comments = "italic",
		keywords = "none",
		functions = "none",
		strings = "none",
		variables = "none",
	},

	-- Lualine options --
	lualine = {
		transparent = false, -- center bar (c) transparency
	},

	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {}, -- Override highlight groups

	-- Plugins Related --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = true, -- use undercurl for diagnostics
		background = true, -- use background color for virtual text
	},
}

---Setup silksong.nvim options, without applying colorscheme
---@param opts table: a table containing options
function M.setup(opts)
	if not vim.g.silksong_config or not vim.g.silksong_config.loaded then -- if it's the first time setup() is called
		vim.g.silksong_config = vim.tbl_deep_extend("keep", vim.g.silksong_config or {}, default_config)
		M.set_options("loaded", true)
		M.set_options("toggle_style_index", 0)
	end
	if opts then
		vim.g.silksong_config = vim.tbl_deep_extend("force", vim.g.silksong_config, opts)
		if opts.toggle_style_list then -- this table cannot be extended, it has to be replaced
			M.set_options("toggle_style_list", opts.toggle_style_list)
		end
	end
	if vim.g.silksong_config.toggle_style_key then
		vim.api.nvim_set_keymap(
			"n",
			vim.g.silksong_config.toggle_style_key,
			'<cmd>lua require("silksong").toggle()<cr>',
			{ noremap = true, silent = true }
		)
	end
end

function M.load()
	vim.api.nvim_command("colorscheme silksong")
end

return M
