return {
  cmd = { "yaml-language-server", "--stdio"  },
  filetypes = { "yaml" },
  settings = {
	yaml = {
	  validate = true,
	  hover = true,
	  completion = true,
	  format = { enable = true },
	  schemaStore = {
		enable = true,
		url = "https://www.schemastore.org/api/json/catalog.json",
	  },
	  schemas = {
		kubernetes = "*.yaml",               -- Attiva validazione per file K8s
		["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
		["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
		["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.0-standalone/all.json"] = "/*.yaml",
	  },

	},
	customTags = {
	  "!Ref scalar",
	  "!Sub scalar",
	  "!GetAtt scalar",
	  "!Join sequence",
	  "!FindInMap sequence",
	},
  },
}
