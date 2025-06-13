-- Custom command to resize window (width or height) by 5 units by default
vim.api.nvim_create_user_command('ResizeWindow', function(opts)
  local direction = opts.args:match('^%S+') or 'width'
  local amount = opts.args:match('%s+(%S+)$') or '+5'
  if direction:lower() == 'width' then
    vim.cmd('vertical resize ' .. amount)
  elseif direction:lower() == 'height' then
    vim.cmd('resize ' .. amount)
  else
    print("Invalid direction. Use 'width' or 'height'.")
  end
end, {nargs = '*'})
