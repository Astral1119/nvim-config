return {
  {
    dir = vim.fn.expand("~/personal/vestiary/livery.nvim"),
    name = "livery.nvim",
    lazy = false,
    -- moonfly loads at priority 1000; the overlay must land after it.
    priority = 999,
    config = function()
      require("livery").setup()
    end,
  },
}
