" Coq/Rocq syntax highlighting.
if exists("b:current_syntax")
  finish
endif

syn case match

syn keyword coqVernacular
      \ About Add Arguments Asymmetric Patterns Check Coercion CoFixpoint
      \ Context Corollary Defined Definition End Example Export Fact Fixpoint
      \ From Global Goal Hint Hypothesis Import Include Inductive Instance
      \ Lemma Local Module Next Obligation Parameter Print Program Proof
      \ Proposition Qed Record Require Section Set Theorem Type Unset Variable
      \ Variables

syn keyword coqCommand
      \ Admitted Abort apply assert assumption auto cbn cbv change clear
      \ constructor destruct discriminate done eapply eauto econstructor
      \ edestruct eexists epose proof erewrite exact exists f_equal
      \ firstorder intros inversion iApply iAssert iDestruct iFrame iIntros
      \ iMod iModIntro iNext iPoseProof iPureIntro iSplit iStartProof
      \ iSteps iExists left lia naive_solver pose proof reflexivity rewrite
      \ right simpl solve subst transitivity unfold

syn keyword coqKeyword
      \ forall fun fix cofix match with end let in if then else return
      \ Prop Set Type where by as at

syn match coqIdentifier "'[A-Za-z_][A-Za-z0-9_']*"
syn match coqNumber "\v<\d+>"
syn region coqString start=+"+ skip=+""+ end=+"+
syn region coqComment start="(\*" end="\*)" contains=coqComment

hi def link coqVernacular Statement
hi def link coqCommand Function
hi def link coqKeyword Keyword
hi def link coqIdentifier Identifier
hi def link coqNumber Number
hi def link coqString String
hi def link coqComment Comment

let b:current_syntax = "coq"
