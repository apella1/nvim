local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Set leader key
vim.g.mapleader = " "

-- Buffer navigation
keymap("n", "<S-h>", ":bprevious<CR>", opts)
keymap("n", "<S-l>", ":bnext<CR>", opts)

-- Window splits
keymap("n", "<leader>v", ":vsplit<CR>", opts)
keymap("n", "<leader>s", ":split<CR>", opts)

-- Clipboard operations
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>y", '"+y', opts)

-- Command palette (Telescope)
keymap("n", "<leader>mm", ":Telescope commands<CR>", opts)

-- Reload configuration
keymap("n", "<leader>r", ":source $MYVIMRC<CR>", opts)

-- Terminal operations
keymap("n", "<leader>mt", ":ToggleTerm<CR>", opts)
keymap("n", "<leader>nt", ":ToggleTerm direction=horizontal<CR>", opts)

-- Toggle fullscreen (if your terminal supports it)
keymap("n", "<leader>t", ":lua vim.cmd('max')<CR>", opts)

-- Search operations
keymap("n", "<leader>/", ":Telescope live_grep<CR>", opts)
keymap("n", "<leader>ns", ":Telescope current_buffer_fuzzy_find<CR>", opts)

-- Code folding
keymap("n", "<leader>mc", "za", opts)
keymap("v", "<leader>mc", "za", opts)

-- LSP operations
keymap("n", "<leader>mr", ":lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>nr", ":lua vim.lsp.buf.references()<CR>", opts)

-- Sidebar and extensions
keymap("n", "<leader>nb", ":NvimTreeToggle<CR>", opts)
keymap("n", "<leader>ne", ":NvimTreeFocus<CR>", opts)

-- Settings
keymap("n", "<leader>gs", ":e $MYVIMRC<CR>", opts)

-- Code running
keymap("n", "<leader>e", ":RunCode<CR>", opts)

-- Git operations
keymap("n", "<leader>gc", ":Telescope git_commits<CR>", opts)

-- Problems/diagnostics
keymap("n", "<leader>gp", ":Telescope diagnostics<CR>", opts)

-- References
keymap("n", "<leader>;", ":lua vim.lsp.buf.references()<CR>", opts)

-- Window navigation
keymap("n", "<leader>h", "<C-w>h", opts)
keymap("n", "<leader>j", "<C-w>j", opts)
keymap("n", "<leader>k", "<C-w>k", opts)
keymap("n", "<leader>l", "<C-w>l", opts)

-- Buffer operations
keymap("n", "<leader>a", ":bufdo bdelete<CR>", opts)

-- File operations
keymap("n", "<leader>w", ":w!<CR>", opts)
keymap("n", "<leader>q", ":q!<CR>", opts)
keymap("n", "<leader>x", ":x!<CR>", opts)
keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", opts)
keymap("n", "<leader>f", ":Telescope find_files<CR>", opts)

-- Formatting
keymap("n", "<leader>i", ":lua vim.lsp.buf.format()<CR>", opts)
keymap("n", "<leader>o", ":lua vim.lsp.buf.execute_command({command = '_typescript.organizeImports', arguments = {vim.fn.expand('%:p')}})<CR>", opts)

-- Hover
keymap("n", "gh", ":lua vim.lsp.buf.hover()<CR>", opts)

-- Visual mode mappings
keymap("v", "<leader>c", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
