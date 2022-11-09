local nvim_lsp = require('lspconfig')

local ok, telescope = pcall(require, 'telescope.builtin')

local on_attach = function(client, bufnr)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'Goto declaration' })
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr, desc = 'Hover' })
    vim.keymap.set('n', '<space>sh', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature help' })
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, { buffer = bufnr, desc = 'Add workspace folder' })
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, { buffer = bufnr, desc = 'Remove workspace folder' })
    vim.keymap.set('n', '<space>wl',
        function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, { buffer = bufnr, desc = 'List workspace folders' })
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename symbol' })
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { buffer = bufnr, desc = 'Open diagnostics under cursor' })
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = bufnr, desc = 'Goto prev diagnostic' })
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = bufnr, desc = 'Goto next diagnostic' })
    vim.keymap.set('n', '<space>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })

    if ok then
        vim.keymap.set('n', 'gr', telescope.lsp_references, { buffer = bufnr, desc = 'Goto reference' })
        vim.keymap.set('n', 'gd', telescope.lsp_definitions, { buffer = bufnr, desc = 'Goto definition' })
        vim.keymap.set('n', '<space>D', telescope.lsp_type_definitions, { buffer = bufnr, desc = 'Goto type definition' })
        vim.keymap.set('n', 'gi', telescope.lsp_implementations, { buffer = bufnr, desc = 'Goto implementation' })
        vim.keymap.set('n', '<space>ds', telescope.lsp_document_symbols, { buffer = bufnr, desc = 'List document symbols' })
        vim.keymap.set('n', '<space>ws', telescope.lsp_dynamic_workspace_symbols, { buffer = bufnr, desc = 'List workspace symbols' })
        vim.keymap.set('n', '<space>q', telescope.diagnostics, { buffer = bufnr, desc = 'Open diagnostics' })
    else
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'Goto reference' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'Goto definition' })
        vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { buffer = bufnr, desc = 'Goto type definition' })
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'Goto implementation' })
        vim.keymap.set('n', '<space>ds', vim.lsp.buf.document_symbol, { buffer = bufnr, desc = 'List document symbols' })
        vim.keymap.set('n', '<space>ws', vim.lsp.buf.workspace_symbol, { buffer = bufnr, desc = 'List workspace symbols' })
        vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, { buffer = bufnr, desc = 'Open diagnostics' })
    end

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr, desc = 'Format document' })
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        vim.keymap.set('v', '<space>f', function() vim.lsp.buf.format({ async = true }) end, { buffer = bufnr, desc = 'Format selection' })
    end

    local hi = function(...)
        vim.api.nvim_set_hl(0, ...)
    end

    hi('LspDiagnosticsUnderlineError', { undercurl = 1, sp = 'Red' })
    hi('LspDiagnosticsUnderlineWarning', { undercurl = 1, sp = 'Orange' })
    hi('LspDiagnosticsUnderlineInformation', { undercurl = 1, sp = 'LightBlue' })
    hi('LspDiagnosticsUnderlineHint', { undercurl = 1, sp = 'LightGrey' })
    hi('LspReferenceRead', {})
    hi('LspReferenceWrite', {})
    hi('LspReferenceText', {})
    hi('LspReferenceRead', { reverse = 1 })
    hi('LspReferenceWrite', { reverse = 1 })
    hi('LspReferenceText', { reverse = 1 })

    -- Set autocommands conditional on server_capabilities
    if client.server_capabilities.documentHighlightProvider then
        vim.opt.updatetime = 250

        local g = vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })
        vim.api.nvim_create_autocmd('CursorHold',
            { group = g, buffer = bufnr, callback = vim.lsp.buf.document_highlight })
        vim.api.nvim_create_autocmd('CursorMoved', { group = g, buffer = bufnr, callback = vim.lsp.buf.clear_references })
        vim.api.nvim_create_autocmd('CursorHold', { group = g, buffer = bufnr,
            callback = function()
                vim.diagnostic.open_float({ show_header = false, focusable = false })
            end
        })
    end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false,
        update_in_insert = true,
        virtual_text = {
            prefix = '',
        }
    })

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Servers that don't require special setup
local servers = { 'cmake', 'tsserver' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Servers that do require special setup
nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { vim.g.vimrc.pylsp_cmd },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { ignore = { 'E501', 'E231', 'E226', 'E402' } },
            }
        }
    },
}

require('rust-tools').setup {
    server = {
        on_attach = on_attach,
        capabilities = capabilities
    }
}

nvim_lsp.clangd.setup {
    on_attach = on_attach,
    capabilities = capabilities,

    cmd = { "clangd",
        "--background-index",
        "--compile-commands-dir=build",
        "--clang-tidy",
        "--clang-tidy-checks='" ..
            "-*," ..
            "clang-analyzer-*," ..
            "modernize-*," ..
            "readability-*," ..
            "performance-*," ..
            "cppcoreguidelines-*," ..
            "bugprone-*," ..
            "cert-*," ..
            "hicpp-*," ..
            "-cppcoreguidelines-pro-bounds-constant-array-index," ..
            "-cppcoreguidelines-pro-bounds-array-to-pointer-decay," ..
            "-cppcoreguidelines-avoid-magic-numbers," ..
            "-readability-braces-around-statements," ..
            "-readability-magic-numbers," ..
            "-hicpp-braces-around-statements," ..
            "-hicpp-no-array-decay," ..
            "-hicpp-uppercase-literal-suffix," ..
            "-readability-uppercase-literal-suffix," ..
            "-modernize-use-trailing-return-type," ..
            "'" }
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { vim.g.vimrc.lualsp_cmd },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = runtime_path
            },
            diagnostics = {
                globals = { 'vim' }
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file('', true)
            },
            telemetry = {
                enable = false
            }
        }
    }
}

nvim_lsp.arduino_language_server.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
        vim.g.vimrc.arduinolsp_cmd,
        '-cli-config', vim.g.vimrc.arduinocli_config,
        '-fqbn', vim.g.vimrc.arduinolsp_fqbn
    }
}
