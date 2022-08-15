%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
int comment = 0, c=1, flag=0;
%}
%%
"//"[^\n]* {if(flag==0) comment++;}
"/*" {flag=1;}
"*/" {if(flag==1) 
	{comment++;
	 c=1;flag=0;} 
	 else 
	 {fprintf(yyout, "*/", yytext[0]);}}
. {if(flag==0) fprintf(yyout, "%c", yytext[0]);}
EOF return 0;
%%
int main()
{
	yyin = fopen("program_3_a_comment.txt", "r");
	yyout = fopen("program_3_a_copy.txt","w");
	yylex();
	printf("\nThe number of comments are %d", comment);
}
