mini:	mini.lex.c
	gcc -o mini lex.yy.c
	chmod u+x mini
mini.lex.c:	mini.l
	flex mini.l
clean:
	rm lex.yy.c mini
