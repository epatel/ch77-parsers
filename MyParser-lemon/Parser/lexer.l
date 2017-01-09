%option prefix="MP_lex_"

%{
#include "parser_globals.h" 
#include "parser.h" 
#include <string.h>
#include <math.h>
int LEX_NAME( line ) = 1;
YYSTYPE LEX_NAME( lval ); 
%}

%%

[0-9]+|[0-9]*\.[0-9]+ { 
  LEX_NAME( lval ).dval = atof(yytext); 
  return NUM; 
}

[ \t] { 
}

\n {
  LEX_NAME( line )++;
}

"(" {
  return LEFTPAREN;
}

")" {
  return RIGHTPAREN;
}
  
_*[A-Za-z][A-Za-z0-9]* {
  LEX_NAME( lval ).string = yytext;
  return NAME;
}

"+" {  return PLUS; }
"-" {  return MINUS; }
"*" {  return TIMES; }
"/" {  return DIVIDE; }

. { 
  return yytext[0]; 
}

%%

void LEX_NAME( error )(char *s) {
  printf("Lex error: '%s' at line: %d\n", s, LEX_NAME( line ));  
}

int LEX_NAME( wrap )(void) {
  return 1;
}
