MiniDeps.later(function()
	local gen_ai_spec = require('mini.extra').gen_ai_spec
	local spec_treesitter = require('mini.ai').gen_spec.treesitter

	local ai = require('mini.ai')

	ai.setup({
		custom_textobjects = {
			B = gen_ai_spec.buffer(),
			D = gen_ai_spec.diagnostic(),
			I = gen_ai_spec.indent(),
			L = gen_ai_spec.line(),
			N = gen_ai_spec.number(),
			F = spec_treesitter({
				a = '@function.outer',
				i = '@function.inner',
			}),
			o = spec_treesitter({
				a = {
					'@conditional.outer',
					'@loop.outer',
				},
				i = {
					'@conditional.inner',
					'@loop.inner',
				},
			}),
		},
	})
end)
