{
  open Ref_parser
}

let int_literal =
  ['0'-'9'] ['0'-'9' '_']*
let var =
  ['A'-'Z' 'a'-'z' '_' '\192'-'\214' '\216'-'\246' '\248'-'\255' ]
  ['A'-'Z' 'a'-'z' '_' '.'
     '\192'-'\214' '\216'-'\246' '\248'-'\255' '\'' '0'-'9']*

rule token = parse
   [' ' '\t' '\r' '\n']	{ token lexbuf }
  | "//" [^'\n'] * '\n'	{ COMMENT }
    
  | "class"				{ CLASS }
  | "in"				{ IN }
  | "element"			{ ELEMENT }
  | "child"				{ CHILD }
  | "list"				{ LIST }
  | "one"				{ ONE }
  | "of"				{ OF }
  
  | "{"					{ LCUR }
  | "}"					{ RCUR }
  | "("					{ LPAR }
  | ")"					{ RPAR }
  | ":="				{ COLEQ }
  | ":"					{ COLON }
  
  | int_literal			{ INT (int_of_string (Lexing.lexeme lexbuf)) }
  | (['0'-'9']* as ipart) '.' (['0'-'9']* as fpart)
      { let fpart =
          if fpart = "" then 0. else
            (float_of_string fpart) /.
            (10. ** (float_of_int (String.length fpart)))
        in
        let ipart = if ipart = "" then 0. else float_of_string ipart in
          FLOAT (ipart +. fpart) }
  | var as v			{ VAR v }

  | '\'' (([^'\''] | '\\' '\'')* as s) '\''   {
            STRING (Str.global_replace (Str.regexp "\\\\'") "'" s) }
  | '"' (([^'"'] | '\\' '"')* as s) '"'   {
            STRING (Str.global_replace (Str.regexp "\\\\\"") "\"" s) }

  | eof					{ raise End_of_file }
