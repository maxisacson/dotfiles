local lspkind = require 'lspkind'
local cmp = require 'cmp'
local luasnip = require 'luasnip'

require('luasnip.loaders.from_vscode').lazy_load()

vim.o.completeopt = 'menu,menuone,noselect'

cmp.setup({
    preselect = false,
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.complete({}),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

    }),
    sources = cmp.config.sources(
        {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'path' },
            { name = 'luasnip' },
        },
        {
            { name = 'buffer' },
        }
    ),
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = ({
                nvim_lsp = "[LSP]",
                nvim_lsp_signature_help = "[Signature]",
                luasnip = "[LuaSnip]",
                buffer = "[Buffer]",
                path = "[Path]",
                cmdline = "[CmdLine]",
                cmdline_history = "[CmdHist]",
            })
        })
    },
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    completion = { autocomplete = false },
    mapping = cmp.mapping.preset.cmdline({
        ['<Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete({})
            end
        end, { 'c' }),

        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { 'c' }),
    }),
    sources = cmp.config.sources({
        { name = 'cmdline_history' },
        { name = 'buffer' },
    })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    completion = { autocomplete = false },
    mapping = cmp.mapping.preset.cmdline({
        ['<Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_next_item()
            else
                cmp.complete({})
            end
        end, { 'c' }),

        ['<S-Tab>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.select_prev_item()
            end
        end, { 'c' }),
    }),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' },
        { name = 'cmdline_history' }
    })
})
