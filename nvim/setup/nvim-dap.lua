local dap = require('dap')

local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { silent = true, desc = '[DAP] ' .. desc })
end

map('n', '<F5>', dap.continue, 'Continue')
map('n', '<S-F5>', dap.terminate, 'Terminate')
map('n', '<F10>', dap.step_over, 'Step over')
map('n', '<C-F10>', dap.run_to_cursor, 'Run to cursor')
map('n', '<F11>', dap.step_into, 'Step into')
map('n', '<S-F11>', dap.step_out, 'Step out')
map('n', '<Leader>b', dap.toggle_breakpoint, 'Toggle breakpoint')
map('n', '<Leader>B', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, 'Set conditional breakpoint')
map('n', '<Leader>lg', function() dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, 'Set log point')
map('n', '<Leader>dr', dap.repl.open, 'Open REPL')
map('n', '<Leader>dl', dap.run_last, 'Run last')
