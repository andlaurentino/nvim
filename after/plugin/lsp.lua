local status_ok, lsp = pcall(require, "lsp-zero")
if not status_ok then return end

local status_ok, cmp = pcall(require, "cmp")
if not status_ok then return end

local cmp_action = lsp.cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  })
})

lsp.on_attach(function(client, bufnr)
    lsp.default_keymaps({buffer = bufnr})
end)

lsp.setup()

local status_ok, mason = pcall(require, "mason")
if not status_ok then return end

mason.setup({})

local status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not status_ok then return end

mason_lsp.setup({
  ensure_installed = {
      "gopls",
      "pyright",
      "csharp_ls",
      "tsserver",
  },
  handlers = {
    lsp.default_setup,
  },
})


vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename)
