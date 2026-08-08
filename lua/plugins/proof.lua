return {
  {
    "whonore/Coqtail",
    ft = "coq",
    init = function()
      vim.g.coqtail_coq_path = vim.fn.expand("~/sandbox/current/whim/tools")
      vim.g.coqtail_coq_prog = "rocq-coqtop"
      vim.g.coqtail_map_prefix = "<localleader>c"
      vim.g.coqtail_noimap = 1
    end,
  },
}
