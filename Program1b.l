%{
#include "y.tab.h"
%}
%%
[a] {return X;}
[b] {return Y;}
[c] {return Z;}
. {return yytext[0];}
\n return 0;
%%
