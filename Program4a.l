%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int id=0, op = 0, keywords = 0;
%}
%%
("void"|"if"|"printf"|"while"|"int"|"float"|"char"|"short"|"long"|"for"|"switch"|"case") { keywords++;}
[a-zA-Z_][a-zA-Z0-9_]* {id++;}
("+"|"-"|"/"|"="|"*"|"<"|">"|"<="|">="|"!="|"==") {op++;}
.;
# {return 0;}
%%
int main()
{
	yyin = fopen("test_program_4a.txt","r");
	yylex();
	printf("The number of \nKeywords = %d\nOperators = %d\nIdentifiers = %d", keywords, op, id);
	return 0;
}
