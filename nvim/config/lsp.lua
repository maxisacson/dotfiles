local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)

    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    buf_set_keymap('n', '<space>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end

    vim.api.nvim_exec([[
        hi LspDiagnosticsUnderlineError cterm=undercurl gui=undercurl guisp=Red
        hi LspDiagnosticsUnderlineWarning cterm=undercurl gui=undercurl guisp=Orange
        hi LspDiagnosticsUnderlineInformation cterm=undercurl gui=undercurl guisp=LightBlue
        hi LspDiagnosticsUnderlineHint cterm=undercurl gui=undercurl guisp=LightGrey
        hi clear LspReferenceRead
        hi clear LspReferenceWrite
        hi clear LspReferenceText
        hi LspReferenceRead cterm=reverse gui=reverse
        hi LspReferenceWrite cterm=reverse gui=reverse
        hi LspReferenceText cterm=reverse gui=reverse
    ]], false)

    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.opt.updatetime = 250
        vim.cmd([[
            hi! link LspReferenceRead Search
            hi! link LspReferenceText Search
            hi! link LspReferenceWrite Search
            augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
                autocmd CursorHold <buffer> lua vim.diagnostic.open_float({show_header=false, focusable=false})
            augroup END
        ]])
    end
end

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        signs = false,
        update_in_insert = true,
        virtual_text = {
            prefix = '',
        }
    }
)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Servers that don't require special setup
local servers = { 'cmake' }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities
    }
end

-- Servers that do require special setup
nvim_lsp.pylsp.setup {
    on_attach = on_attach,
    cmd = { vim.g.vimrc.pylsp_cmd },
    settings = {
        pylsp = {
            plugins = {
                pycodestyle = { ignore = {'E501', 'E231', 'E226'} },
            }
        }
    },
    capabilities = capabilities
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

    cmd = {"clangd", "--background-index", "--compile-commands-dir=build","--clang-tidy",
        "--clang-tidy-checks='"..
        "-*,"..
        "clang-analyzer-*,"..
        "modernize-*,"..
        "readability-*,"..
        "performance-*,"..
        "cppcoreguidelines-*,"..
        "bugprone-*,"..
        "cert-*,"..
        "hicpp-*,"..
        "-cppcoreguidelines-pro-bounds-constant-array-index,"..
        "-cppcoreguidelines-pro-bounds-array-to-pointer-decay,"..
        "-cppcoreguidelines-avoid-magic-numbers,"..
        "-readability-braces-around-statements,"..
        "-readability-magic-numbers,"..
        "-hicpp-braces-around-statements,"..
        "-hicpp-no-array-decay,"..
        "-hicpp-uppercase-literal-suffix,"..
        "-readability-uppercase-literal-suffix,"..
        "-modernize-use-trailing-return-type,"..
    "'"}
}

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

nvim_lsp.sumneko_lua.setup {
    on_attach = on_attach,
    capabilities = capabilities,
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
