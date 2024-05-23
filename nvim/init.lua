local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins")

-- Loading .env.nvim as a default environment
local function source_env_nvim()
    local cwd = vim.fn.getcwd()
    local env_nvim_path = cwd .. "/.env.nvim"

    if vim.fn.filereadable(env_nvim_path) == 1 then
        local env_nvim_file = io.open(env_nvim_path, "r")
        if env_nvim_file then
            for line in env_nvim_file:lines() do
              local key, value = line:match("^(%w+)%s*=%s*(.+)$")
              if key and value then
                vim.fn.setenv(key, value)
                -- print("Set environment variable: " .. key .. "=" .. value)
              end
            end
            env_nvim_file:close()
            print(".env.nvim sourced from " .. cwd)
        else
            print("Failed to open .env.nvim file")
        end
    else
        print("No .env.nvim file found in " .. cwd)
    end
end

source_env_nvim()

vim.api.nvim_create_augroup('SourceEnvNvim', { clear = true })
vim.api.nvim_create_autocmd({ 'VimEnter', 'DirChanged' }, {
    group = 'SourceEnvNvim',
    callback = source_env_nvim,
})
