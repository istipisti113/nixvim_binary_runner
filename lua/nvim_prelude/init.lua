local M = {}

local defaults = {} local config = {}

function M.setup(opts) --opts
  for command, name in pairs(opts) do
    vim.api.nvim_create_user_command(command, create_repl(name, command), {})
  end
  --print("setup ran")
end

function M.test()
  print("hello from the plugin")
end

function create_repl(command, name)
  return function()
    -- Create new split
    vim.api.nvim_command("tabnew")
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_command("buffer " .. buf)

    -- Start REPL
    vim.fn.jobstart(command, {
      term = true
    })

    -- Enter insert mode to start typing
    vim.cmd("startinsert")
  end
end
--

return M
