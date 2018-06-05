%{
#include <stdio.h>//biblioteca para funções matemáticas
#include <math.h> 
#include <string.h>
#include <stdlib.h>

extern int yylex( void );

struct	{
	char nome[32];
	int valor;
	}
	vars[100];

int vars_preenchidas = 0;

int le_var( const char *nome );
int escreve_var( const char *nome, int valor );
int encontra_var( const char *nome, int adicionar );

int yyerror( char *s )
{
	fprintf( stderr, "Erro bison: %s\n", s );
	return 1;
}
%}

%union	{
	int num;
	char nome_var[32+1];
	}


%type <num> expr
%token <num> NUMERO
%token <nome_var> VARIAVEL
%left OP_SOMA OP_SUB
%left OP_MULT OP_DIV
%left OP_SEN 
%left OP_COS 
%left OP_TAN
%left OP_SQRT
%right OP_POT
%right OP_IGUAL
%token LP
%token RP
%token EOL

%%

input:	/* vazio */
|	input linha
;

linha:	EOL			/* ignorar linhas vazias (e \n do par \r\n) */
|	expr EOL		{  }
;

expr:	NUMERO			{ $$ = $1; }
|	VARIAVEL			{ $$ = le_var($1);  }
|	expr OP_SOMA expr	{ $$ = $1 + $3; }
|	expr OP_SUB expr	{ $$ = $1 - $3; }
|	expr OP_MULT expr	{ $$ = $1 * $3; }
|	expr OP_DIV expr	{ $$ = $1 / $3; }
|	expr OP_POT expr	{ $$ = pow($1,$3); }
|	expr OP_SQRT		{ $$ = sqrt($1); }
|	LP expr RP			{ $$ = $2 }	
|	VARIAVEL OP_IGUAL expr	{ $$ = escreve_var($1, $3);  }
|	expr OP_SEN			{ $$ = sin($1); }
|	expr OP_COS			{ $$ = cos($1); }
|	expr OP_TAN			{ $$ = tan($1); }	
;

%%


int main( void )
{
	return yyparse();
}


int le_var( const char *nome )
{
	int i;

	i = encontra_var( nome, 0 );
	if( i < 0 )
		{
		fprintf( stderr, "Referencia a variavel inexistente: %s\n", nome );
		exit( 1 );
		}
	return vars[i].valor;
}


int escreve_var( const char *nome, int valor )
{
	int i;

	i = encontra_var( nome, 1 );
	if( i < 0 )
		{
		fprintf( stderr, "Nao foi possivel criar a variavel: %s\n", nome );
		exit( 1 );
		}
	vars[i].valor = valor;
	return valor;
}


int encontra_var( const char *nome, int adicionar )
{
	int i;

	for( i=0;  i < vars_preenchidas;  i++ )
		{
		if( strcmp(vars[i].nome, nome) == 0 )
			return i;
		}
	if( adicionar  &&  i < 100 )
		{
		strcpy( vars[i].nome, nome );
		vars_preenchidas++;
		return i;
		}
	return -1;
}
