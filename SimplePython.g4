grammar SimplePython;

program : statement* EOF ;

statement 
	: assignment 
	| conditional
	;

assignment
	: ID EQUAL expression
	| ID PLUSEQUAL expression
	| ID DIVEQUAL expression
	| ID MULTEQUAL expression
	| ID MINUSEQUAL expression
	;

// Note: MULT, DIV, MOD have higher operator precedence than PLUS, MINUS in a left-recursive parser
expression
	: expression (MULT | DIV | MOD) expression
	| expression (PLUS | MINUS) expression
	| MINUS expression
	| LPAR expression RPAR
	| LBRACK (expression (COMMA expression)*)? RBRACK
	| INT
	| FLOAT
	| STRING
	| BOOL
	| ID
	;

comparison
	: expression (GREATERTHAN | LESSTHAN | GREATERTHANOREQUALTO | LESSTHANOREQUALTO | EQUALTO) expression
	;

// Implement conditional statement parser logic here (finish/fix this)
conditional
	: IF comparison (INDENTATION (ELIF | ELSE) comparison)*
	| 
	;

// Lexer rules/tokens defined below (this is a combined grammar)

// Defined operators
EQUAL : '=' ;
PLUSEQUAL : '+=' ;
DIVEQUAL : '/=' ;
MULTEQUAL : '*=' ;
MINUSEQUAL : '-=' ;
PLUS : '+' ;
MINUS : '-' ;
MULT : '*' ;
DIV : '/' ;
MOD : '%' ;
LBRACK : '[' ;
RBRACK : ']' ;
COMMA : ',' ;
LPAR : '(' ;
RPAR : ')' ;

// Comparisons
GREATERTHAN : '>' ;
LESSTHAN : '<' ;
GREATERTHANOREQUALTO : '>=' ;
LESSTHANOREQUALTO : '<=' ;
EQUALTO : '==' ;

// Other misc (indentation necessary for parsing Python code blocks)
COLON : ':' ;
INDENTATION : [\t] ;

// Keywords Defined (these take precedence over ID)
IF : 'if' ;
ELSE : 'else' ;
ELIF : 'elif' ;
NOT : 'not' ;
OR : 'or' ;
AND : 'and' ;

// Defined id, types, and whitespace
BOOL : 'True' | 'False' ;
ID : [a-zA-Z_][a-zA-Z_0-9]* ;
INT : [0-9]+ ;
FLOAT : [0-9]+ '.' [0-9]+ ;

// Includes both single-asterisk chars (strings) and double-quote strings
STRING : '"' ~["\r\n]* '"'
       | '\'' ~['\r\n]* '\''
       ;

WS : [ \t\r\n]+ -> skip ;
