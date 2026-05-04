return {
  "skywind3000/asyncrun.vim",
  config = function()
    vim.keymap.set("n", "<leader>r", ":AsyncRun ")
    local os = vim.loop.os_uname().sysname
    if os == "Windows_NT" then
      vim.g.asyncrun_encs = 'gbk'
    end
  end,
}
