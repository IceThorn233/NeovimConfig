local M = {}
---@param ModuleName string
---@return boolean,any,any
local function CheckIfTheModuleExists(ModuleName)
    return pcall(require, ModuleName)
end

---@generic T ...
---@param Function fun(T)
---@vararg T
---@return fun()
local function CreateMappint(Function, ...)
    local args = { ... }
    return function()
        Function(unpack(args))
    end
end

local LspActions = require("Config.Keymaps.LspActions")
local HasDap = CheckIfTheModuleExists("dap")
local HasFzfLua = CheckIfTheModuleExists("fzf-lua")
local HasNeoTree = CheckIfTheModuleExists("neo-tree")
local HasYazi = CheckIfTheModuleExists("yazi")
local HasBufferLine = CheckIfTheModuleExists("bufferline")
local HasBDelete = CheckIfTheModuleExists("bufdel")
local HasGurgFar = CheckIfTheModuleExists("grug-far")
local HasConform = CheckIfTheModuleExists("conform")
local HasTinyCodeAction = CheckIfTheModuleExists("tiny-code-action")
local HasNeogen = CheckIfTheModuleExists("neogen")
local HasIncRename = CheckIfTheModuleExists("inc_rename")
local HasTreesitterTextobjects = CheckIfTheModuleExists("nvim-treesitter-textobjects")
local HasTrouble = CheckIfTheModuleExists("trouble")
local HasHover = CheckIfTheModuleExists("hover")
local HasMiniFile = CheckIfTheModuleExists("mini.files")
local HasEdgyGroup = CheckIfTheModuleExists("edgy-group")
local HasTelescope = CheckIfTheModuleExists("telescope")
local HasSmartSplit = CheckIfTheModuleExists("smart-splits")
local HasResession = CheckIfTheModuleExists("resession")
local HasBetterTerm = CheckIfTheModuleExists("betterTerm")

if HasMiniFile then
    vim.keymap.set(
        "n",
        "<C-x>pf",
        MiniFiles.open,
        { desc = "Open MiniFiles file explorer.", noremap = true, silent = true }
    )
    vim.keymap.set(
        "n",
        "<C-x>pd",
        MiniFiles.open,
        { desc = "Open MiniFiles file explorer.", noremap = true, silent = true }
    )
else
    if HasTelescope then
        vim.keymap.set(
            "n",
            "<C-x>pf",
            "<CMD>Telescope find_files<CR>",
            { desc = "Search File In Project.", silent = true }
        )
    elseif HasFzfLua then
        vim.keymap.set("n", "<C-x>pf", "<CMD>FzfLua files<CR>", { desc = "Search File In Project.", silent = true })
    end
    if HasYazi then
        vim.keymap.set(
            "n",
            "<C-x>pd",
            "<CMD>Yazi toggle<CR>",
            { desc = "Select File Or Directory.", silent = true, noremap = true }
        )
        vim.keymap.set(
            "n",
            "<C-x>pD",
            "<CMD>Yazi cwd<CR>",
            { desc = "Select File Or Directory.(CWD)", silent = true, noremap = true }
        )
    end
end
if HasNeoTree then
    vim.keymap.set(
        "n",
        "<C-c>e",
        "<CMD>Neotree source=filesystem focus<CR>",
        { desc = "Neotree file explorer.", silent = true, noremap = true }
    )
elseif HasYazi then
    vim.keymap.set(
        "n",
        "<C-c>e",
        "<CMD>Yazi toggle<CR>",
        { desc = "Neotree file explorer.", silent = true, noremap = true }
    )
end

if HasBetterTerm then
    vim.keymap.set({ "n", "t" }, "<C-t>", require("betterTerm").open, {
        desc = "Open BetterTerm 0",
    })
    vim.keymap.set({ "n", "t" }, "<C-x>pt", require("betterTerm").select, {
        desc = "Select terminal",
    })
    vim.keymap.set({ "n", "t" }, "<M-TAB>", function()
        require("betterTerm").cycle(1)
    end)
end
if HasResession then
    local resession = require("resession")
    vim.keymap.set("n", "<C-c>ps", resession.save, { desc = "Save session.", silent = true, noremap = true })
    vim.keymap.set(
        "n",
        "<C-c>pd",
        resession.delete,
        { desc = "Delete current session.", silent = true, noremap = true }
    )
    if HasTelescope then
        vim.keymap.set(
            "n",
            "<C-x>ps",
            require("telescope").extensions.resession.resession,
            { desc = "Pick session.", silent = true, noremap = true }
        )
    end
end

if HasGurgFar then
    vim.keymap.set("n", "<C-x>pg", "<CMD>GrugFar<CR>", { desc = "Search And Replace.", silent = true })
elseif HasTelescope then
    vim.keymap.set(
        "n",
        "<C-x>pg",
        "<CMD>Telescope grep_string<CR>",
        { desc = "Search String In Project.", silent = true }
    )
elseif HasFzfLua then
    vim.keymap.set("n", "<C-x>pg", "<CMD>FzfLua gre<CR>", { desc = "Search String In Project.", silent = true })
end

if HasDap then
    local Dap = require("dap")
    vim.keymap.set("n", "<C-c><C-d><C-b>", Dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<C-c><C-d>b", Dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<C-c><C-d><C-c>", Dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<C-c><C-d>c", Dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<F5>", Dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<F9>", Dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
    -- vim.keymap.set("n", "<C-d>i", Dap.step_into, { desc = "Step into" })
    vim.keymap.set("n", "<F11>", Dap.step_into, { desc = "Step into" })
    -- vim.keymap.set("n", "<C-d>o", Dap.step_over, { desc = "Step over" })
    vim.keymap.set("n", "<F10>", Dap.step_over, { desc = "Step over" })
    -- vim.keymap.set("n", "<C-d>O", Dap.step_out, { desc = "Step out" })
    vim.keymap.set("n", "<S-F10>", Dap.step_out, { desc = "Step out" })
end
if HasBufferLine then
    vim.keymap.set("n", "<C-x><LEFT>", "<CMD>BufferLineCyclePrev<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-x><RIGHT>", "<CMD>BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set("n", "<A-h>", "<CMD>BufferLineCyclePrev<CR>", { silent = true })
    vim.keymap.set("n", "<A-l>", "<CMD>BufferLineCycleNext<CR>", { silent = true })
    vim.keymap.set("n", "<A-S-H>", "<CMD>BufferLineMovePrev<CR>", { silent = true })
    vim.keymap.set("n", "<A-S-L>", "<CMD>BufferLineMoveNext<CR>", { silent = true })
    vim.keymap.set("n", "<C-x>b", "<CMD>BufferLinePick<CR>", { desc = "Switch To Buffer.", silent = true })
    vim.keymap.set("n", "<C-x>K", "<CMD>BufferLineCloseOthers<CR>", { desc = "Close Other Buffer.", silent = true })
elseif CheckIfTheModuleExists("cokeline") then
    vim.keymap.set("n", "<C-x><LEFT>", "<PLUG>(cokeline-focus-prev)", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-x><RIGHT>", "<PLUG>(cokeline-focus-next)", { silent = true })
    vim.keymap.set("n", "<A-h>", "<PLUG>(cokeline-focus-prev)", { silent = true, noremap = true })
    vim.keymap.set("n", "<A-l>", "<PLUG>(cokeline-focus-next)", { silent = true })
    vim.keymap.set("n", "<A-S-H>", "<PLUG>(cokeline-switch-prev)", { silent = true })
    vim.keymap.set("n", "<A-S-L>", "<Plug>(cokeline-switch-next)", { silent = true })
    vim.keymap.set("n", "<C-x>b", "<Plug>(cokeline-pick-focus)", { desc = "Switch To Buffer.", silent = true })
    vim.keymap.set("n", "<C-x>K", "", { desc = "Close other buffer.", silent = true, noremap = true })
    vim.keymap.set("n", "<C-x>K", function()
        for _, v in ipairs(require("cokeline.buffers").get_valid_buffers()) do
            if not v.is_focused then
                v:delete()
            end
        end
    end, { desc = "Close Other Buffer.", silent = true })
else
    -- vim.keymap.set("n", "<A-h>", "<CMD>bnext<CR>", { silent = true })
    -- vim.keymap.set("n", "<A-l>", "<CMD>bprevious<CR>", { silent = true })
    vim.keymap.set("n", "<A-h>", "<CMD>tabprevious<CR>", { silent = true })
    vim.keymap.set("n", "<A-l>", "<CMD>tabnext<CR>", { silent = true })
    vim.keymap.set("n", "<A-S-H>", "<CMD>-tabmove<CR>", { silent = true })
    vim.keymap.set("n", "<A-S-L>", "<CMD>+tabmove<CR>", { silent = true })
end

-- if HasBDelete then
--     vim.keymap.set({ "n" }, "<C-x>k", "<CMD>Bdelete<CR>", { desc = "Delete buffer" })
-- else
vim.keymap.set({ "n" }, "<C-x>k", "<CMD>bdelete<CR>", { desc = "Delete buffer" })
-- end
if HasConform then
    vim.keymap.set("n", "<A-o><C-f>", require("conform").format, { desc = "Format", silent = true })
end
if HasHover then
    local Hover = require("hover")
    vim.keymap.set("n", "K", Hover.open, { desc = "Open hover.", silent = true })
    vim.keymap.set("n", "gK", Hover.enter, { desc = "Goto hover.", silent = true })
    vim.keymap.set(
        "n",
        "<A-p>",
        '<CMD>lua require("hover").switch("previous")<CR>',
        { desc = "Previous Source(hover).", silent = true }
    )
    vim.keymap.set(
        "n",
        "<A-n>",
        '<CMD>lua require("hover").switch("next")<CR>',
        { desc = "Next Source(hover).", silent = true }
    )
end
if HasNeogen then
    vim.keymap.set("n", "<C-c><C-g>", require("neogen").generate, { desc = "Generate Doxygen document." })
end

vim.keymap.set("n", "gr", LspActions.LspReferences, { desc = "Goto references.", silent = true, noremap = true })
vim.keymap.set("n", "gd", LspActions.LspDefinitions, { desc = "Goto references.", silent = true, noremap = true })
if HasTinyCodeAction then
    vim.keymap.set("n", "<C-c><C-a>", require("tiny-code-action").code_action, { desc = "Code action." })
else
    vim.keymap.set("n", "<C-c><C-a>", vim.lsp.buf.code_action, { desc = "Code action.", silent = true })
end

vim.keymap.set("n", "<F2>", LspActions.LspRename, { desc = "Rename.", noremap = true })
vim.keymap.set("n", "<C-c>f", vim.lsp.buf.format, { desc = "Format By Lsp.", silent = true, noremap = true })
if HasTrouble then
    vim.keymap.set(
        "n",
        "<C-c>t",
        "<CMD>Trouble diagnostics<CR>",
        { desc = "Diagnostics.", noremap = true, silent = true }
    )
end

if HasTreesitterTextobjects then
    local TreesitterTextobjectsSelect = require("nvim-treesitter-textobjects.select")
    local TreesitterTextobjectsMove = require("nvim-treesitter-textobjects.move")
    local function GenerateSelectFunction(QueryString, QueryGroup)
        return function()
            TreesitterTextobjectsSelect.select_textobject(QueryString, QueryGroup)
        end
    end
    local function GenerateMoveFunction(PreviousOrNext, StartOrEnd, QueryString, QueryGroup)
        return function()
            (
                PreviousOrNext
                    and (StartOrEnd and TreesitterTextobjectsMove.goto_previous_start or TreesitterTextobjectsMove.goto_previous_end)
                or (StartOrEnd and TreesitterTextobjectsMove.goto_next_start or TreesitterTextobjectsMove.goto_next_end)
            )(QueryString, QueryGroup)
        end
    end
    vim.keymap.set(
        { "x", "o" },
        "al",
        GenerateSelectFunction("@local.scope", "locals"),
        { desc = "Select local.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "x", "o" },
        "af",
        GenerateSelectFunction("@function.outer", "textobjects"),
        { desc = "Select outer function.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "x", "o" },
        "if",
        GenerateSelectFunction("@function.inner", "textobjects"),
        { desc = "Select intter function.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "x", "o" },
        "ac",
        GenerateSelectFunction("@class.outer", "textobjects"),
        { desc = "Select outer function.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "x", "o" },
        "ic",
        GenerateSelectFunction("@class.inner", "textobjects"),
        { desc = "Select intter function.", noremap = true, silent = true }
    )

    vim.keymap.set(
        { "n", "x", "o" },
        "[f",
        GenerateMoveFunction(true, true, "@function.outer", "textobjects"),
        { desc = "Goto previous function start.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "[F",
        GenerateMoveFunction(true, false, "@function.outer", "textobjects"),
        { desc = "Goto previous function end.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "]f",
        GenerateMoveFunction(false, true, "@function.outer", "textobjects"),
        { desc = "Goto next function start.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "]F",
        GenerateMoveFunction(false, false, "@function.outer", "textobjects"),
        { desc = "Goto next function end.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "[c",
        GenerateMoveFunction(true, true, "@class.outer", "textobjects"),
        { desc = "Goto previous class start.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "[C",
        GenerateMoveFunction(true, false, "@class.outer", "textobjects"),
        { desc = "Goto previous class end.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "]c",
        GenerateMoveFunction(false, true, "@class.outer", "textobjects"),
        { desc = "Goto next class start.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "]C",
        GenerateMoveFunction(false, false, "@class.outer", "textobjects"),
        { desc = "Goto next class end.", noremap = true, silent = true }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "[a",
        GenerateMoveFunction(true, true, "@parameter.inner", "textobjects"),
        { desc = "Goto previous parameter start." }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "[A",
        GenerateMoveFunction(true, false, "@parameter.inner", "textobjects"),
        { desc = "Goto previous parameter end." }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "]a",
        GenerateMoveFunction(false, true, "@parameter.inner", "textobjects"),
        { desc = "Goto next parameter start." }
    )
    vim.keymap.set(
        { "n", "x", "o" },
        "]A",
        GenerateMoveFunction(false, false, "@parameter.inner", "textobjects"),
        { desc = "Goto next parameter start." }
    )
end
if CheckIfTheModuleExists("leap") then
    vim.keymap.set({ "x", "o" }, "ar", "<Plug>(leap-visit-text-object)")
    vim.keymap.set({ "x", "o" }, "ir", "<Plug>(leap-visit-inner-text-object)")
    vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-visit)")
    vim.keymap.set({ "x", "o" }, "an", CreateMappint(require("leap.treesitter").select))
end
if HasSmartSplit then
    local SmartSplit = require("smart-splits")
    vim.keymap.set("n", "<C-h>", SmartSplit.move_cursor_left)
    vim.keymap.set("n", "<C-j>", SmartSplit.move_cursor_down)
    vim.keymap.set("n", "<C-k>", SmartSplit.move_cursor_up)
    vim.keymap.set("n", "<C-l>", SmartSplit.move_cursor_right)
    vim.keymap.set("n", "<C-S-H>", SmartSplit.resize_left)
    vim.keymap.set("n", "<C-S-J>", SmartSplit.resize_down)
    vim.keymap.set("n", "<C-S-K>", SmartSplit.resize_up)
    vim.keymap.set("n", "<C-S-L>", SmartSplit.resize_right)
else
    vim.keymap.set("n", "<C-h>", "<CMD>wincmd h<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-j>", "<CMD>wincmd j<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-k>", "<CMD>wincmd k<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-l>", "<CMD>wincmd l<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-S-H>", "<CMD>wincmd ><CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-S-L>", "<CMD>wincmd <LT><CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-S-J>", "<CMD>wincmd -<CR>", { silent = true, noremap = true })
    vim.keymap.set("n", "<C-S-K>", "<CMD>wincmd +<CR>", { silent = true, noremap = true })
end
