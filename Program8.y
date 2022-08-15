%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int ind = 0;
char temp = '@';
void Assembly();
char AddtoTable(char,char,char);
struct incod
{
	char opd1;
	char opd2;
	char op;
};
%}
%union
{
	char sym;
}
%token <sym> NUMBER LETTER
%type <sym> expr
%left '+' '-'
%left '*' '/'
%%
S:LETTER '=' expr ';' {AddtoTable((char) $1,(char) $3,'=');}
|expr ';'
;
expr:expr '+' expr { $$ = AddtoTable((char) $1, (char) $3, '+');}
|expr '-' expr { $$ = AddtoTable((char) $1, (char) $3, '-');}
|expr '*' expr { $$ = AddtoTable((char) $1, (char) $3, '*');}
|expr '/' expr { $$ = AddtoTable((char) $1, (char) $3, '/');}
|'(' expr ')' {$$ = (char) $2;}
|NUMBER {$$ = (char) $1;}
|LETTER {$$ = (char) $1;}
;
%%
int yyerror(char *msg)
{
	printf("%s", msg);
}
struct incod code[20];
int in;
char AddtoTable(char opd1, char opd2, char op)
{
	code[ind].opd1 = opd1;
	code[ind].opd2 = opd2;
	code[ind].op = op;
	ind++;
	temp++;
	return temp;
}
void Assembly()
{
	int cnt=0, temp;
	printf("\n\n Assembly\n");
	while(cnt<ind-1)
	{
		if(isupper(code[cnt].opd1))
		{
			printf("\nMOV R1,%c", code[cnt].opd1);
		}
		else
		{
			printf("\nLD R1,%c", code[cnt].opd1);
		}
		if(isupper(code[cnt].opd2))
		{
			printf("\nMOV R1,%c", code[cnt].opd2);
		}
		else
		{
			printf("\nLD R1,%c", code[cnt].opd2);
		}
		switch(code[cnt].op)
		{
			case '+': if(cnt==ind-2) { printf("\nADD R1,R2\nSTR %c,R1", code[cnt+1].opd1);}
			else { printf("\nADD R1,R2\nMOV %c,R1", temp);}
			break;
			case '-': if(cnt==ind-2) { printf("\nSUB R1,R2\nSTR %c,R1", code[cnt+1].opd1);}
			else { printf("\nSUB R1,R2\nMOV %c,R1", temp);}
			break;
			case '*': if(cnt==ind-2) { printf("\nMUL R1,R2\nSTR %c,R1", code[cnt+1].opd1);}
			else { printf("\nMUL R1,R2\nMOV %c,R1", temp);}
			break;
			case '/': if(cnt==ind-2) { printf("\nDIV R1,R2\nSTR %c,R1", code[cnt+1].opd1);}
			else { printf("\nDIV R1,R2\nMOV %c,R1", temp);}
			break;
		}
		temp++;
		cnt++;
	}
}
int main()
{
	printf("Enter the expression\n");
	yyparse();
	temp = 'A';
	Assembly();
	return 0;
}
int yywrap(){return 1;}
