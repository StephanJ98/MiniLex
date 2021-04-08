mini:	mini.lex.c
	gcc -o mini lex.yy.c
mini.lex.c:	mini.l
	flex mini.l
clean:
	rm lex.yy.c mini
