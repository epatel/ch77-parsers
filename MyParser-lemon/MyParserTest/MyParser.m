#include "parser_globals.h"
#include "parser.h"

#import "MyParser.h"

// Lex interface
typedef struct yy_buffer_state *YY_BUFFER_STATE;
YY_BUFFER_STATE  LEX_NAME( _scan_string )( const char *p );
int              LEX_NAME( lex )();
void             LEX_NAME( lex_destroy )();

extern void (*result_callback)(float value);
extern void (*error_callback)(char *str);

int MyParser_Parse(NSArray *lines, result_callback_type result_cb, error_callback_type error_cb) {
  result_callback = result_cb;
  error_callback = error_cb;
    
  struct Token *token = NULL;
  int yv;
  int lineNum = 0;
  
  void *parser = LEMON_NAME( ParseAlloc )(malloc);

  LEX_NAME( _scan_string )([[lines objectAtIndex:lineNum++] cStringUsingEncoding:NSUTF8StringEncoding]);

  while (1) {

    yv = LEX_NAME( lex )();
    
    if (!yv) { 
      if (lineNum < [lines count])
        LEX_NAME( _scan_string )([[lines objectAtIndex:lineNum++] cStringUsingEncoding:NSUTF8StringEncoding]);
      else 
        break;
    } else {
      token = malloc(sizeof(struct Token)); 
      token->value = 0;
      token->string = NULL;
      switch (yv) {
        case NUM:
          token->value = LEX_NAME( lval ).dval;
          break;
        case NAME:
          token->string = strdup(LEX_NAME( lval ).string);
          break;
      }
      LEMON_NAME( Parse )(parser, yv, token);
    } 

  }
  
  LEX_NAME( lex_destroy )();
  
  LEMON_NAME( Parse )(parser, 0, token);
  LEMON_NAME( ParseFree )(parser, free);

  return 0;
}
