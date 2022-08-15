%{
#include<stdio.h>
int ind=0;
char temp='@';

void Assembly();
char AddToTable(char,char,char);
struct incod{
char opd1;
char opd2;
char op;
};
%}
%union
{
	char sym;
}
%token <sym> LETTER NUMBER
%type <sym> expr
%left '+' '-'
%left '*' '/'
%%
S:LETTER '=' expr ';' {AddToTable((char)$1,(char)$3,'=');}
|expr ';'
;

expr:expr '+' expr {$$=AddToTable((char)$1,(char)$3,'+');}
|expr '-' expr {$$=AddToTable((char)$1,(char)$3,'-');}
|expr '*' expr {$$=AddToTable((char)$1,(char)$3,'*');}
|expr '/' expr {$$=AddToTable((char)$1,(char)$3,'/');}
|'(' expr ')' {$$=(char)$2;}
|NUMBER {$$=(char)$1;}
|LETTER {$$=(char)$1;}
;
%%
int yyerror(char *msg)
{
	printf("%s",msg);
}

struct incod code[20]; int id=0;

char AddToTable(char opd1,char opd2,char op)	
{
	code[ind].opd1=opd1;
	code[ind].opd2=opd2;
	code[ind].op=op;
	ind++;
	temp++;
	return temp;
}

void Assembly()
{
	int cnt=0;temp;
	printf("\n\n\t ASSEMBLY CODE \n\n");
	while(cnt<ind-1){
	if(isupper(code[cnt].opd1))
	printf("MOV R1, %c\n",code[cnt].opd1);
	else
	printf("LD R1, %c\n",code[cnt].opd1);

	if(isupper(code[cnt].opd2))
	printf("MOV R2, %c\n",code[cnt].opd2);
	else
	printf("LD R2, %c\n",code[cnt].opd2);

	switch(code[cnt].op)
	{
		case '+': if(cnt==ind-2){printf("ADD R1, R2\nSTR %c, R1\n",code[cnt+1].opd1);} 
		else printf("ADD R1, R2\n MOV %c, R1\n",temp);
		break;

		case '-':  if(cnt==ind-2){printf("SUB R1, R2\nSTR %c, R1\n",code[cnt+1].opd1);} 
		else printf("SUB R1, R2 \nMOV %c, R1\n",temp);
		break;

		case '*':  if(cnt==ind-2){printf("MUL R1, R2\nSTR %c, R1\n",code[cnt+1].opd1);} 
		else printf("MUL R1, R2 \nMOV %c, R1\n",temp);
		break;

		case '/':  if(cnt==ind-2){printf("DIV R1, R2\nSTR %c, R1\n",code[cnt+1].opd1);} else printf("DIV R1, R2\nMOV %c, R1\n",temp);
		break;
	 }
	cnt++;temp++;
	}
}

int main()
{
	printf("Enter the Expresssion :\n");
	yyparse();
	temp='A';
	Assembly();
	return 0;
}
yywrap()
{
	return 1;
}
