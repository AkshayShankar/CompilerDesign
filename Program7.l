%{
#include "y.tab.h"
%}
%%
[\t \n]
("int"|"char"|"void"|"double"|"float")[ ][a-zA-Z_][a-zA-Z0-9_]* {return TYPE;}
"return" {return RETURN;}
[0-9]+ {return NUM;}
[a-zA-Z_][a-zA-Z0-9_]* {return ID;}
. {return yytext[0];}
%%

