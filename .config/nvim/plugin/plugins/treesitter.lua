MiniDeps.now(function()
	MiniDeps.add({
		checkout = 'master',
		hooks = {
			post_checkout = function()
				vim.cmd('TSUpdate')
			end,
		},
		monitor = 'main',
		source = 'nvim-treesitter/nvim-treesitter',
	})

	local languages = {
		'astro',
		'css',
		'dart',
		'go',
		'html',
		'javascript',
		'jsdoc',
		'json',
		'lua',
		'query',
		'markdown',
		'markdown_inline',
		'svelte',
		'tsx',
		'typescript',
		'vim',
		'vimdoc',
		'wgsl',
	}

	require('nvim-treesitter.configs').setup({
		ensure_installed = languages,
		highlight = {
			additional_vim_regex_highlighting = false,
			enabled = true,
		},
	})

	local filetypes = {}
	for _, lang in ipairs(languages) do
		for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
			table.insert(filetypes, ft)
		end
	end

	vim.api.nvim_create_autocmd('FileType', {
		callback = function(ev)
			vim.treesitter.start(ev.buf)
		end,
		desc = 'start tree-sitter',
		pattern = filetypes,
	})
end)
