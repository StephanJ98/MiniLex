%{
int lineno = 1;
#include <stdio.h>
#include "tokens.h"

#define DELIMITADOR 325
#define COM_S 326
#define COM_MI 327
#define COM_MF 328
#define FUNC 329
#define OPERADOR 330

#define UNKNOWN 72
#define UNKNOWN_CHAR 73

%}

alpha [A-Za-z]
digit [0-9]
und [_]
space [ ]
line [\n]
at [@]

%%
{space}* {}
\'(.)\' return CTC_CARACTER;
\'\#.\' return CTC_CARACTER;
\'([a-zA-Z0-9\#]){2,}\' return CTC_CADENA;
\'\' return CTC_CADENA;
\#$ return CTC_CADENA;

{line} {lineno++;};

array return ARRAY;
cabecera return CABECERA;
cada return CADA;
cadena return CADENA;
caracter return CARACTER;
conjunto return CONJUNTO;
constantes return CONSTANTES;
continuar return CONTINUAR;
de return DE;
defecto return DEFECTO;
devolver return DEVOLVER;
ejecuta return EJECUTA;
encambio return ENCAMBIO;
entero return ENTERO;
es return ES;
escape return ESCAPE;
estructura return ESTRUCTURA;
etiueta return ETIQUETA;
excepcion return EXCEPCION;
fichero return FICHERO;
fin return FIN;
funcion return FUNCION;
hacer return HACER;
hash return HASH;
identificador return IDENTIFICADOR;
lanza return LANZA;
mientras return MIENTRAS;
nada return NADA;
otra return OTRA;
para return PARA;
principio return PRINCIPIO;
programa return PROGRAMA;
real return REAL;
ref return REF;
ruta return RUTA;
saltar return SALTAR;
si return SI;
sino return SINO;
tamano return TAMANO;
tipos return TIPOS;
union return UNION;
variables return VARIABLES;

{alpha}({alpha}|{digit}|{und})* return IDENTIFICADOR;

"\{" return DELIMITADOR;
"\}" return DELIMITADOR;
"\[" return DELIMITADOR;
"\]" return DELIMITADOR;
"\(" return DELIMITADOR;
"\)" return DELIMITADOR;
"\:" return DELIMITADOR;
"\;" return DELIMITADOR;
"\," return DELIMITADOR;

"##" return COM_S;
"#-" return COM_MI;
"-#" return COM_MF;

"+" return OPERADOR;
"-" return OPERADOR;
"*" return OPERADOR;
"/" return OPERADOR;
"%" return OPERADOR;
"=" return OPERADOR;
"@" return OPERADOR;
"<" return OPERADOR;
">" return OPERADOR;
"\\" return OPERADOR;
"~" return OPERADOR;
"!" return OPERADOR;

"**" return POTENCIA;
"=+" return SUMA_ASIG;
"=-" return RESTA_ASIG;
"=*" return MULT_ASIG;
"=/" return DIV_ASIG;
"=%" return MOD_ASIG;
"=<-" return FI_ASIG;
"=->" return FD_ASIG;
"=&" return AND_ASIG;
"=@" return XOR_ASIG;
"=|" return OR_ASIG;
"=**" return POT_ASIG;
"=>" return GE;
"=<" return LE;
"==" return EQ;
"!=" return NEQ;
"&&" return AND;
"||" return OR;
"&" return AND;
"|" return OR;
"<-" return FLECHA_IZDA;
"->" return FLECHA_DCHA;
"^." return INDIRECCION;

{digit}+ return CTC_ENTERA;
\#({digit}+) return CTC_ENTERA;
\#([abcdefABCDEF])+({digit}+) return CTC_ENTERA;
\#([hH])({digit}+) return CTC_ENTERA;
\#([hH])([abcdefABCDEF]+) return CTC_ENTERA;

\.({digit}+) return CTC_REAL;
\.\#({digit}+) return CTC_REAL;
\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;
\.\#([hH])({digit}+) return CTC_REAL;
\.\#([hH])([abcdefABCDEF]+) return CTC_REAL;

({digit}+)\.({digit}+) return CTC_REAL;
({digit}+)\.\#({digit}+) return CTC_REAL;
({digit}+)\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;
({digit}+)\.\#([hH])({digit}+) return CTC_REAL;
({digit}+)\.\#([hH])([abcdefABCDEF]+) return CTC_REAL;

\#({digit}+)\.({digit}+) return CTC_REAL;
\#({digit}+)\.\#({digit}+) return CTC_REAL;
\#({digit}+)\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;
\#({digit}+)\.\#([hH])({digit}+) return CTC_REAL;
\#({digit}+)\.\#([hH])([abcdefABCDEF]+) return CTC_REAL;

\#([abcdefABCDEF])+({digit}+)\.({digit}+) return CTC_REAL;
\#([abcdefABCDEF])+({digit}+)\.\#({digit}+) return CTC_REAL;
\#([abcdefABCDEF])+({digit}+)\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;
\#([abcdefABCDEF])+({digit}+)\.\#([hH])({digit}+) return CTC_REAL;
\#([abcdefABCDEF])+({digit}+)\.\#([hH])([abcdefABCDEF]+) return CTC_REAL;

\#([hH])({digit}+)\.({digit}+) return CTC_REAL;
\#([hH])({digit}+)\.\#({digit}+) return CTC_REAL;
\#([hH])({digit}+)\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;
\#([hH])({digit}+)\.\#([hH])({digit}+) return CTC_REAL;
\#([hH])({digit}+)\.\#([hH])([abcdefABCDEF]+) return CTC_REAL;

\#([hH])([abcdefABCDEF]+)\.({digit}+) return CTC_REAL;
\#([hH])([abcdefABCDEF]+)\.\#({digit}+) return CTC_REAL;
\#([hH])([abcdefABCDEF]+)\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;
\#([hH])([abcdefABCDEF]+)\.\#([hH])({digit}+) return CTC_REAL;
\#([hH])([abcdefABCDEF]+)\.\#([hH])([abcdefABCDEF]+) return CTC_REAL;

\|(.)+\| return RUTA;
{alpha}({alpha}|{digit}|{und})*\[{digit}*\] return ARRAY;
{alpha}({alpha}|{digit}|{und})*\(({alpha}|{digit}|{und}|{space})*\) return FUNC;
([a-zA-z0-9])+\' return UNKNOWN;
\'([a-zA-z0-9])+ return UNKNOWN;
([áéíóúàèìòùAâêîôûäëïöüç]) return UNKNOWN_CHAR;
%%

int main(int argc, char *argv[]) {
{
  if (argc < 2) {
    printf("Uso: ./mini NombreArchivo\n");
    }
  else {
    int scan, slcline=0, mlc=0, mlcline=0;
    yyin = fopen(argv[1],"r");
    printf("\n\n");
    scan = yylex();
    while(scan)
    {
      if(lineno == slcline){
        scan = yylex();
        continue;
      }

      if(scan==268 && mlc==0){
        printf("Linea %d, CTC_Cadena: %s\n", lineno, yytext);
      }
      if(scan==269 && mlc==0){
        printf("Linea %d, CTC_Caracter: %s\n", lineno, yytext);
      }
      if(scan==270 && mlc==0){
        printf("Linea %d, CTC_Entera: %s\n", lineno, yytext);
      }
      if(scan==271 && mlc==0){
        printf("Linea %d, CTC_Real: %s\n", lineno, yytext);
      }

      if(((scan>=260 && scan<=267) || (scan>=275 && scan<=279) || (scan>=280 && scan<=284) || (scan>=289 && scan<=293) || scan==272 || scan==273 || scan==297 || scan==299 || scan==302 || scan==305 || scan==307 || scan==309 || scan==310 || scan==312 || scan==313 || scan==316 || scan==317 || scan==318 || scan==320 || scan==321 || scan==322 || scan==323 ) && mlc==0){
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }

      if(scan==329 && mlc==0){
        printf("Linea %d, Funcion definida por el usuario: %s\n", lineno, yytext);
      }
      if(scan==315 && mlc==0){
        printf("Linea %d, Ruta: %s\n", lineno, yytext);
      }
      if(scan==330 && mlc==0){
        printf("Linea %d, Operador: %s\n", lineno, yytext);
      }
      if(scan==325 && mlc==0){
        printf("Linea %d, Delimitador: %s\n", lineno, yytext);
      }
      if(scan==295 && mlc==0){
        printf("Linea %d, Identificador: %s\n", lineno, yytext);
      }

      if(scan==326){
        printf("Linea %d, Comentario Simple: %s\n", lineno, yytext);
        slcline = lineno;
      }
      if(scan==327 && mlc==0){
        printf("Linea %d, Inicio Comentario Multilinea: %s\n", lineno, yytext);
        mlcline = lineno;
        mlc = 1;
      }
      if(scan==328 && mlc==0){
        printf("Linea %d, ERROR: Fin de Comentario Multilinea sin inicio. %s\n", lineno, yytext);
      }
      if(scan==328 && mlc==1){
        mlc = 0;
        printf("Linea %d, Fin Comentario Multilinea: %s\n", lineno, yytext);
      }

      if(scan==72 && mlc==0){
        printf("ERROR: Linea %d, Cadena incorrecta: %s\n", lineno, yytext);
      }
      if(scan==73 && mlc==0){
        printf("ERROR: Linea %d, Caracter incorrecta: %s\n", lineno, yytext);
      }
      scan = yylex();
    }
    if(mlc==1)
      printf("Linea %d, ERROR: Inicio de Comentario Multilinea sin cierre. %s\n", lineno, yytext);
    printf("\n");
    }
  }

}
int yywrap(){
	return 1;
}