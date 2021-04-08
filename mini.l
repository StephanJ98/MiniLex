%{
int lineno = 1;
#include<stdio.h>

#define ARRAY 260
#define CABECERA 261
#define CADA 262
#define CADENA 263
#define CARACTER 264
#define CONJUNTO 265
#define CONSTANTES 266
#define CONTINUAR 267
#define CTC_CADENA 268
#define CTC_CARACTER 269
#define CTC_ENTERA 270
#define CTC_REAL 271
#define DE 272
#define DEFECTO 273
#define DEVOLVER 275
#define EJECUTA 276
#define ENCAMBIO 277
#define ENTERO 278
#define ES 280
#define ESCAPE 281
#define ESTRUCTURA 282
#define ETIQUETA 283
#define EXCEPCION 284
#define FICHERO 289
#define FIN 290
#define FUNCION 291
#define HACER 292
#define HASH 293
#define IDENTIFICADOR 295
#define LANZA 297
#define MIENTRAS 299
#define NADA 302
#define OTRA 305
#define PARA 307
#define PRINCIPIO 309
#define PROGRAMA 310
#define REAL 312
#define REF 313
#define RUTA 315
#define SALTAR 316
#define SI 317
#define SINO 318
#define TAMANO 320
#define TIPOS 321
#define UNION 322
#define VARIABLES 323

#define POTENCIA 311
#define SUMA_ASIG 319
#define RESTA_ASIG 314
#define MULT_ASIG 301
#define DIV_ASIG 274
#define MOD_ASIG 300
#define FD_ASIG 285
#define FI_ASIG 286
#define FLECHA_DCHA 287
#define FLECHA_IZDA 288
#define AND_ASIG 259
#define XOR_ASIG 324
#define OR_ASIG 306
#define POT_ASIG 308
#define GE 294
#define LE 298
#define EQ 279
#define NEQ 303
#define AND 258
#define OR 304
#define INDIRECCION 296

#define DELIMITADOR 324
#define COM_S 325
#define COM_MI 326
#define COM_MF 327
#define FUNC 328

#define UNKNOWN 72

%}

alpha [A-Za-z]
digit [0-9]
und [_]
space [ ]
line [\n]
char \'.\'
at [@]
string \'(.^([%d]|[%f]|[%s]|[%c]))\'

%%
{space}* {}
{string} return CTC_CADENA;
{char} return CTC_CARACTER;
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

"{" return DELIMITADOR;
"}" return DELIMITADOR;
"(" return DELIMITADOR;
")" return DELIMITADOR;
":" return DELIMITADOR;
";" return DELIMITADOR;
"," return DELIMITADOR;

"##" return COM_S;
"#-" return COM_MI;
"-#" return COM_MF;


"+" return yytext[0];
"-" return yytext[0];
"*" return yytext[0];
"/" return yytext[0];
"%" return yytext[0];
"=" return yytext[0];
"@" return yytext[0];
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
"<-" return FLECHA_IZDA;
"->" return FLECHA_DCHA;
"^." return INDIRECCION;

{digit}+ return CTC_ENTERA;
\#({digit}+) return CTC_ENTERA;
\#([abcdefABCDEF])+({digit}+) return CTC_ENTERA;
({digit}+)\.({digit}+) return CTC_REAL;
\.({digit}+) return CTC_REAL;
\.\#({digit}+) return CTC_REAL;
\.\#([abcdefABCDEF])+({digit}+) return CTC_REAL;

{alpha}({alpha}|{digit}|{und})*\[{digit}*\] return ARRAY;
{alpha}({alpha}|{digit}|{und})*\(({alpha}|{digit}|{und}|{space})*\) return FUNC;
({digit}|{at})+({alpha}|{digit}|{und}|{at})* return UNKNOWN;
%%

int main(int argc, char *argv[]) {
{

  if (argc < 2) {
    printf("Uso: ./mini NombreArchivo\n");
    }
  else {
    int scan, slcline=0, mlc=0, mlcline=0, dq=0, dqline=0;
    yyin = fopen(argv[1],"r");
    printf("\n\n");
    scan = yylex();
    while(scan)
    {
      if(lineno == slcline)
      {
        scan = yylex();
        continue;
      }
      if(lineno!=dqline && dqline!=0)
      {
        if(dq%2!=0)
          printf("\n******** ERROR!! Cadena Incompleta en la Linea %d ********\n\n", dqline);
        dq=0;
      }

      if((scan>=260 && scan<=267) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }

      if(scan==268 && mlc==0)
      {
        printf("Linea %d, CTC_Cadena: %s\n", lineno, yytext);
      }
      if(scan==269 && mlc==0)
      {
        printf("Linea %d, CTC_Caracter: %s\n", lineno, yytext);
      }
      if(scan==270 && mlc==0)
      {
        printf("Linea %d, CTC_Entera: %s\n", lineno, yytext);
      }
      if(scan==271 && mlc==0)
      {
        printf("Linea %d, CTC_Real: %s\n", lineno, yytext);
      }

      if((scan>=272 && scan<=273) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=275 && scan<=279) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=280 && scan<=284) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=289 && scan<=293 || scan==295 || scan==297 || scan==299 || scan==302 || scan==305 || scan==307) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=309 && scan<=310) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=312 && scan<=313) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=315 && scan<=318) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if((scan>=320 && scan<=323) && mlc==0)
      {
        printf("Linea %d, Palabra Reservada: %s\n", lineno, yytext);
      }
      if(scan==328 && mlc==0)
      {
        printf("Linea %d, Funcion definida por el usuario %s\n", lineno, yytext);
      }








      if(scan==33 && mlc==0)
      {
        printf("%s\t\t\tIDENTIFICADOR\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==325)
      {
        printf("Linea %d, Comentario Simple %s\n", lineno, yytext);
        slcline = lineno;
      }
      if(scan==326 && mlc==0)
      {
        printf("Linea %d, Inicio Comentario Multilinea %s\n", lineno, yytext);
        mlcline = lineno;
        mlc = 1;
      }
      if(scan==327 && mlc==0)
      {
        printf("Linea %d, ERROR: Fin de Comentario Multilinea sin inicio. %s\n", lineno, yytext);
      }
      if(scan==327 && mlc==1)
      {
        mlc = 0;
        printf("Linea %d, Fin Comentario Multilinea %s\n", lineno, yytext);
      }
      if(scan==72 && mlc==0)
      {
        printf("\n******** ERROR!! UNKNOWN TOKEN %s at Line %d ********\n\n", yytext, lineno);
      }
      scan = yylex();
    }
    if(mlc==1)
      printf("\n******** ERROR!! UNMATCHED COMMENT STARTING at Line %d ********\n\n",mlcline);
    printf("\n");
    }
  }

}
int yywrap()
{
	return 1;
}