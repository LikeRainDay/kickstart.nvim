-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- vim: ts=2 sts=2 sw=2 et

-- local function remove_file(file_path)
--   local success, err_msg = os.remove(file_path)
--   if success then
--       print("File removed successfully.")
--   else
--       print("Failed to remove file: " .. err_msg)
--   end
-- end

-- -- [[ listener godot unix  ]]
-- local projectfile = vim.fn.getcwd() .. '/project.godot'
-- local f = io.open(projectfile, "r")
-- if f then
--   remove_file('./godothost')
--   io.close(f)
--   vim.fn.serverstart './godothost'
-- else
--   print("file is not exit, skip godot server start. ^_^")
-- end