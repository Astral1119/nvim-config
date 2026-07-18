" Drop Coqtail's buggy CoqtailJoinspaces autocmds for this buffer.
"
" Coqtail (ftplugin/coq.vim) registers a BufLeave autocmd that does an
" unconditional `unlet b:_coqtail_save_js`, while its matching BufEnter guards
" the `let` with `if !exists(...)`. snacks.nvim's picker juggles window focus
" via nvim_set_current_win (snacks/win.lua:505), firing BufLeave on a .v buffer
" without a preceding BufEnter -- so the unlet throws
"   E108: No such variable: "b:_coqtail_save_js"
"
" We drive proofs through coq-lsp, not Coqtail's interactive layer, so its
" 'joinspaces' bookkeeping is unneeded (and Neovim defaults 'joinspaces' off
" anyway). Upstream the real fix is a one-char change: `unlet!`.
silent! autocmd! CoqtailJoinspaces * <buffer>
