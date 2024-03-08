local status_ok, pairs = pcall(require, "mini.pairs")
if not status_ok then return end

local status_ok, move = pcall(require, "mini.move")
if not status_ok then return end

local status_ok, surround = pcall(require, "mini.surround")
if not status_ok then return end

local status_ok, trailspace = pcall(require, "mini.trailspace")
if not status_ok then return end

local status_ok, indentscope = pcall(require, "mini.indentscope")
if not status_ok then return end

local status_ok, comment = pcall(require, "mini.comment")
if not status_ok then return end


pairs.setup()
move.setup({
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    -- left = '<M-h>',
    -- right = '<M-l>',
	down = '∆',
	up = '˚',

    -- Move current line in Normal mode
    -- line_left = '<M-h>',
    -- line_right = '<M-l>',
	line_down = '∆',
	line_up = '˚',
  },

  -- Options which control moving behavior
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
})
surround.setup()
trailspace.setup()
indentscope.setup({
	symbol = "│",
	options = { try_as_border = true },
})
comment.setup()
