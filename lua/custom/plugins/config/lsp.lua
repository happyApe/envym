local lspconfig = require 'lspconfig'

-- config for pyright
lspconfig.pyright.setup {
  filetypes = { 'python' },
  settings = {
    pyright = { autoImportCompletion = true },
    python = {
      pythonPath = vim.fn.exepath 'python',
      analysis = { autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true },
    },
  },
}
