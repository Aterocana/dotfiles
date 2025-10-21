return {
  cmd = { "deno", "lsp" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "git" },
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
  },
}
