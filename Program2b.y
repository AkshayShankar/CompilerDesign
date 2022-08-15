%{
#include <stdio.h>
#include <stdlib.h>
%}
%token NUM
%left '+' '-'
%left '*' '/'
%%
S : E {printf("Result = %d\n", $$);}
;
E : E '+' E {$$ = $1 + $3;}
| E '-' E {$$ = $1 - $3;}
| E '*' E {$$ = $1 * $3;}
| E '/' E {	if($3==0) {printf("Divide by zero error\n");
						return 0;}
		$$ = $1 / $3;}
| '(' E ')' {$$ = $2;}
| NUM
;
%%
int main(){
	printf("Enter the expression: ");
	yyparse();
	return 0;
}
void yyerror(void ){
	printf("\nInvalid\n");
	exit(0);
}
