%{
#include "y.tab.h"
extern int yylval;
%}
%%
[0-9]+ {yylval = atoi(yytext);
return NUM;}
"for" {return FOR;}
[a-zA-Z_][a-zA-Z0-9_]* {return Id;}
. {return yytext[0];}

%%
