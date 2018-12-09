
%%

[ \t\n]+	;
use						return USE;
methods					return METHODS;
start					return START;
integer					return INTEGER;
real					return REAL;
character				return CHARACTER;
loop					return LOOP;
if						return IF;
elif					return ELIF;
else					return ELSE;
switch					return SWITCH;
case					return CASE;
default					return DEFAULT;
return                  return RETURN;
not						return NOT;
true					return TRUE;
false					return FALSE;
and						return AND;
or						return OR;
"<"						return LESS_THAN;
">"						return GREATER_THAN;
"<="					return LESS_THAN_EQUAL_TO;
">="					return GREATER_THAN_EQUAL_TO;
"=="					return EQUAL_TO;
"!="					return NOT_EQUAL_TO;
[a-zA-Z][a-zA-Z0-9]*	return NAME;
[0-9]+					return INTEGER_VALUE;
[0-9]+.[0-9]+			return REAL_VALUE;
\"(.|\n)*\"          return STRING;
";"                     return (';');
"+"                     return ('+');
"*"                     return ('*');
"/"                     return ('/');
"="                     return ('=');
"("                     return ('(');
")"                     return (')');
"{"                     return ('{');
"}"                     return ('}');
"-"                     return ('-');
":"                     return (':');
"["                     return ('[');
"]"                     return (']');
","                     return (',');	
.						printf("Unknown Token '%s' !\n", yytext);

%%

