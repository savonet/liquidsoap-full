%{

open Ref_types

exception Unbound of string

let parse_error s = (* Called by the parser function on error *)
  print_endline s;
  flush stdout

%}

%token <string> VAR
%token <string> STRING
%token <int> INT
%token <float> FLOAT
%token CLASS IN ELEMENT CHILD LIST ONE OF
%token LCUR RCUR LPAR RPAR COLEQ COLON
%token COMMENT

%start model
%type <unit> model

%%

model: { }
  | model parser_class { }
  | model COMMENT { }

parser_class:
  | CLASS VAR IN STRING LCUR class_contents RCUR { Printf.fprintf stderr "New class: %s.\n" $2 ; add_class $2 { name=$2 ; xmlns=$4 ; contents=$6 }; }

class_contents: { [] }
  | class_contents element { $2::$1 }
  | class_contents child { $2::$1 }

element:
  | ELEMENT VAR ml_repres element_type default { XML_Element { tag=$2 ; var_name=(if $3 <> "" then $3 else $2) ; var_type=$4 ; default=$5 } }

child:
  | CHILD VAR ml_repres COLON child_cardinality child_type { XML_Child ( { tag=$2 ; var_name=(if $3 <> "" then $3 else $2) ; var_type=$6 ; default=None }, $5 ) }

ml_repres: { "" }
  | LPAR VAR RPAR { $2 }

element_type:
  | COLON VAR { $2 }

child_cardinality:
  | LIST OF { true }
  | ONE OF { false }

child_type:
  | VAR { ignore (try ignore (find_class $1) with Not_found -> raise (Unbound $1)); $1 }

default: { None }
  | COLEQ STRING { Some $2 }
  | COLEQ INT { Some (string_of_int $2) }
  | COLEQ FLOAT { Some (string_of_float $2) }

%%
