-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Markdown settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    -- Bật wrap text
    vim.opt_local.wrap = true
    -- Bật spell check
    vim.opt_local.spell = true
    -- Thiết lập spell languages (tiếng Anh và tiếng Việt nếu có)
    vim.opt_local.spelllang = "en,vi"
    -- Line break ở các khoảng trắng
    vim.opt_local.linebreak = true
    -- Tab size cho markdown
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.expandtab = true
    -- Concealment level (ẩn markdown syntax khi không ở dòng đó)
    vim.opt_local.conceallevel = 2
    -- Text width
    vim.opt_local.textwidth = 80
  end,
})
