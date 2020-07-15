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
    float valor;
  } atributos;
  struct var2{
    char* tipo;
    float valor;
    char* nombre;
  } variable;
  struct var3{
    char* tipo;
    int valor;
  } atributos2;
  struct var4{
    char* tipo;
    int valor;
    char* nombre;
  } variable2;
  char* name;
}

%token <name> ID
%token FINLINEA
%token <atributos> FLOAT
%token <atributos2> ENTERO
%token PAR_DER PAR_IZQ
%token IGUAL

%left SUMA RESTA
%left MULT DIV

%type <atributos> e
%type <variable> v
%type <atributos2> e2
%type <variable2> v2
%type <name> i

%%
s: e  FINLINEA {printf("= %f y es de tipo %s", $1.valor, $1.tipo);
               }
 | v  FINLINEA {printf("La variable %s vale %f y es de tipo ... %s",$1.nombre,$1.valor, $1.tipo);
               }
 | e2 FINLINEA {printf("= %d y es de tipo %s", $1.valor, $1.tipo);
               }
 | v2 FINLINEA {printf("La variable %s vale %d y es de tipo ... %s",$1.nombre,$1.valor, $1.tipo);
               }
;

v: i IGUAL e  {
                $$.tipo= $3.tipo;
                $$.valor = $3.valor;
                $$.nombre = $1;
              }
;
v2: i IGUAL e2  {
                  $$.tipo= $3.tipo;
                  $$.valor = $3.valor;
                  $$.nombre = $1;
                }
;
e: e SUMA e     {  $$.valor = $1.valor + $3.valor;
                   $$.tipo= $1.tipo; 
                }
 | e RESTA e    {  $$.valor = $1.valor - $3.valor;
                   $$.tipo= $1.tipo; 
                }
 | e SUMA e2    {  $$.valor = $1.valor + $3.valor;
                   $$.tipo= $1.tipo; 
                }  
 | e2 SUMA e    {  $$.valor = $1.valor + $3.valor;
                   $$.tipo= $3.tipo; 
                }                   
 | e RESTA e2    {  $$.valor = $1.valor - $3.valor;
                    $$.tipo= $1.tipo; 
                 }  
 | e2 RESTA e    {  $$.valor = $1.valor - $3.valor;
                    $$.tipo= $3.tipo; 
                 }                                                                                  
 | FLOAT        {  $$.valor = $1.valor;
                   $$.tipo = $1.tipo;
                }             
             
 ;
e2: e2 SUMA e2  {  $$.valor = $1.valor + $3.valor;
                   $$.tipo= $1.tipo; 
                }
  | e2 RESTA e2 {  $$.valor = $1.valor - $3.valor;
                   $$.tipo= $1.tipo; 
                }
  | ENTERO      {  $$.valor = $1.valor;
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
