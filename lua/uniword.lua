REGEX = [[\v(<@=(\i@!\k)+|<@=\k+|(\k@!\S)+)]];

local function createMappings()
    local function map(key, flags, regex)
        vim.keymap.set({"n", "o", "v"}, key, function()
            vim.fn.search(regex, flags)
        end)
    end

    map("w", "", REGEX .. "|^")
    map("b", "b", REGEX .. "|^")
    map("ge", "be", REGEX .. "|^")
    map("e", "e", REGEX)
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
