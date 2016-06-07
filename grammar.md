Copyright (c) 2015-2016, the Selfie Project authors. All rights reserved. Please see the AUTHORS file for details. Use of this source code is governed by a BSD license that can be found in the LICENSE file.

Selfie is a project of the Computational Systems Group at the Department of Computer Sciences of the University of Salzburg in Austria. For further information and code please refer to:

http://selfie.cs.uni-salzburg.at

This is the grammar of the C Star (C*) programming language.

C* is a small Turing-complete subset of C that includes dereferencing (the * operator) but excludes data structures, bitwise and Boolean operators, and many other features. C* is supposed to be close to the minimum necessary for implementing a self-compiling, single-pass, recursive-descent compiler.

Keywords: int, while, if, else, return, void, struct

```
digit            = "0" | ... | "9" .

integer          = digit { digit } .

letter           = "a" | ... | "z" | "A" | ... | "Z" .

identifier       = letter { letter | digit | "_" } .

type             = ("struct" | "int") [ "*" ] .

cast             = "(" type ")" .

dimensions       = "[" literal "]" [ "[" literal "]" ]

selector         = "[" expression <constantVal> "]" [ "[" expression <constantVal> "]" ].

record           = "struct" identifier "{" {variable} "}"

call             = identifier "(" [ expression <constantVal> { "," expression <constantVal> } ] ")" .

literal          = integer | "'" ascii_character "'" .

factor <constantVal>   = ["!"][ cast ]
                    ( [ "*" ] ( identifier | "(" expression <constantVal> ")" ) |
                      call |
                      literal |
                      identifier [ selector ]|
                      """ { ascii_character } """ ) .

term <constantVal>             = factor <constantVal> { ( "*" | "/" | "%" ) factor <constantVal> } .

simpleExpression <constantVal> = [ "-" ] term <constantVal> { ( "+" | "-" ) term <constantVal> } .

shiftExpression <constantVal>  = simpleExpression <constantVal> { ("<<" | ">>") simpleExpression <constantVal> } .

compareExpression <constantVal>       = shiftExpression <constantVal> [ ( "==" | "!=" | "<" | ">" | "<=" | ">=" ) shiftExpression <constantVal> ] .

andExpression <constantVal>       = compareExpression <constantVal> [ ( "&&" ) compareExpression <constantVal> ] .

expression <constantVal>       = andExpression <constantVal> [ ( "||" ) andExpression <constantVal> ] .

while            = "while" "(" expression <constantVal> ")"
                             ( statement |
                               "{" { statement } "}" ) .

if               = "if" "(" expression <constantVal> ")"
                             ( statement |
                               "{" { statement } "}" )
                         [ "else"
                             ( statement |
                               "{" { statement } "}" ) ] .

return           = "return" [ expression <constantVal> ] .

statement        = ( [ "*" ] identifier [selector]| "*" "(" expression <constantVal> ")"  "="
                    expression <constantVal> ";" |
                    identifier "[" expression "]" ";" |
                    call ";" |
                    while |
                    if |
                    return ";" .

variable         = type identifier [ dimensions ].

procedure        = "(" [ variable { "," variable } ] ")"
                    ( ";" | "{" { variable ";" } { statement } "}" ) .

cstar            = { type identifier [ dimensions ] [ "=" [ cast ] [ "-" ] literal ] ";" |
                   ( "void" | type ) identifier procedure } .
```
