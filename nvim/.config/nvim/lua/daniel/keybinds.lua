--ThePrimeagen's remap, that's slightly altered
vim.g.mapleader = " "

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("x", "<leader>p", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<leader>fd", vim.lsp.buf.format)

vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

--My own keybinds for terminal and running code
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>')

vim.keymap.set("n", "<leader>t", function()
    vim.opt.splitbelow = true
    vim.api.nvim_command('split')
    vim.api.nvim_command('terminal')
    vim.api.nvim_command("horizontal resize -10")
    vim.api.nvim_command("startinsert")
end)

vim.keymap.set("n", "<leader>rc", function()
    vim.opt.splitright = true
    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('terminal g++ %; ./a.out ; rm a.out')
    vim.api.nvim_command("vertical resize -30")
    vim.api.nvim_command("startinsert")
end)

vim.keymap.set("n", "<leader>rp", function()
    vim.opt.splitright = true
    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('terminal python3 %')
    vim.api.nvim_command("vertical resize -30")
    vim.api.nvim_command("startinsert")
end)

vim.keymap.set("n", "<leader>rs", function()
    vim.opt.splitright = true
    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('terminal http-server .')
    vim.api.nvim_command("vertical resize -30")
    vim.api.nvim_command("startinsert")
end)

vim.keymap.set("n", "<leader>rn", function()
    vim.opt.splitright = true
    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('terminal node %')
    vim.api.nvim_command("vertical resize -30")
    vim.api.nvim_command("startinsert")
end)

vim.keymap.set("n", "<leader>rj", function()
    vim.opt.splitright = true
    vim.api.nvim_command('vsplit')
    vim.api.nvim_command('terminal javac %;java %:r;rm %:r.class')
    vim.api.nvim_command("vertical resize -30")
    vim.api.nvim_command("startinsert")
end)


--My own keybinds for word substitution
vim.keymap.set("n", "<leader>s", function()
    local number = vim.v.count

    if number == 0
    then
        vim.api.nvim_feedkeys(":%s/", "n", true)
    else
        vim.api.nvim_feedkeys(":.,+" .. number .. " s/", "n", true)
    end
end)

--Removing some keybinds
vim.keymap.set("n", "<C-q>", "")

--Removing autocomplete box for text files
vim.keymap.set("n", "<leader>ncmp", "<cmd>lua require('cmp').setup.buffer { enabled = false }<CR>")
vim.keymap.set("n", "<leader>cmp", "<cmd>lua require('cmp').setup.buffer { enabled = true }<CR>")

-- My own take on ThePrimeagen's tmux-sessionizer, bc I couldn't get his to 
-- work for me
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww ~/.local/bin/scripts/tmux-sessionizer<CR>")
