local M = {}

local lspconfig = require('lspconfig')
local lspconfig_default = lspconfig.util.default_config

lspconfig_default.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_default.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

local gopls_config = function ()
  lspconfig.gopls.setup({
	capabilities = lspconfig_default.capabilities,
	analyses = {
	  shadow = true,
	  unusedwrite = true,
	  unusedvariable = true,
	},
	staticcheck = true,
	gofumpt = true,

	settings = {
	  gopls = {
		hints = {
		  assignVariableTypes = true,
		  compositeLiteralFields = true,
		  compositeLiteralTypes = true,
		  constantValues = true,
		  functionTypeParameters = true,
		  parameterNames = true,
		  rangeVariableTypes = true,
		},
		usePlaceholders = false,
		analyses = {
		  unusedvariable = true
		}
	  }
	}
  })

  --lspconfig.golangci_lint_ls.setup({})
end

local luals_config = function ()
  lspconfig.lua_ls.setup({
	on_init = function(client)
	  --if client.workspace_folders then
	  --  local path = client.workspace_folders[1].name
	  --  if path ~= vim.fn.stdpath('config') and (vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc')) then
	  --    return
	  --  end
	  --end

	  client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
		runtime = { version = 'LuaJIT' },
		-- Make the server aware of Neovim runtime files
		workspace = {
		  checkThirdParty = false,
		  library = {
			vim.env.VIMRUNTIME
			-- Depending on the usage, you might want to add additional paths here.
			-- "${3rd}/luv/library"
			-- "${3rd}/busted/library",
		  }
		  -- or pull in all of 'runtimepath'. NOTE: this is a lot slower and will cause issues when working on your own configuration (see https://github.com/neovim/nvim-lspconfig/issues/3189)
		  -- library = vim.api.nvim_get_runtime_file("", true)
		}
	  })
	end,

	settings = {
	  Lua = {
		runtime = { version = "LuaJIT", path = vim.split(package.path, ";") },
		diagnostic = { globals = {"vim"}},
		workspace = {
		  -- Make the server aware of Neovim runtime files
		  library = vim.api.nvim_get_runtime_file("", true),
		},
		-- Do not send telemetry data containing a randomized but unique identifier
		telemetry = {
		  enable = false,
		},

		hint = {enable = true},
	  }
	},
  })

  -- NOTE: monkey patch for LUALS
  local locations_to_items = vim.lsp.util.locations_to_items
  vim.lsp.util.locations_to_items = function (locations, offset_encoding)
	local lines = {}
	local loc_i = 1
	for _, loc in ipairs(vim.deepcopy(locations)) do
	  local uri = loc.uri or loc.targetUri
	  local range = loc.range or loc.targetSelectionRange
	  if lines[uri .. range.start.line] then -- already have a location on this line
		table.remove(locations, loc_i) -- remove from the original list
	  else
		loc_i = loc_i + 1
	  end
	  lines[uri .. range.start.line] = true
	end

	return locations_to_items(locations, offset_encoding)
  end
end

local bashls_config = function ()
  lspconfig.bashls.setup({
	cmd = { "bash-language-server", "start"},
	filetypes = { "bash", "sh", "zsh" },
	single_file_support = true
  })
end

local docker_config = function ()
  lspconfig.dockerls.setup {
	settings = {
	  docker = {
		languageserver = {
		  formatter = {
			ignoreMultilineInstructions = true,
		  },
		},
	  }
	}
  }
end

local jsonls_config = function ()
  lspconfig.jsonls.setup({
	cmd = { "vscode-json-language-server", "--stdio" },
	filetypes = { "json", "jsonc" },
	init_options = { provideFormatter = true }
  })
end

local markdown_config = function ()
  lspconfig.marksman.setup({
	cmd = { "marksman", "server" },
	filetypes = { "markdown", "markdown.mdx" }
  })
end

local js_config = function ()
  -- To appropriately highlight codefences returned from denols, you will need to augment vim.g.markdown_fenced languages in your init.lua
  vim.g.markdown_fenced_languages = {
	"ts=typescript"
  }

  lspconfig.denols.setup({
	cmd = { "deno", "lsp" },
	cmd_env = { NO_COLOR = true },
	filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
	settings = {
	  deno = {
		enable = true,
		suggest = {
		  imports = {
			hosts = {
			  ["https://deno.land"] = true
			}
		  }
		}
	  }
	}
  })
end

local html_css_config = function ()
  local capabilities = lspconfig_default.capabilities
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  lspconfig.html.setup ({
	capabilities = capabilities,
	filetypes = { "html", "templ", "gohtml", "tmpl"}
  })

  lspconfig.cssls.setup({
	cmd = { "vscode-css-language-server", "--stdio" },
	filetypes = { "css", "scss", "less" },
	init_options = { provideFormatter = true },
	settings = {
	  css = { validate = true },
	  less = { validate = true },
	  scss = { validate = true }
	},
	single_file_support = true
  })
end

local helm_config = function ()
  lspconfig.helm_ls.setup({
	settings = {
	  ['helm-ls'] = {
		logLevel = "info",
		valuesFiles = {
		  mainValuesFile = "values.yaml",
		  lintOverlayValuesFile = "values.lint.yaml",
		  additionalValuesFilesGlobPattern = "values*.yaml"
		},
		yamlls = {
		  enabled = true,
		  enabledForFilesGlob = "*.{yaml,yml}",
		  diagnosticsLimit = 50,
		  showDiagnosticsDirectly = false,
		  path = "yaml-language-server",
		  config = {
			schemas = {
			  kubernetes = "templates/**",
			},
			completion = true,
			hover = true,
			-- any other config from https://github.com/redhat-developer/yaml-language-server#language-server-settings
		  }
		}
	  }
	}

  })
end

local protobuffer_config = function ()
  local configs = require("lspconfig.configs")
  local util = require("lspconfig.util")

  configs.protobuf_language_server = {
	default_config = {
	  cmd = { 'protobuf-language-server' },
	  filetypes = { "proto" },
	  root_dir = util.root_pattern('.git'),
	  single_file_support = true,
	}
  }

  lspconfig.protobuf_language_server.setup({})
end

M.all_servers_config = function ()
  gopls_config()
  luals_config()
  bashls_config()
  docker_config()
  jsonls_config()
  markdown_config()
  js_config()
  html_css_config()
  lspconfig.yamlls.setup({})
  --lspconfig.clangd.setup({})
  --lspconfig.diagnosticls.setup({})
  lspconfig.autotools_ls.setup({})
  helm_config()
  protobuffer_config()
end

return M
