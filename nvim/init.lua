if vim.fn.has "nvim-0.8" == 0 then error "Need Neovim 0.8+ in order to use this config" end

-- Disable annoying deprecated message
vim.deprecate = function() end

-- inicia o lazy package manager e seus plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)

--carrega os arquivos de configuracao
for _, source in ipairs {
    "plugins",
    "options",
--    "mappings",
--    "autocmds",
} do
    local ok, fault = pcall(require, source)
    if not ok then vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\n" .. fault) end
end