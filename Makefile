mini:	mini.lex.c
	gcc -o mini lex.yy.c
	chmod u+x mini
mini.lex.c:	mini.l
	flex mini.l
clean:
	rm lex.yy.c mini
	clear
do:
	make mini.lex.c
	make mini
	./mini prueba.mi