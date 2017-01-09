
#define LEX_NAME( _name ) MP_lex_ ## _name
#define LEMON_NAME( _name ) MP_lemon_ ## _name

struct Token {
  double value;
  char *string;
};

typedef union {
  double dval;
  char *string;
} LEX_NAME( stype );

#define YYSTYPE LEX_NAME( stype )

extern YYSTYPE LEX_NAME( lval );

void *LEMON_NAME( ParseAlloc )(void *(*mallocProc)(size_t));
void LEMON_NAME( ParseTrace )(FILE *TraceFILE, char *zTracePrompt);
void LEMON_NAME( ParseFree )(void *p, void (*freeProc)(void*));  
void LEMON_NAME( Parse )(void *p, int major, struct Token *t);

extern void (*result_callback)(float value);
extern void (*error_callback)(char *str);
