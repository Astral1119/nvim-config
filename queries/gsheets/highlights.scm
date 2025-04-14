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
  "-" "*" "/"
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
] @punctuation.bracket

; Literals
(string) @string
(number) @number
(boolean) @constant.builtin

; Identifiers
(identifier) @variable

; Function calls
(function_call
  (identifier) @function)

; Cell references and patterns
(cell_reference) @variable
(cell_pattern) @variable

; Expressions
(expression) @expression
(operator_expression) @operator
(parenthesized_expression) @punctuation.bracket
(array_literal) @punctuation.bracket
