# Cheatsheet 💩💩

## Modes

`Nomal mode` = Navigation
`Visual mode` = Text selection
`Command mode` = Type a command

## Normal mode

h = Move left
j = Move down
k = Move up
l = Move right

gd = Go definition
<C-o> = Go previous cursor prosition
<C-I> = Go next cursor prosition

### Fast Movements
[=cyv][ai][{}()[]""''<>p]
> c = Change
> y = Yanke / Copy
> v = Visual / Select
> = = Format lines
> a = Inclusive char
> i = Between
> p = Paragraph (text block spaced by blank lines)

% = Move your cursor to the opening or closing symbol of [{}()[]""''<>]

#### Vertical
oo = Go top (first row)
<S-o> = Go botton (last row)
<C-u> Jump up
<C-d> Jump down

#### Horizontal
f[any char] = find next character in same line
<S-f>[any char] = find previous character in same line

<br/>

## Visual Mode
v = Enter on visual mode
V = Select entire line
o = Switch cursor for the beging or the end of the selection

<br/>

## Custom keymaps

`<leader>` is <space>

<C-s> = Save file
<leader>w = Save file

### Navitate through buffers (files opened)
<tab> = Next buffer
<S-tab> = Previous buffer
<c-w> = Close buffer

### Split window
- = Horizontal Split
| = Vertical Split

### Navigate between windows
<C-l> = Go left window
<C-h> = Go right window
<C-k> = Go window above
<C-j> = Go window bellow

<leader>e = Open Navigation Tree (NvimTree)
<leader>ff = Open Fuse Finder (Telescope)

## Language Server Protocol
<leader>li = Lsp information (check if is using one lsp on the buffer)
<leader>lr = Rename string
<leader>lf = Format file
<C-k> = Navigate up on the completion snippets
<C-j> = Navigate down on the completion snippets
K = Manual / Descrition
[d = Next Diagnostics (Error, Warning, Tip)
]d = Previous Diagnostics (Error, Warning, Tip)
