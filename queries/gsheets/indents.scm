(parenthesized_expression) @indent.begin
(parenthesized_expression) @indent.end @indent.branch
(function_call) @indent.begin
(function_call) @indent.end @indent.branch
(array_literal) @indent.begin
(array_literal) @indent.end @indent.branch
(operator_expression) @indent.align

(arguments "(" @indent.begin ")" @indent.end)
(arguments "," @indent.branch)
(arguments_immediate "(" @indent.begin ")" @indent.end)
(arguments_immediate "," @indent.branch)
(parenthesized_expression "(" @indent.begin ")" @indent.end)
(array_literal "{" @indent.begin "}" @indent.end)
(array_literal "," @indent.branch)
(array_literal ";" @indent.branch)
