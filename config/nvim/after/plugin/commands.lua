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
    cmd('terminal')
    cmd('keepalt file ' .. name)
  else
    cmd('buffer ' .. name)
  end

end, { nargs = '?' })

command('Notes', function ()
  local notes = {
    getty = "~/ta/getty/notes.md",
    operto = "~/ta/operto/notes.md",
  }

  local current_directory = vim.fn.getcwd()
  for key, value in pairs(notes) do
    if string.find(current_directory, key) then
      return cmd('edit ' .. value)
    end
  end

  cmd('edit ~/ta/personal/notes.md')
end, { })
