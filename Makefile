#
# Makefile para Windows com GCC
#
# Para converter para Linux/outro compilador:
#	Alterar a regra "clean" para usar o comando "rm"
#	Alterar a regra "rpn" para chamar outro compilador
#

# A primeira regra e' a "default", e logo a que devemos
# ter para criar o nosso executavel final;
# A opcao "-Wall" ao gcc, aumenta a quantidade de avisos que ele nos da'
#
rpn : rpn.tab.c rpn.tab.h lex.yy.c Makefile
	gcc rpn.tab.c lex.yy.c -Wall -o rpn


# Regra bison;
# A opcao "-d" ao bison, cria o "rpn.tab.h" para interaccao com o "rpn.l";
# A opcao "-o" ao bison, gera o ficheiro com o nome "rpn.tab.c" (e "rpn.tab.h");
#	Este e' o nome padrao em Unix, mas em Windows e' usado
#	rpn_tab.c e rpn_tab.h. Usamos esta opcao para este ficheiro
#	funcionar igual em ambos os sistemas operativos
#
rpn.tab.c rpn.tab.h : rpn.y Makefile
	bison -d rpn.y -o rpn.tab.c


# Regra flex
#
lex.yy.c : rpn.l rpn.tab.h Makefile
	flex rpn.l


# Regra para apagar os ficheiros nao necessarios
# (corre-se com o comando "make clean")
#
clean:
	del rpn.tab.c rpn.tab.h rpn.output lex.yy.c rpn.exe rpn
