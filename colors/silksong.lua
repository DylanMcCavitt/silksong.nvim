for k in pairs(package.loaded) do
	if k:match(".*silksong.*") then
		package.loaded[k] = nil
	end
end

require("silksong").setup()
require("silksong").colorscheme()
