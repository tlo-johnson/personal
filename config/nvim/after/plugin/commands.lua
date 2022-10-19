local command = vim.api.nvim_create_user_command
local cmd = vim.cmd

command('Terminal', function(opts)
  local name = 'term://'

  if opts.args == '' then
    name = name .. 'shell'
  else
    name = name .. opts.args
  end

  if vim.fn.bufexists(name) == 0 then
    vim.cmd('terminal')
    vim.cmd('file ' .. name)
  else
    vim.cmd('buffer ' .. name)
  end

end, { nargs = '?' })

command('GitBlame', function()
  cmd('enew')
  cmd('read! git blame #')
end, { })
