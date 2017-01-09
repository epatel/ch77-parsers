%{

#define YYSTYPE double
#include <math.h>
#include <stdio.h>

int yylex();
int yyerror(char *s);

%}

%token NUM

%%

%left '-' '+';
%left '/' '*';

input:    /* empty */
        | input line
;

line:     '\n'
        | exp '\n'  { printf ("\t%.10g\n", $1); }
;

exp:      NUM             { $$ = $1;         }
        | exp '+' exp     { $$ = $1 + $3;    }
        | exp '-' exp     { $$ = $1 - $3;    }
        | exp '*' exp     { $$ = $1 * $3;    }
        | exp '/' exp     { $$ = $1 / $3;    }
;

%%

#include <ctype.h>

int yylex()
{
    int c;
    
    /* skip white space  */
    while ((c = getchar ()) == ' ' || c == '\t')
        ;

    /* process numbers   */
    if (c == '.' || isdigit (c)) {
        ungetc (c, stdin);
        scanf ("%lf", &yylval);
        return NUM;
    }
    
    /* return end-of-file  */
    if (c == EOF)
        return 0;
    
    /* return single chars */
    return c;
}

int yyerror(char *s)  /* Called by yyparse on error */
{
    printf ("%s\n", s);
    return 0;
}
