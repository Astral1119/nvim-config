; highlights.scm

; Keywords
[
  "TRUE"
  "FALSE"
] @constant.builtin

; Error literals
[
  "#DIV/0!"
  "#ERROR!"
  "#N/A"
  "#NAME?"
  "#NULL!"
  "#NUM!"
  "#REF!"
  "#VALUE!"
] @constant.builtin

; Operators
[
  "+"
  "-"
  "*"
  "/"
  "^"
  "&"
  "%"
  "="
  "<"
  ">"
  "<="
  ">="
] @operator

; Delimiters and punctuation
[
  ","
  ":"
  ";"
] @punctuation.delimiter

[
  "{"
  "}"
  "("
  ")"
] @punctuation.bracket

; Literals
(string) @string
(number) @number
(boolean) @constant.builtin

; Identifiers
(identifier) @variable
(bracket_identifier) @string.special
(bracket_access "." @punctuation.delimiter)

; Function calls
(function_call
  function_name: (_) @function)

; Cell references and patterns
(cell_pattern) @variable.builtin
(sheet_reference
  (identifier) @variable.builtin
)

; Expressions
(expression) @expression
(operator_expression) @operator
(parenthesized_expression) @punctuation.bracket
(array_literal) @punctuation.bracket
