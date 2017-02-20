%%
//pruebaaddandcommit2
%standalone
%class practicaobligatoria
%line
%column

%init{

%init}

%{

%}

%eof{

%eof}

//Macros

id=[a-zA-Z_$][a-zA-Z_$0-9]*
s= + | -
hexadecimalEntero= "0x"s?[0-9A-F]+
decimalEntero= s?[0-9]+
octalEntero= "0"s?[0-7]+
hexadecimalReal= "0x"s?[0-9A-F]+"."[0-9A-F]+
decimalReal= s?[0-9]+"."[0-9]+
octalReal= "0"s?[0-7]+"."+[0-7]+
comentarioUnaLinea="//".*
contenidoComentario= [^*] | "*"[^/]
constanteLiteral = "'"{contenidoConstanteLiteral}"'"
contenidoConstanteLiteral = [^']* |  [^']*"\'"[^']*

%%

//Reglas lexicas



//Identificadores
{id} {System.out.println("<ident,"+yytext()+">");}


//Constantes numericas

{hexadecimalEntero}	{System.out.println("<constint,"+yytext()+">");}
{decimalEntero}	{System.out.println("<constint,"+yytext()+">");}
{octalEntero}	{System.out.println("<constint,"+yytext()+">");}

{hexadecimalReal}	{System.out.println("<constfloat,"+yytext()+">");}
{decimalReal}	{System.out.println("<constfloat,"+yytext()+">");}
{octalReal}	{System.out.println("<constfloat,"+yytext()+">");}


//Constantes literales
{constanteLiteral}	{System.out.println("<constlit,"+yytext()+">");}


//Comentarios de proposito general
{comentarioUnaLinea}	{System.out.println("<comentario,"yytext()+">");}

"/*"{contenidoComentario}+"*/"  {System.out.println("<comentario,"yytext()+">");}
