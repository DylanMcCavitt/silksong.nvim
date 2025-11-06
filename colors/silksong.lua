package.loaded["silksong.palette"] = nil
package.loaded["silksong.colors"] = nil
package.loaded["silksong.highlights"] = nil
package.loaded["silksong.terminal"] = nil
package.loaded["silksong.util"] = nil
package.loaded["silksong"] = nil

local ok, ss = pcall(require, "silksong")
if ok and type(ss.setup) == "function" and type(ss.colorscheme) == "function" then
	ss.setup({})
	ss.colorscheme()
else
	vim.api.nvim_echo({ { "silksong: module not found", "WarningMsg" } }, true, {})
end
vim.g.colors_name = "silksong"
