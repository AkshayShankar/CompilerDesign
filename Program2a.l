%{
#include<stdio.h>
#include<string.h>  
#include<stdlib.h>
int posnum=0, negnum=0, posfrac=0, negfrac=0;
%}
%%
[+]?[0-9]+ {posnum++;}
[-][0-9]+ {negnum++;}
[+]?[0-9]*[.][0-9]+ {posfrac++;}                            // only decimal
[-][0-9]*[.][0-9]+ {negfrac++;}                             // only decimal
[+]?[0-9]*[.]?[0-9]+[/][+]?[0-9]*[.]?[0-9]+ {posfrac++;}    // frac +,+
[-][0-9]*[.]?[0-9]+[/][-][0-9]*[.]?[0-9]+ {posfrac++;}      // frac -,-
[-][0-9]*[.]?[0-9]+[/][+]?[0-9]*[.]?[0-9]+ {negfrac++;}     // frac -,+
[+]?[0-9]*[.]?[0-9]+[/][-][0-9]+[.]?[0-9]+ {negfrac++;}     // frac +,-
.;
# return 0;
%%
int yywrap(){
return 1;}
int main(){
printf("Enter input (enter # to exit)\n");
yylex();
printf("Positive num: %d\nNegative num: %d\nPositive fractions: %d\nNegative fractions: %d\n", posnum, negnum, posfrac, negfrac);
return 0;
}
