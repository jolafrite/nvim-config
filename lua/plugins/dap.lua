local gh = require('utils').gh

PackageManager.add {
  [1] = gh 'mfussenegger/nvim-dap',
  dependencies = {
    gh 'rcarriga/nvim-dap-ui',
    gh 'theHamsta/nvim-dap-virtual-text',
    gh 'mfussenegger/nvim-dap-python',
  },
  lazy = false,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local dapvt = require('nvim-dap-virtual-text')

    dapvt.setup {
      display_callback = function(variable_value)
        local string = variable_value
        if #string > 30 then
          string = string:sub(1, 30) .. '...'
        end
        return string
      end,
    }

    dapui.setup {
      controls = {
        enabled = true,
        element = 'repl',
        icons = {
          pause = ' ',
          step = ' ',
          run = ' ',
          disconnect = '﫸 ',
          continue = ' ',
          step_back = ' ',
          step_over = ' ',
          step_into = ' ',
          step_out = ' ',
          repl = '﫸 ',
          terminate = '﫸 ',
        },
      },
    }

    -- Auto open/close DAP UI
    dap.listeners.before_event_terminate['dapui_close'] = function()
      dapui.close()
    end
    dap.listeners.after_event_terminate['dapui_open'] = function()
      dapui.open()
    end

    -- Basic DAP keymaps
    vim.keymap.set('n', '<F5>', function() dap.continue() end, { desc = 'Debug: Continue' })
    vim.keymap.set('n', '<F10>', function() dap.step_over() end, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F11>', function() dap.step_into() end, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F12>', function() dap.step_out() end, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', function() dap.toggle_breakpoint() end, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dB', function() dap.set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'Debug: Conditional Breakpoint' })
    vim.keymap.set('n', '<leader>dl', function() dap.list_breakpoints() end, { desc = 'Debug: List Breakpoints' })
    vim.keymap.set('n', '<leader>dc', function() dap.clear_breakpoints() end, { desc = 'Debug: Clear Breakpoints' })
    vim.keymap.set('n', '<leader>dr', function() dap.repl.open() end, { desc = 'Debug: REPL' })
    vim.keymap.set('n', '<leader>dt', function() dapui.toggle() end, { desc = 'Debug: Toggle UI' })
    vim.keymap.set('n', '<leader>dx', function() dap.terminate() end, { desc = 'Debug: Terminate' })
  end,
}