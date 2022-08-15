%{
#include<stdio.h>
#include<string.h>
int words=0, whitespace=0, ch=0, newline=0;
%}
%%
[ ] {whitespace++;}
[\t] {whitespace+=4;}
[\n] {newline++;}
[a-zA-Z]+ {words++;ch+=yyleng;}
.;
# return 0;
%%
int yywrap(){}
int main(){
printf("Enter input (enter # to exit)\n");
yylex();
printf("Whitespace: %d\nNewline: %d\nCharacters: %d\nWords: %d\n", whitespace, newline, ch, words);
return 0;
}
