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






#define SLC 34
#define MLCS 35
#define MLCE 36

#define LEQ 37
#define GEQ 38
#define EQEQ 39
#define NEQ 40
#define LOR 41
#define LAND 42
#define ASSIGN 43
#define PLUS 44
#define SUB 45
#define MULT 46
#define DIV 47
#define MOD 48
#define LESSER 49
#define GREATER 50
#define INCR 51
#define DECR 52

#define COMMA 53
#define SEMI 54

#define HEADER 55
#define MAIN 56

#define PRINTF 57
#define SCANF 58
#define DEFINE 59

#define INT_CONST 60
#define FLOAT_CONST 61

#define TYPE_SPEC 62

#define DQ 63

#define OBO 64
#define OBC 65
#define CBO 66
#define CBC 67
#define HASH 68

#define ARR 69
#define FUNC 70

#define NUM_ERR 71
#define UNKNOWN 72

#define CHAR_CONST 73
#define SIGNED_CONST 74
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
{line} {lineno++;}
auto return AUTO;





{alpha}({alpha}|{digit}|{und})* return IDENTIFICADOR;

[0-9]{digit}*(\.{digit}+)? return CTC_ENTERA;

"//" return SLC;
"/*" return MLCS;
"*/" return MLCE;

"<=" return LEQ;
">=" return GEQ;
"==" return EQEQ;
"!=" return NEQ;
"||" return LOR;
"&&" return LAND;
"=" return ASSIGN;
"+" return PLUS;
"-" return SUB;
"*" return MULT;
"/" return DIV;
"%" return MOD;
"<" return LESSER;
">" return GREATER;
"++" return INCR;
"--" return DECR;

"," return COMMA;
";" return SEMI;

"#include<stdio.h>" return HEADER;
"#include <stdio.h>" return HEADER;
"main()" return MAIN;

{digit}+ return INT_CONST;
({digit}+)\.({digit}+) return FLOAT_CONST;

"%d"|"%f"|"%u"|"%s" return TYPE_SPEC;
"\"" return DQ;
"(" return OBO;
")" return OBC;
"{" return CBO;
"}" return CBC;
"#" return HASH;

{alpha}({alpha}|{digit}|{und})*\[{digit}*\] return ARR;
{alpha}({alpha}|{digit}|{und})*\(({alpha}|{digit}|{und}|{space})*\) return FUNC;
({digit}+)\.({digit}+)\.({digit}|\.)* return NUM_ERR;
({digit}|{at})+({alpha}|{digit}|{und}|{at})* return UNKNOWN;
%%

struct node
{
	char token[100];
  char attr[100];
	struct node *next;
};

struct hash
{
	struct node *head;
	int count;
};

struct hash hashTable[1000];
int eleCount = 1000;

struct node * createNode(char *token, char *attr)
{
	struct node *newnode;
	newnode = (struct node *) malloc(sizeof(struct node));
	strcpy(newnode->token, token);
	strcpy(newnode->attr, attr);
	newnode->next = NULL;
	return newnode;
}

int hashIndex(char *token)
{
	int hi=0;
	int l,i;
	for(i=0;token[i]!='\0';i++)
	{
		hi = hi + (int)token[i];
	}
	hi = hi%eleCount;
	return hi;
}

void insertToHash(char *token, char *attr)
{
	int flag=0;
	int hi;
	hi = hashIndex(token);
	struct node *newnode = createNode(token, attr);
	/* head of list for the bucket with index "hashIndex" */
	if (hashTable[hi].head==NULL)
	{
		hashTable[hi].head = newnode;
    hashTable[hi].count = 1;
    return;
	}
	struct node *myNode;
  myNode = hashTable[hi].head;
	while (myNode != NULL)
    {
      if (strcmp(myNode->token, token)==0)
      {
        flag = 1;
        break;
      }
      myNode = myNode->next;
    }
	if(!flag)
	{
		//adding new node to the list
		newnode->next = (hashTable[hi].head);
		//update the head of the list and no of nodes in the current bucket
		hashTable[hi].head = newnode;
		hashTable[hi].count++;
	}
	return;
}

void display()
{
  struct node *myNode;
  int i,j, k=1;
  printf("-------------------------------------------------------------------");
  printf("\nSNo \t|\tToken \t\t|\tToken Type \t\n");
    printf("-------------------------------------------------------------------\n");
  for (i = 0; i < eleCount; i++)
  {
    if (hashTable[i].count == 0)
      continue;
    myNode = hashTable[i].head;
    if (!myNode)
      continue;
    while (myNode != NULL)
    {
      printf("%d\t\t", k++);
      printf("%s\t\t\t", myNode->token);
      printf("%s\t\n", myNode->attr);
      myNode = myNode->next;
    }
	}
   	return;
}

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
          printf("\n******** ERROR!! INCOMPLETE STRING at Line %d ********\n\n", dqline);
        dq=0;
      }
      if((scan>=1 && scan<=32) && mlc==0)
      {
        printf("%s\t\t\tKEYWORD\t\t\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "KEYWORD");
      }
      if(scan==33 && mlc==0)
      {
        printf("%s\t\t\tIDENTIFICADOR\t\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "IDENTIFICADOR");
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
        insertToHash(yytext, "OPERATOR");
      }
      if((scan==53||scan==54||scan==63||(scan>=64 && scan<=68)) && mlc==0)
      {
        printf("%s\t\t\tSPECIAL SYMBOL\t\t\tLine %d\n", yytext, lineno);
        if(scan==63)
        {
          dq++;
          dqline = lineno;
        }
        insertToHash(yytext, "SPECIAL SYMBOL");
      }
      if(scan==55 && mlc==0)
      {
        printf("%s\tHEADER\t\t\t\tLine %d\n",yytext, lineno);
      }
      if(scan==56 && mlc==0)
      {
        printf("%s\t\t\tMAIN FUNCTION\t\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "IDENTIFICADOR");
      }
      if((scan==57 || scan==58) && mlc==0)
      {
        printf("%s\t\t\tPRE DEFINED FUNCTION\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "PRE DEFINED FUNCTION");
      }
      if(scan==59 && mlc==0)
      {
        printf("%s\t\t\tPRE PROCESSOR DIRECTIVE\t\tLine %d\n", yytext, lineno);
      }
      if(scan==60 && mlc==0)
      {
        printf("%s\t\t\tINTEGER CONSTANT\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "INTEGER CONSTANT");
      }
      if(scan==61 && mlc==0)
      {
        printf("%s\t\t\tFLOATING POINT CONSTANT\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "FLOATING POINT CONSTANT");
      }
      if(scan==62 && mlc==0)
      {
        printf("%s\t\t\tTYPE SPECIFIER\t\t\tLine %d\n", yytext, lineno);
      }
      if(scan==69 && mlc==0)
      {
        printf("%s\t\t\tARRAY\t\t\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "ARRAY");
      }
      if(scan==70 && mlc==0)
      {
        printf("%s\t\t\tUSER DEFINED FUNCTION\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "USER DEFINED FUNCTION");
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
        insertToHash(yytext, "CHARACTER CONSTANT");
      }
      if(scan==74 && mlc==0)
      {
        printf("%s\t\t\tSIGNED CONSTANT\t\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "SIGNED CONSTANT");
      }
      if(scan==75 && mlc==0)
      {
        printf("%s\t\t\tSTRING CONSTANT\t\t\tLine %d\n", yytext, lineno);
        insertToHash(yytext, "STRING CONSTANT");
      }
      scan = yylex();
    }
    if(mlc==1)
      printf("\n******** ERROR!! UNMATCHED COMMENT STARTING at Line %d ********\n\n",mlcline);
    printf("\n");
    printf("\n\t******** SYMBOL TABLE ********\t\t\n");
    display();
    printf("-------------------------------------------------------------------\n\n");
    }
  }



}
int yywrap()
{
	return 1;
}