--- @param s string
local get_spellings = function(s)
	return {
		s,
		s:gsub('^%l', string.upper),
		string.upper(s),
	}
end

MiniDeps.later(function()
	local hi_words = require('mini.extra').gen_highlighter.words

	local hipatterns = require('mini.hipatterns')

	hipatterns.setup({
		highlighters = {
			fixme = hi_words(get_spellings('fixme'), 'MiniHipatternsFixme'),
			hack = hi_words(get_spellings('hack'), 'MiniHipatternsHack'),
			todo = hi_words(get_spellings('todo'), 'MiniHipatternsTodo'),
			note = hi_words(get_spellings('note'), 'MiniHipatternsNote'),
			hex_color = hipatterns.gen_highlighter.hex_color({
				style = 'bg',
			}),
		},
	})
end)
