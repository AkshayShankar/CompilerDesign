%{
#include <stdio.h>
#include <stdlib.h>
%}
%token X
%token Y
%token Z
%%
S:A B
;
A:X A Y
|
;
B:Y B Z
|
;
%%
int main(){
	printf("Enter the input: ");
	yyparse();
	printf("\nValid\n");
	return 0;
}
void yyerror(void){
	printf("\nInvalid\n");
	exit(0);
}
