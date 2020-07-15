%{
  #include <stdio.h>
  #include <string.h>
  #include <stdlib.h>
  #define YYDEBUG 1
  extern int yylex(void);
  extern char *yytext;
  void yyerror (char*);
%}

%union{
  struct var{
    char* tipo;
    int valor;
  } atributos;
  struct var2{
    char* tipo;
    int valor;
    char* nombre;
  } variable;
  char* name;
}

%token <name> ID
%token FINLINEA
%token <atributos> ENTERO
%token PAR_DER PAR_IZQ
%token IGUAL

%left SUMA RESTA
%left MULT DIV

%type <atributos> e
%type <variable> v
%type <name> i

%%
s: e FINLINEA {printf("= %d y es de tipo %s", $1.valor, $1.tipo);
              }
 | v FINLINEA {printf("La variable %s vale %d y es de tipo ... %s",$1.nombre,$1.valor, $1.tipo);
              }
;

v: i IGUAL e  {
                $$.tipo= $3.tipo;
                $$.valor = $3.valor;
                $$.nombre = $1;
              }
;
e: e SUMA e  {  $$.valor = $1.valor + $3.valor;
                $$.tipo= $1.tipo; 
             }
 | e RESTA e {  $$.valor = $1.valor - $3.valor;
                $$.tipo= $1.tipo; 
             }
 | e MULT e  {  $$.valor = $1.valor * $3.valor;
                $$.tipo= $1.tipo; 
             }
 | e DIV e   {
                if($3.valor == 0){
                  yyerror("No existe division entre 0");
                  exit(0);
                }
                else{
                  $$.valor = $1.valor / $3.valor;
                  $$.tipo= $1.tipo; 
                }  
             }                                           
 | ENTERO    {  $$.valor = $1.valor;
                $$.tipo = $1.tipo;
             } 
 ;
i: ID        {$$ = $1;}
 ; 
%%
void yyerror(char *s){
  printf("Error sintactico %s",s);
}

int main(int argc,char **argv){
  yydebug = 0;
  yyparse();
  return 0;
}
