local nvim_lsp = require('lspconfig')

local ok, telescope = pcall(require, 'telescope.builtin')

local on_attach = function(client, bufnr)
    vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Mappings.
    local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = '[LSP] ' .. desc })
    end

    map('n', 'gD', vim.lsp.buf.declaration, 'Goto declaration')
    map('n', 'K', vim.lsp.buf.hover, 'Hover')
    map('n', '<space>sh', vim.lsp.buf.signature_help, 'Signature help')
    map('n', '<space>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
    map('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
    map('n', '<space>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, 'List workspace folders' )
    map('n', '<space>rn', vim.lsp.buf.rename, 'Rename symbol')
    map('n', '<space>e', vim.diagnostic.open_float, 'Open diagnostics under cursor')
    map('n', '[d', vim.diagnostic.goto_prev, 'Goto prev diagnostic')
    map('n', ']d', vim.diagnostic.goto_next, 'Goto next diagnostic')
    map('n', '<space>a', vim.lsp.buf.code_action, 'Code action')

    if ok then
        map('n', 'gr', telescope.lsp_references, 'Goto reference')
        map('n', 'gd', telescope.lsp_definitions, 'Goto definition')
        map('n', '<space>D', telescope.lsp_type_definitions, 'Goto type definition')
        map('n', 'gi', telescope.lsp_implementations, 'Goto implementation')
        map('n', '<space>ds', telescope.lsp_document_symbols, 'List document symbols')
        map('n', '<space>ws', telescope.lsp_dynamic_workspace_symbols, 'List workspace symbols')
        map('n', '<space>q', telescope.diagnostics, 'Open diagnostics')
    else
        map('n', 'gr', vim.lsp.buf.references, 'Goto reference')
        map('n', 'gd', vim.lsp.buf.definition, 'Goto definition')
        map('n', '<space>D', vim.lsp.buf.type_definition, 'Goto type definition')
        map('n', 'gi', vim.lsp.buf.implementation, 'Goto implementation')
        map('n', '<space>ds', vim.lsp.buf.document_symbol, 'List document symbols')
        map('n', '<space>ws', vim.lsp.buf.workspace_symbol, 'List workspace symbols')
        map('n', '<space>q', vim.diagnostic.setloclist, 'Open diagnostics')
    end

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.documentFormattingProvider then
        map('n', '<space>f', function() vim.lsp.buf.format({ async = true }) end, 'Format document' )
    end

    if client.server_capabilities.documentRangeFormattingProvider then
        map('v', '<space>f', function() vim.lsp.buf.format({ async = true }) end, 'Format selection' )
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
local servers = { 'cmake', 'tsserver', 'gopls' }
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
