%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
%}
%token TYPE RETURN NUM ID
%%
S:FUNC {printf("Valid Function"); exit(0);}
;
FUNC:TYPE '(' PARAM ')' '{' BODY '}'
|TYPE '(' ')' '{' BODY '}'
;
PARAM:TYPE ',' PARAM
|TYPE
;
BODY:PARAM ';' BODY
|E ';' BODY
|RETURN E ';'
|
;
E:ID '=' E
|E '+' E
|E '-' E
|E '*' E
|E '/' E
|NUM
|ID
; 
%%

int yyerror(char *msg)
{
	printf("Invalid");
	exit(0);
}
int main()
{
	printf("Enter the expression\n");
	yyparse();
	return 0;
}
