local M = {}

local style = "block"

function M.set_bar_style(choice)
	style = choice
end

function M.custom_opts(opts)
	require('config.wibar.styles.' .. style).parse_opts(opts)
end

function M.init(s)
	require('config.wibar.styles.' .. style).init(s)
end

return M
