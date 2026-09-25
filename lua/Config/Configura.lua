-- 文件编码 encode
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "UTF-8"

-- -- editor
vim.o.relativenumber = true -- 相对行号
vim.o.number = true -- 行号
vim.o.cursorline = true -- 高亮
-- vim.o.cursorcolumn = true -- 所在列高亮
vim.o.scrolloff = 10
vim.o.splitright = true -- 横向分割
vim.o.splitbelow = true -- 纵向分割
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.o.splitkeep = "screen"
-- views can only be fully collapsed with the global statusline
vim.o.laststatus = 3
vim.o.termguicolors = true -- 终端颜色
vim.o.signcolumn = "yes"
vim.o.backup = false -- 去你妈的备份
vim.o.swapfile = false -- 去你妈的swapfile
vim.o.wrap = true -- 自动换行
vim.o.confirm = true -- 亲切的退出确认交互
vim.o.shiftround = true -- 使用 >> 和 << 移动时对齐到 shiftwidth 的倍数
vim.o.cindent = true -- C 文件自动缩进
vim.o.autoindent = true -- 新行缩进对齐到当前行
vim.o.smartindent = true -- 开启智能缩进
vim.o.winborder = "none" -- 默认窗口边框样式
-- 缩进 tab
vim.o.smarttab = true -- 开启智能 Tab
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.autoindent = true
-- mouse and clipboard
vim.opt.mouse:append("a")
vim.o.mousemoveevent = true

-- 启用基于 Tree-sitter 的折叠
vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99 -- 默认展开所有
vim.o.foldenable = true
vim.o.background = "light"

-- vim.o.guifont = "NeoSpleen,Symbols Nerd Font,LXGW WenKai Mono:h12"
vim.o.guifont = "CEF Fonts CJK Mono,LXGW WenKai Mono,Symbols Nerd Font:h14"
-- vim.o.guifont = "monofur,CEF Fonts CJK Mono,LXGW WenKai Mono,Symbols Nerd Font:h13"
-- vim.opt.clipboard:append("unnamedplus")
-- vim.o.clipboard = "unnamedplus"

-- search
vim.o.incsearch = true -- search as characters are entered
vim.o.hlsearch = false -- do not highlight matches
vim.o.ignorecase = true -- ignore case in searches by default
vim.o.smartcase = true -- but make it case sensitive if an uppercase is entered
vim.o.sessionoptions = "help,buffers,curdir,folds,tabpages,terminal,globals"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- require("vim._core.ui2").enable()
vim.o.splitkeep = "screen"
vim.filetype.add({
    extension = {
        proj = "xml",
        csproj = "xml",
        vbproj = "xml",
        fsproj = "xml",
        xaml = "xml",
    },
    pattern = {
        [ [[.*/lf/lfrc]] ] = "lf",
        [ [[.*/lf/.*%.conf]] ] = "lf",
        [ [[.*/i3/config]] ] = "config",
        [ [[.*/i3/.*%.conf]] ] = "i3config",
        [ [[.*/sway/config]] ] = "swayconfig",
        [ [[.*/sway/.*%.conf]] ] = "swayconfig",
        [ [[.*/scroll/config]] ] = "swayconfig",
        [ [[.*/scroll/.*%.conf]] ] = "swayconfig",
        [ [[.*/neomutt/.*%.conf]] ] = "muttrc",
        [ [[.*/foot/.*%.ini]] ] = "conf",
        [ [[.*/.*%.props]] ] = "xml",
        [ [[.*/.*%.target]] ] = "xml",
    },
})
vim.api.nvim_create_user_command("NvimEditConfiguration", function(_)
    vim.cmd.edit('"$MYVIMRC"')
    vim.cmd.cd("%:p:h")
    if pcall(require, "neo-tree") then
        vim.cmd.Neotree("show")
    end
    vim.cmd.echo("$PWD")
end, { desc = "Edit configure" })
