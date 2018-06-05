%option noyywrap
  #include <stdlib.h>
  #include <string.h>
  #include "rpn.tab.h"


%%


[0-9]+("/".[0-9]+)?	{ yylval.num = atoi(yytext);   return NUMERO;    }
[a-zA-Z_][a-zA-Z0-9_]{0,31}	{ strcpy(yylval.nome_var, yytext); return VARIAVEL; }
"+"		return OP_SOMA;
"-"		return OP_SUB;
"*"		return OP_MULT;
"/"		return OP_DIV;
"^"		return OP_POT;
"SQRT"	return OP_SQRT;
"("		return LP;
")"		return RP;
"="		return OP_IGUAL;
[ \t]+
[\r\n]		{ return EOL;}
