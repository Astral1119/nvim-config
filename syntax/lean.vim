" Lean syntax highlighting.
if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword leanDeclaration
      \ abbrev axiom class def example inductive instance lemma namespace
      \ opaque structure theorem variable

syn keyword leanCommand
      \ by calc cases constructor exact have intro intros rfl rw simp
      \ simpa unfold refine apply aesop omega ring norm_num

syn keyword leanKeyword
      \ if then else let in match with where forall fun Type Prop Sort
      \ import open section end deriving extends

syn match leanAttribute "@\\[[^]]*\\]"
syn match leanNumber "\v<\d+>"
syn region leanString start=+"+ skip=+\\"+ end=+"+
syn region leanComment start="/-" end="-/" contains=leanComment
syn match leanLineComment "--.*$"

hi def link leanDeclaration Statement
hi def link leanCommand Function
hi def link leanKeyword Keyword
hi def link leanAttribute PreProc
hi def link leanNumber Number
hi def link leanString String
hi def link leanComment Comment
hi def link leanLineComment Comment

let b:current_syntax = "lean"
