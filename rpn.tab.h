typedef union	{
	int num;
	char nome_var[32+1];
	} YYSTYPE;
#define	NUMERO	258
#define	VARIAVEL	259
#define	OP_SOMA	260
#define	OP_SUB	261
#define	OP_MULT	262
#define	OP_DIV	263
#define	OP_SEN	264
#define	OP_COS	265
#define	OP_TAN	266
#define	OP_SQRT	267
#define	OP_POT	268
#define	OP_IGUAL	269
#define	LP	270
#define	RP	271
#define	PRINT	272


extern YYSTYPE yylval;
