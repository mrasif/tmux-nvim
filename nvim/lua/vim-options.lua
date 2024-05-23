vim.opt.expandtab=true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Set 2 space tab for specific file extension settings
local function set_specific_tab_settings()
    local filetypes = {"lua", "yaml", "json", "txt"}
    for _, filetype in ipairs(filetypes) do
        vim.api.nvim_create_autocmd("FileType", {
            pattern = filetype,
            callback = function()
                vim.opt_local.expandtab = true
                vim.opt_local.shiftwidth = 2
                vim.opt_local.tabstop = 2
                vim.opt_local.softtabstop = 2
            end
        })
    end
end
set_specific_tab_settings()
vim.opt.mouse = ""

vim.g.mapleader = " "
vim.g.background = "light"

vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.wo.number = true

