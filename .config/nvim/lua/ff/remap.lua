-- Shorten function name
local function keymap(mode, keyfrom, keyto)
  return vim.keymap.set(mode, keyfrom, keyto, { silent = true })
end

--Remap space as leader key
vim.g.mapleader = " "

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- Go to end of line or start of line
keymap("n", "gl", "$")
keymap("n", "gh", "0")

keymap("n", "U", "<C-r>")

-- Remap open diagnostics from gl
keymap("n", "gd", "")

-- Save
keymap("n", "<Leader>w", ":write<CR>")

-- Buffer navigation
keymap("n", "<Tab>", ":bnext<CR>")
keymap("n", "<S-Tab>", ":bprev<CR>")

-- Close buffers
keymap("n", "<leader>q", ":Bdelete<CR>")
keymap("n", "<leader>aq", ":bufdo :Bdelete<CR>")

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Cancel search highlighting with ESC
keymap("n", "<ESC>", ":nohlsearch<Bar>:echo<CR>")

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>")
keymap("i", "kj", "<ESC>")

-- Visual --
-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv")
keymap("x", "K", ":move '<-2<CR>gv-gv")
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv")
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv")

-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dP')
