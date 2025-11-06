local util = {}

util.bg = "#000000"
util.fg = "#ffffff"

local function hexToRgb(hex_str)
	local r, g, b = string.match(hex_str, "^#(%x%x)(%x%x)(%x%x")
	assert(r, "Invalid hex string: " .. hex_str)
	return { tonumber(r, 16), tonumber(g, 16), tonumber(b, 16) }
end

---@param fg string foreground color
---@param bg string background color
---@param alpha number number between 0 and 1. 0 results in bg, 1 results in fg
function util.blend(fg, bg, alpha)
	local bg_rgb = hexToRgb(bg)
	local fg_rgb = hexToRgb(fg)

	local blendChannel = function(i)
		local ret = (alpha * fg_rgb[i] + ((1 - alpha) * bg_rgb[i]))
		return math.floor(math.min(math.max(0, ret), 255) + 0.5)
	end

	return string.format("#%02X%02X%02X", blendChannel(1), blendChannel(2), blendChannel(3))
end

function util.darken(hex, amount, bg)
	return util.blend(hex, bg or util.bg, math.abs(amount))
end

function util.lighten(hex, amount, fg)
	return util.blend(hex, fg or util.fg, math.abs(amount))
end

return util
