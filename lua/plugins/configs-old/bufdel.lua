return function ()
    local status_ok, bufdel = pcall(require, 'bufdef')
    if not status_ok then
        return
    end

    bufdef.setup({
        next = 'tabs',
        quit = true,  -- quit Neovim when last buffer is closed
    })
end
