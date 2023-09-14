REGEX = [[\v(<@=(\i@!\k)+|<@=\k+|(\k@!\S)+)]];

local function createMappings()
    local function callback(flags, regex)
        return function()
            vim.fn.search(regex, "W" .. flags)
        end
    end

    vim.keymap.set({"n", "v"}, "w", callback("", REGEX .. "|^"))
    vim.keymap.set({"n", "v"}, "b", callback("b", REGEX .. "|^"))
    vim.keymap.set({"n", "v", "o"}, "ge", callback("be", REGEX .. "|^"))
    vim.keymap.set({"n", "v"}, "e", callback("e", REGEX))
    vim.keymap.set("o", "w", callback("e", REGEX .. ".|^"))
    vim.keymap.set("o", "e", callback("e", REGEX .. "."))
    vim.keymap.set("o", "b", callback("b", REGEX .. "|^"))
end

local function createTextObject()
    vim.cmd([[
        call textobj#user#plugin('uniword', {
        \   'uniword': {
        \     'pattern': ']] .. REGEX .. [[',
        \     'select': ['aw', 'iw'],
        \   }
        \ })
    ]])
end

return {
    setup = function()
        createMappings()
        pcall(createTextObject)
    end
}
