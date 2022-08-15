%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>

char AddtoTable(char,char,char);
void ThreeAddressCode();
void Quadruple();

int ind=0;
char temp = '@';
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
%left '-' '+'
%left '*' '/'
%%
S: LETTER '=' expr ';' {AddtoTable((char)$1,(char)$3,'=');}
| expr ';'
;
expr: expr '+' expr {$$ = AddtoTable((char)$1,(char)$3,'+');}
| expr '-' expr {$$ = AddtoTable((char)$1,(char)$3,'-');}
| expr '*' expr {$$ = AddtoTable((char)$1,(char)$3,'*');}
| expr '/' expr {$$ = AddtoTable((char)$1,(char)$3,'/');}
| '(' expr ')' {$$=(char)$2;}
| NUMBER {$$ = (char)$1;}
| LETTER{$$ = (char)$1;}
;
%%
int yyerror(char *msg)
{
	printf("%s", msg);
}
struct incod code[20];
int in=0;
char AddtoTable(char opd1,char opd2,char op)
{
	code[ind].opd1 = opd1;
	code[ind].opd2 = opd2;
	code[ind].op = op;
	temp++;
	ind++;
	return temp;
}
void ThreeAddressCode()
{	
	int cnt=0;
	temp++;
	printf("\t\tThree Address Code\n");
	while(cnt<ind)
	{
		printf("%c: =\t", temp);
		if(isalnum(code[cnt].opd1))
		{
			printf("%c\t", code[cnt].opd1);
		}
		else
		{
			printf("%c\t",temp);
		}
		printf("%c\t", code[cnt].op);
		if(isalnum(code[cnt].opd2))
		{
			printf("%c\t", code[cnt].opd2);
		}
		else
		{
			printf("%c\t",temp);
		}
		printf("\n");
	temp++;
	cnt++;
	}
}

void Quadruple()
{
	int cnt=0;
	temp++;
	printf("\t\tQuadruple\n");
	while(cnt<ind)
	{
		printf("%d\t",in);
		printf("%c\t",code[cnt].op);
		if(isalnum(code[cnt].opd1))
		{
			printf("%c\t", code[cnt].opd1);
		}
		else
		{
			printf("%c\t",temp);
		}
		if(isalnum(code[cnt].opd2))
		{
			printf("%c\t", code[cnt].opd2);
		}
		else
		{
			printf("%c\t",temp);
		}
	printf("%c\t", temp);
	printf("\n");
	cnt++;
	in++;
	temp++;
	}
}
int yywrap(void)
{
return 1;
}
int main()
{
	printf("Enter the expression\n");
	yyparse();
	temp='A';
	ThreeAddressCode();
	temp='A';
	Quadruple();
	return 0;
}
		
