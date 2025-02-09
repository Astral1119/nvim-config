return {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh 1",  -- Force local compilation
  config = function()
    require("sniprun").setup({
      interpreter_options = {
        Cpp_original = {
          compiler = "clang++ -std=c++17 -stdlib=libc++"
        }
      }
    })
  end,
}


-- https://www.reddit.com/r/neovim/comments/yx0fcv/til_you_can_run_code_inside_markdown_o/
