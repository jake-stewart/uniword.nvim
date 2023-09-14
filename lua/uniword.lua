REGEX = [[\v(<@=(\i@!\k)+|<@=\k+|(\k@!\S)+)]];

local function createMappings()
    local function callback(flags, regex)
        return function()
            local count = vim.v.count > 0 and vim.v.count or 1
            for _ = 1, count do
                vim.fn.search(regex, "W" .. flags)
            end
        end
    end

    vim.keymap.set({"n", "v"}, "w", callback("", REGEX .. "|^"))
    vim.keymap.set({"n", "v"}, "b", callback("b", REGEX .. "|^"))
    vim.keymap.set({"n", "v", "o"}, "ge", callback("be", REGEX .. "|^"))
    vim.keymap.set({"n", "v"}, "e", callback("e", REGEX))
    vim.keymap.set("o", "w", callback("w", REGEX .. "|^"))
    vim.keymap.set("o", "e", callback("e", REGEX .. "."))
    vim.keymap.set("o", "b", callback("b", REGEX .. "|^"))
    vim.keymap.set("n", "cw", "ce", {remap = true})
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
