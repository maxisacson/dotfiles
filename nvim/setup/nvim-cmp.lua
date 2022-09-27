vim.o.completeopt = 'menu,menuone,noselect'

local lspkind = require'lspkind'
local cmp = require'cmp'
cmp.setup({
    preselect = false,
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(4),
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif vim.fn["vsnip#available"]() == 1 then
                feedkey("<Plug>(vsnip-expand-or-jump)", "")
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif vim.fn["vsnip#jumpable"](-1) == 1 then
                feedkey("<Plug>(vsnip-jump-prev)", "")
            else
                fallback()
            end
        end, { "i", "s" }),

    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'orgmode' },
        { name = 'neorg' },
        { name = 'vsnip' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'rs_experimentals' },
    }),
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            maxwidth = 50,
            menu = ({
                nvim_lsp = "[LSP]",
                nvim_lsp_signature_help = "[Signature]",
                vsnip = "[VSnip]",
                orgmode = "[Orgmode]",
                neorg = "[Neorg]",
                buffer = "[Buffer]",
                path = "[Path]",
                rs_experimentals = "[RSExp]"
            })
        })
    },
})

require('cmp_rs_experimentals').setup({
    filename = '/home/max/git/cmp-rs-experimentals/lua/cmp_rs_experimentals/experimentals.txt'
})
