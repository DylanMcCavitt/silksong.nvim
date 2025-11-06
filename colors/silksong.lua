local ok, ss = pcall(require, "silksong")
if ok and ss.setup and ss.load then
	ss.setup({})
	ss.load()
else
	vim.api.nvim_echo({ { "silksong: could not load module", "WarningMsg" } }, true, {})
end
vim.g.colors_name = "silksong"
