return {
	{ "tpope/vim-dadbod" },
	{
		'kristijanhusak/vim-dadbod-ui',
		dependencies = {
			{ 'tpope/vim-dadbod', lazy = true },
			{ 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
		},
		cmd = {
			'DBUI',
			'DBUIToggle',
			'DBUIAddConnection',
			'DBUIFindBuffer',
		},
	},
	{ "kristijanhusak/vim-dadbod-completion" },
}
