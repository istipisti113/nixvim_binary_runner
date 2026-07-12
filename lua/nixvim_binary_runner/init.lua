local M = {}

local defaults = {}
local config = {}

function M.setup(opts)
    config = vim.tbl_deep_extend("force", defaults, opts or {})
end 

function M.test()
  print("hello from the plugin")
end

local function create_repl(command, name)
    return function()
        -- Create new split
        --vim.api.nvim_command("vsplit")
        vim.api.nvim_command("tabnew")
        local buf = vim.api.nvim_create_buf(false, true)
        vim.api.nvim_command("buffer " .. buf)
        
        -- Start REPL
        vim.fn.termopen(command, {
            on_exit = function(_, code)
                print(name .. " REPL exited with code: " .. code)
            end
        })
        
        -- Enter insert mode to start typing
        vim.cmd("startinsert")
    end
end

-- Register REPL commands
vim.api.nvim_create_user_command('Steel', create_repl("steel", "Steel"), {})
vim.api.nvim_create_user_command('Raa', create_repl("rust-ai-assistant", "ai"), {})

