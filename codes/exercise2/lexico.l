%{
#include"sintactico.tab.h"
/*
externt yylval
*/
%}
digito [0-9]
numero {digito}+(\.{digito}+)?
id [a-zA-Z]+
%%
{numero}            {yylval.atributos.valor = atof(yytext);
                    yylval.atributos.tipo = "flotante";   
                    return FLOAT;
                    }
{id}                {yylval.name = yytext; 
                    return ID;
                    }
"\n"                {return FINLINEA;}
"("                 {return PAR_IZQ;}
")"                 {return PAR_DER;}
"+"                 {return SUMA;}
"-"                 {return RESTA;}
"*"                 {return MULT;}
"/"                 {return DIV;}
"="                 {return IGUAL;}
" "                 ;
%%
int yywrap(){ return 0;}
