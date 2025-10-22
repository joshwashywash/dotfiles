MiniDeps.now(function()
	local icons = require('mini.icons')
	icons.setup()

	MiniDeps.later(function()
		icons.tweak_lsp_kind('replace')
	end)
end)
