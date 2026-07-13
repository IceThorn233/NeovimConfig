---@type fun (ModuleName:string):boolean
local function CheckIfTheModuleExists(ModuleName)
	return pcall(require, ModuleName)
end

-- Editor
vim.keymap.set("n", "<A-x>", ":", { desc = "Enter Command", noremap = true })
vim.keymap.set("n", "<C-x><C-c>", "<CMD>quitall<CR>", { desc = "Quit", noremap = true, silent = true })
vim.keymap.set({ "n", "i", "v" }, "<C-p>", "<UP>", { desc = "Previous Line.", noremap = true })
vim.keymap.set({ "n", "i", "v" }, "<C-n>", "<DOWN>", { desc = "Next Line.", noremap = true })
vim.keymap.set({ "n", "i", "v" }, "<C-b>", "<LEFT>", { desc = "Backward Char.", noremap = true })
vim.keymap.set({ "n", "i", "v" }, "<C-f>", "<RIGHT>", { desc = "Forward Char.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-b>", "b", { desc = "Backward Word.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-S-B>", "B", { desc = "Backward Word.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-f>", "e", { desc = "Forward Word.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-S-F>", "e", { desc = "Forward Word.", noremap = true })
vim.keymap.set({ "n", "v" }, "<C-a>", "0", { desc = "Move Beginning Of Line.", noremap = true })
vim.keymap.set({ "n", "v" }, "<C-e>", "$", { desc = "Move End Of Line.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-m>", "^", { desc = "Back To Indentation.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-S-,>", "gg0", { desc = "Beginning Of Buffer.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-S-.>", "G0", { desc = "End Of Buffer.", noremap = true })
vim.keymap.set({ "n", "v" }, "<C-S-Y>", '"+p', { desc = "System Paste.", noremap = true })
vim.keymap.set({ "n", "v" }, "<C-v>", "<C-d>", { desc = "Scroll Up Command.", noremap = true })
vim.keymap.set({ "n", "v" }, "<A-v>", "<C-u>", { desc = "Scroll Down Command.", noremap = true })
vim.keymap.set("v", "<A-y>", '"0p', { desc = "Paste last copy.", noremap = true })
vim.keymap.set("v", "<C-y>", "p", { desc = "Paste.", noremap = true })
vim.keymap.set("v", "<C-x><C-/>", "gcgv", { desc = "Toggle Comment.", noremap = false, remap = true })
vim.keymap.set("n", "<C-y>", "hp", { desc = "Paste.", noremap = true })
vim.keymap.set("n", "<A-y>", '"0p', { desc = "Paste last copy.", noremap = true })
vim.keymap.set("n", "<A-g><A-g>", ":", { desc = "Goto Line.", noremap = true })
vim.keymap.set("n", "<C-d>", "x", { desc = "Delete Char.", noremap = true })
vim.keymap.set("n", "<A-d>", "dw", { desc = "Kill Word,", noremap = true })
vim.keymap.set("n", "<A-k>", "d$", { desc = "kill Sentence", noremap = true })
vim.keymap.set("n", "<C-s>", "/", { desc = "Isearch Forward", noremap = true })
vim.keymap.set("n", "<C-r>", "?", { desc = "Isearch Backward", noremap = true })
vim.keymap.set("n", "<C-A-S-->", "<CMD>redo<CR>", { desc = "Redo.", noremap = true, silent = true })
vim.keymap.set("n", "<C-S-->", "<CMD>undo<CR>", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("n", "<C-/>", "<CMD>undo<CR>", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x>u", "<CMD>undo<CR>", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x>o", "<C-w>w", { desc = "Other Window", noremap = true, silent = true })
vim.keymap.set("n", "<C-x>a", "gg0vG$", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x><C-/>", "gcc", { desc = "Toggle Comment.", noremap = false, remap = true })
vim.keymap.set("n", "<C-x><C-a>", "ggv0G$", { desc = "Select All.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x><C-b>", "<CMD>ls<CR>", { desc = "List Buffers.", noremap = true, silent = false })
vim.keymap.set("n", "<C-x><C-d>", ":cd ", { desc = "Open Directory.", noremap = true, silent = false })
vim.keymap.set("n", "<C-x><C-f>", ":e ", { desc = "Open File.", noremap = true, silent = false })
vim.keymap.set("n", "<C-x><C-s>", "<CMD>write %<CR>", { desc = "Save Buffer.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x><C-w>", "<CMD>write %<CR>", { desc = "Write File.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x>0", "<CMD>close<CR>", { desc = "Close Window.", noremap = true, silent = true })
vim.keymap.set("n", "<C-x>2", "<CMD>split<CR>", { desc = "Split", noremap = true, silent = true })
vim.keymap.set("n", "<C-x>3", "<CMD>vsplit<CR>", { desc = "V Split", noremap = true, silent = true })
vim.keymap.set("n", "<C-o>", "o", { desc = "New Line.", noremap = true, silent = true })
vim.keymap.set("n", "<A-u>", "veU", { desc = "Upcase Word.", noremap = true, silent = true })
vim.keymap.set("n", "<A-DEL>", "vbd", { desc = "Backward Kill Word.", noremap = true, silent = true })
-- vim.keymap.set("n", "<A-l>", "veu", { desc = "Downcase Word.", noremap = true, silent = true })
vim.keymap.set("i", "<C-v>", "<PAGEDOWN>", { desc = "Page Down.", noremap = true, silent = true })
vim.keymap.set("i", "<A-v>", "<PAGEUP>", { desc = "Page Up.", noremap = true, silent = true })
vim.keymap.set("i", "<A-b>", "<ESC>bi", { desc = "Backward Word.", noremap = true, silent = true })
vim.keymap.set("i", "<A-f>", "<ESC>ea", { desc = "Forward Word.", noremap = true, silent = true })
vim.keymap.set("i", "<A-S-B>", "<ESC>Bi", { desc = "Backward Word.", noremap = true, silent = true })
vim.keymap.set("i", "<A-S-F>", "<ESC>Ea", { desc = "Forward Word.", noremap = true, silent = true })
vim.keymap.set("i", "<C-a>", "<ESC>0i", { desc = "Move Beginning Of Line.", noremap = true })
vim.keymap.set("i", "<C-e>", "<ESC>$a", { desc = "Move End Of Line.", noremap = true })
vim.keymap.set("i", "<A-m>", "<ESC>^i", { desc = "Back To Indentation", noremap = true })
vim.keymap.set("i", "<A-S-,>", "<ESC>gg0i", { desc = "Beginning Of Buffer.", noremap = true })
vim.keymap.set("i", "<A-S-.>", "<ESC>G0i", { desc = "End Of Buffer.", noremap = true })
vim.keymap.set("i", "<C-d>", "<ESC>ldlgi", { desc = "Delete Char.", noremap = true })
vim.keymap.set("i", "<A-d>", "<ESC>ldei", { desc = "Kill Word,", noremap = true })
vim.keymap.set("i", "<C-y>", "<ESC>pa", { desc = "Paste.", noremap = true })
vim.keymap.set("i", "<A-y>", '<ESC>"0pa', { desc = "Paste last copy.", noremap = true })
vim.keymap.set("i", "<C-S-Y>", '<ESC>"+pa', { desc = "Paste.", noremap = true })
vim.keymap.set("i", "<C-/>", "<ESC><CMD>undo<CR>gi", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("i", "<C-x>u", "<ESC><CMD>undo<CR>gi", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("i", "<C-A-S-->", "<ESC><CMD>redo<CR>gi", { desc = "Undo.", noremap = true, silent = true })
vim.keymap.set("i", "<C-o>", "<ESC>o", { desc = "New Line.", silent = true })
vim.keymap.set("i", "<A-k>", "<ESC>ld$gi", { desc = "kill Sentence", noremap = true })
vim.keymap.set("i", "<C-k>", "<ESC>ld$gi", { desc = "kill Sentence", noremap = true })
vim.keymap.set("i", "<A-DEL>", "<ESC>vdbi", { desc = "Backward Kill Word.", noremap = true, silent = true })
vim.keymap.set("v", "<A-w>", "y", { desc = "Copy.", noremap = true })
vim.keymap.set("v", "<A-S-W>", '"+y', { desc = "System Copy.", noremap = true })

vim.keymap.set("t", "<A-ESC>", "<C-\\><C-n>", { desc = "Exit" })
vim.keymap.set("v", "<", "<gv", { desc = "Unindent.", noremap = true, silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Indent.", noremap = true, silent = true })
vim.keymap.set("v", "J", ":move '>+1<CR>gv", { desc = "Visual block move down.", noremap = true, silent = true })
vim.keymap.set("v", "K", ":move '<-2<CR>gv", { desc = "Visual block move up.", noremap = true, silent = true })

-- vim.keymap.set({ "x", "n" }, "<A-y>", '"+y')
-- vim.keymap.set({ "x", "n" }, "<A-p>", '"+p')
-- vim.keymap.set({ "n" }, "<A-S-P>", '"+P')

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
local HasRimeNvim = CheckIfTheModuleExists("rime.nvim")
local HasHover = CheckIfTheModuleExists("hover")
local HasMiniFile = CheckIfTheModuleExists("mini.files")
local HasEdgyGroup = CheckIfTheModuleExists("edgy-group")
local HasTelescope = CheckIfTheModuleExists("telescope")

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

if HasTelescope then
	vim.keymap.set("n", "<C-x>pf", "<CMD>Telescope find_files<CR>", { desc = "Search File In Project.", silent = true })
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
if HasDap then
	local Dap = require("dap")
	vim.keymap.set("n", "<C-x><C-d><C-b>", Dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
	vim.keymap.set("n", "<C-x><C-d>b", Dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
	vim.keymap.set("n", "<C-x><C-d><C-c>", Dap.continue, { desc = "Continue" })
	vim.keymap.set("n", "<C-x><C-d>c", Dap.continue, { desc = "Continue" })
	vim.keymap.set("n", "<F5>", Dap.continue, { desc = "Continue" })
	vim.keymap.set("n", "<F9>", Dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
	-- vim.keymap.set("n", "<C-d>i", Dap.step_into, { desc = "Step into" })
	vim.keymap.set("n", "<F11>", Dap.step_into, { desc = "Step into" })
	-- vim.keymap.set("n", "<C-d>o", Dap.step_over, { desc = "Step over" })
	vim.keymap.set("n", "<F10>", Dap.step_over, { desc = "Step over" })
	-- vim.keymap.set("n", "<C-d>O", Dap.step_out, { desc = "Step out" })
	vim.keymap.set("n", "<S-F10>", Dap.step_out, { desc = "Step out" })
end
if HasFzfLua then
	local FzfLua = require("fzf-lua")
	vim.keymap.set("n", "<C-c><C-r>", FzfLua.lsp_references, { desc = "Goto References", silent = true })
	vim.keymap.set("n", "<C-c>d", FzfLua.lsp_definitions, { desc = "Goto Type Definition", silent = true })
end

if HasTinyCodeAction then
	vim.keymap.set("n", "<C-c><C-a>", require("tiny-code-action").code_action, { desc = "Code action." })
elseif HasFzfLua then
	vim.keymap.set("n", "<C-c><C-a>", FzfLua.lsp_code_actions, { desc = "Code action.", silent = true })
else
	vim.keymap.set("n", "<C-c><C-a>", vim.lsp.buf.code_action, { desc = "Code action.", silent = true })
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
	if HasBDelete then
		vim.keymap.set({ "n" }, "<C-x>k", "<CMD>Bdelete<CR>", { desc = "Delete buffer" })
	else
		vim.keymap.set({ "n" }, "<C-x>k", "<CMD>bdelete<CR>", { desc = "Delete buffer" })
	end
else
	vim.keymap.set("n", "<A-h>", "<CMD>tabprevious<CR>", { silent = true })
	vim.keymap.set("n", "<A-l>", "<CMD>tabnext<CR>", { silent = true })
	vim.keymap.set("n", "<A-S-H>", "<CMD>-tabmove<CR>", { silent = true })
	vim.keymap.set("n", "<A-S-L>", "<CMD>+tabmove<CR>", { silent = true })
end
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
if HasIncRename then
	local function IncRenameFunction()
		return ":IncRename " .. vim.fn.expand("<cword>")
	end
	vim.keymap.set("n", "<F2>", IncRenameFunction, { desc = "Rename.", expr = true })
	vim.keymap.set("n", "<C-c>r", IncRenameFunction, { desc = "Rename.", expr = true })
else
	vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
	vim.keymap.set("n", "<C-c>r", vim.lsp.buf.rename, { desc = "Rename" })
end
vim.keymap.set("n", "<C-c>f", vim.lsp.buf.format, { desc = "Format By Lsp.", silent = true, noremap = true })
if HasTrouble then
	vim.keymap.set(
		"n",
		"<C-c>t",
		"<CMD>Trouble diagnostics<CR>",
		{ desc = "Diagnostics.", noremap = true, silent = true }
	)
end
if HasEdgyGroup then
	vim.keymap.set("n", "<C-x>pe", function()
		require("edgy-group.stl").pick(function()
			require("lualine").refresh({
				force = true,
			})
		end)
	end, { desc = "Pick group." })
end
if HasTinyCodeAction then
	vim.keymap.set("n", "<C-c><C-a>", require("tiny-code-action").code_action, { desc = "Code action." })
elseif HasFzfLua then
	vim.keymap.set("n", "<C-c><C-a>", FzfLua.lsp_code_actions, { desc = "Code action.", silent = true })
else
	vim.keymap.set("n", "<C-c><C-a>", vim.lsp.buf.code_action, { desc = "Code action.", silent = true })
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
