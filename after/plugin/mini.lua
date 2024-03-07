
local status_ok, pairs = pcall(require, "mini.pairs")
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
surround.setup()
trailspace.setup()
indentscope.setup({
  symbol = "│",
  options = { try_as_border = true },
})
comment.setup()

