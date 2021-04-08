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

#define TYPE_SPEC 62

#define NUM_ERR 71
#define UNKNOWN 72

%}

alpha [A-Za-z]
digit [0-9]
und [_]
space [ ]
tab [	]
line [\n]
char \'.\'
at [@]
string \"(.^([%d]|[%f]|[%s]|[%c]))\"

%%
{space}* {}
{tab}* {}
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
({digit}+)\.({digit}+) return CTC_REAL;

"%d"|"%f"|"%u"|"%s" return TYPE_SPEC;

{alpha}({alpha}|{digit}|{und})*\[{digit}*\] return ARRAY;
{alpha}({alpha}|{digit}|{und})*\(({alpha}|{digit}|{und}|{space})*\) return FUNCION;
({digit}+)\.({digit}+)\.({digit}|\.)* return NUM_ERR;
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
      if((scan>=1 && scan<=32) && mlc==0)
      {
        printf("%s\t\t\tKEYWORD\t\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==33 && mlc==0)
      {
        printf("%s\t\t\tIDENTIFICADOR\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==34)
      {
        printf("%s\t\t\tSingleline Comment\t\tLine %d\n", yytext, lineno);
        slcline = lineno;
      }
      if(scan==35 && mlc==0)
      {
        printf("%s\t\t\tMultiline Comment Start\t\tLine %d\n", yytext, lineno);
        mlcline = lineno;
        mlc = 1;
      }
      if(scan==36 && mlc==0)
      {
        printf("\n******** ERROR!! UNMATCHED MULTILINE COMMENT END %s at Line %d ********\n\n", yytext, lineno);
      }
      if(scan==36 && mlc==1)
      {
        mlc = 0;
        printf("%s\t\t\tMultiline Comment End\t\tLine %d\n", yytext, lineno);
      }
      if((scan>=37 && scan<=52) && mlc==0)
      {
        printf("%s\t\t\tOPERATOR\t\t\tLine %d\n", yytext, lineno);
      }
      if((scan==53||scan==54||scan==63||(scan>=64 && scan<=68)) && mlc==0)
      {
        printf("%s\t\t\tSPECIAL SYMBOL\t\t\tLine %d\n", yytext, lineno);
        if(scan==63)
        {
          dq++;
          dqline = lineno;
        }
      }
      if(scan==55 && mlc==0)
      {
        printf("%s\tHEADER\t\t\t\tLine %d\n",yytext, lineno);
      }
      if(scan==56 && mlc==0)
      {
        printf("%s\t\t\tMAIN FUNCTION\t\t\tLine %d\n", yytext, lineno);
      }
      if((scan==57 || scan==58) && mlc==0)
      {
        printf("%s\t\t\tPRE DEFINED FUNCTION\t\tLine %d\n", yytext, lineno);
      }
      if(scan==59 && mlc==0)
      {
        printf("%s\t\t\tPRE PROCESSOR DIRECTIVE\t\tLine %d\n", yytext, lineno);
      }
      if(scan==60 && mlc==0)
      {
        printf("%s\t\t\tINTEGER CONSTANT\t\tLine %d\n", yytext, lineno);
      }
      if(scan==61 && mlc==0)
      {
        printf("%s\t\t\tFLOATING POINT CONSTANT\t\tLine %d\n", yytext, lineno);
      }
      if(scan==62 && mlc==0)
      {
        printf("%s\t\t\tTYPE SPECIFIER\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==69 && mlc==0)
      {
        printf("%s\t\t\tARRAY\t\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==70 && mlc==0)
      {
        printf("%s\t\t\tUSER DEFINED FUNCTION\t\tLine %d\n", yytext, lineno);
      }
      if(scan==71 && mlc==0)
      {
        printf("\n******** ERROR!! CONSTANT ERROR %s at Line %d ********\n\n", yytext, lineno);
      }
      if(scan==72 && mlc==0)
      {
        printf("\n******** ERROR!! UNKNOWN TOKEN %s at Line %d ********\n\n", yytext, lineno);
      }
      if(scan==73 && mlc==0)
      {
        printf("%s\t\t\tCHARACTER CONSTANT\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==74 && mlc==0)
      {
        printf("%s\t\t\tSIGNED CONSTANT\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==75 && mlc==0)
      {
        printf("%s\t\t\tSTRING CONSTANT\t\t\tLine %d\n", yytext, lineno);
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