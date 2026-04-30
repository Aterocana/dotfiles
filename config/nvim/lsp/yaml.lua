return {
  cmd = { "yaml-language-server", "--stdio" },
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
	kubernetes = "*.yaml", -- Attiva validazione per file K8s
	["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
	["https://json.schemastore.org/github-action.json"] = "/.github/actions/*",
	["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.36.0-standalone/all.json"] = "/*.yaml",
	["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/cert-manager.io/certificate_v1.json"] =
	"*certificate*.yaml",
	["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/cert-manager.io/clusterissuer_v1.json"] = { "*clusterissuer*.yaml", "*cluster-issuer*.yaml" },
	["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/cert-manager.io/issuer_v1.json"] = "*issuer*.yaml",
	["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/cert-manager.io/certificaterequest_v1.json"] =
	"*certificaterequest*.yaml",
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
