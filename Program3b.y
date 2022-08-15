%{
#include <stdio.h>
#include <stdlib.h>
int count = 0;
%}
%token NUM FOR Id
%left '+' '-'
%left '*' '/'
%%
A : FOR H B {count++;}
;
H : '(' INI ';' COND ';' INC ')'
;
B : '{' S ';' A '}' 
| '{' S ';' '}' 
| '{' A '}'
| '{' '}'
;
INI : Id '=' NUM
|
;
COND : Id R
|
;
R : '<' NUM
| '<' '=' NUM
| '>' NUM
| '>' '=' NUM
;
INC : Id '+' '+'
| Id '-' '-'
|
;
S : Id '=' E
;
E : E '+' E
| E '-' E 
| E '*' E 
| E '/' E 
| '(' E ')' 
| NUM 
| Id
;
%%
int main(){
	printf("Enter the expression: ");
	yyparse();
	printf("Levels = %d\n", count);
	return 0;
}
void yyerror(void ){
	printf("\nInvalid\n");
	exit(0);
}
