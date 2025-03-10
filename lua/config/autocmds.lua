-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "haskell", "python", "lua" },
  command = "setl ts=8 sts=4 sw=4 et sr",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  command = "setl ts=4 sts=4 sw=4 noet sr",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby", "crystal", "haml", "yaml", "scss", "coffee", "html", "json", "sh", "bash", "zsh" },
  command = "setlocal sw=2 ts=2 sts=2 et",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  command = "setlocal sw=3 ts=3 sts=3 et",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "ruby" },
  command = "setlocal norelativenumber", -- those make scrolling ruby files horribly slow
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql" },
  command = "setlocal sw=4 ts=4 sts=4 et",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sshconfig" },
  command = "setlocal sw=4 ts=4 sts=4 et",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "gitcommit" },
  command = "setlocal spell",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  command = "setl cin cino+=:0,(s,l1",
  desc = "C,C++ specific settings",
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "plaintex", "tex" },
  command = "setl conceallevel=0 lbr|lua Wordwrap_updown_motions()",
  desc = "LaTeX specific settings",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.vhost",
  command = "set ft=apache",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.nftables",
  command = "setlocal sw=2 ts=2 sts=2 et",
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  command = "setlocal spell",
})
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "Jenkinsfile",
  command = "set ft=groovy",
})

-- Disable autoformat for python files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "python" },
  callback = function()
    vim.b.autoformat = false
  end,
})
