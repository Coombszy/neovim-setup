return {
    "numToStr/Comment.nvim",
    tag = "v0.8.0",
    event = "VimEnter",
    config = function()
        require("Comment").setup()
    end
}
