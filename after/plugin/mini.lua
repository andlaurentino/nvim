
local status_ok, treesitter = pcall(require, "mini.pairs")
if not status_ok then return end

local status_ok, treesitter = pcall(require, "mini.surround")
if not status_ok then return end

local status_ok, treesitter = pcall(require, "mini.trailspace")
if not status_ok then return end

local status_ok, treesitter = pcall(require, "mini.identscope")
if not status_ok then return end

local status_ok, treesitter = pcall(require, "comment")
if not status_ok then return end


pairs.setup()
surround.setup()
trailspace.setup()
indentscope.setup({
  symbol = "│",
  options = { try_as_border = true },
})
comment.setup()

