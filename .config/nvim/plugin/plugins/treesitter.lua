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

	local isnt_installed = function(lang)
		return #vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false) == 0
	end

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

	local to_install = vim.tbl_filter(isnt_installed, languages)

	if #to_install > 0 then
		require('nvim-treesitter').install(to_install)
	end

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
		group = vim.api.nvim_create_augroup('start-tree-sitter', {}),
		pattern = filetypes,
	})
end)
