# uniword.nvim
treat unicode glyphs as words

for example, `困り物` should be considered a word for motions such as `w`, `b`,
`e`, and `ge`. it should also be considered a text object for `iw` and `aw`.

this plugin works identical to the vanilla keys.

### install & setup (lazy.nvim)

```lua
{
    "jake-stewart/uniword.nvim",
    dependencies = "kana/vim-textobj-user", -- optional for text objects
    config = function()
        require("uniword").setup()
    end
},
```
