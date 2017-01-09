#ifndef __MYPARSER_H__
#define __MYPARSER_H__

typedef void (*result_callback_type)(float value);
typedef void (*error_callback_type)(char *str);

int MyParser_Parse(NSArray *lines, result_callback_type result_cb, error_callback_type error_cb);

#endif /* __MYPARSER_H__ */
