# Cheatsheet 💩💩

## Modes

`Nomal mode` = Navigation <br/>
`Visual mode` = Text selection <br/>
`Command mode` = Type a command <br/>

## Normal mode

`esc` = Enter normal mode

`h` = Move left <br/>
`j` = Move down <br/>
`k` = Move up <br/>
`l` = Move right <br/>

`gd` = Go definition <br/>
`<C-o>` = Go previous cursor prosition <br/>
`<C-I>` = Go next cursor prosition <br/>

### Fast Movements

[`=cyv`][`ai`][`{}()[]""''<>p`]
> `c` = Change <br/>
> `y` = Yanke / Copy <br/>
> `v` = Visual / Select <br/>
> `=` = Format lines <br/>
> `a` = Inclusive char <br/>
> `i` = Between <br/>
> `p` = Paragraph (text block spaced by blank lines) <br/>

`%` = Move your cursor to the opening or closing of the following symbols: `{}`, `()`, `[]` <br/>

#### Vertical

`oo` = Go top (first row) <br/>
`<S-o>` = Go botton (last row) <br/>
`<C-u>` = Jump up <br/>
`<C-d>` = Jump down <br/>

#### Horizontal

`f[any char]` = find next character in same line <br/>
`<S-f>[any char]` = find previous character in same line <br/>

`0` = Move cursor to the start of the line <br/>
`^` = Move cursor to the start of first char of the line <br/>
`$` = Move cursor to the end of the line <br/>

<br/>

## Visual Mode

`v` = Enter on visual mode <br/>
`V` = Select entire line <br/>
`<c-v>` = Enter multi selection <br/>
`o` = Switch cursor for the beging or the end of the selection <br/>

<br/>

## Custom keymaps

`<leader>` is spacebar

`<C-s>` = Save file <br/>
`<leader>w` = Save file <br/>

### Navitate through buffers (files opened)

`<tab>` = Next buffer <br/>
`<S-tab>` = Previous buffer <br/>
`<c-w>` = Close buffer <br/>

### Split window

`-` = Horizontal Split <br/>
`|` = Vertical Split <br/>

### Navigate between windows

`<C-l>` = Go left window <br/>
`<C-h>` = Go right window <br/>
`<C-k>` = Go window above <br/>
`<C-j>` = Go window bellow <br/>

`<leader>e` = Open Navigation Tree (NvimTree) <br/>
`<leader>ff` = Open Fuse Finder (Telescope) <br/>

### Resize windows

`<C-S-l>` = Resize left window <br/>
`<C-S-h>` = Resize right window <br/>
`<C-S-k>` = Resize top window <br/>
`<C-S-j>` = Resize bottom window <br/>

## Language Server Protocol

`<leader>li` = Lsp information (check if is using one lsp on the buffer) <br/>
`<leader>lr` = Rename string <br/>
`<leader>lf` = Format file <br/>
`<C-k>` = Navigate up on the completion snippets <br/>
`<C-j>` = Navigate down on the completion snippets <br/>
`K` = Manual / Descrition <br/>
`[d` = Next Diagnostics (Error, Warning, Tip) <br/>
`]d` = Previous Diagnostics (Error, Warning, Tip) <br/>
`<enter>` = Add one empty line bellow
`<S-enter>` = Add one empty line above
