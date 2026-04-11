--Mason + LSP Configuration
local mason_ok, mason = pcall(require, "mason")
if not mason_ok then return end

local mason_lsp_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lsp_ok then return end

--Setup Mason
mason.setup()

--Setup Mason-LSPConfig
mason_lspconfig.setup({
    ensure_installed = {},
    automatic_installation = false,
})

--Prepare Capabilities for nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
local cmp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if cmp_ok then
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
end

--Keymaps & On_Attach
local on_attach = function(_, bufnr)
    local opts = { buffer = bufnr, remap = false }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "nr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    
    vim.keymap.set("n", "<leader>d", function()
        vim.diagnostic.enable(not vim.diagnostic.is_enabled())
    end, { buffer = bufnr, desc = "Toggle Diagnostics" })
end

-- Server Settings
local servers = {
    pyright = {},
    ts_ls = {},
    html = {},
    cssls = {},
    clangd = {},
    lua_ls = {
        Lua = {},
    },
}

for server, settings in pairs(servers) do
    vim.lsp.config(server, {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = settings,
        single_file_support = true,
    })

    vim.lsp.enable(server)
end

