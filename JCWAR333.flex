
%%

%standalone
%class Lexico

Letra = [a-zA-Z]
Digito = [0-9]
Identificador = ({Letra}|"$")( {Letra}|{Digito}|"$"|"_" )*
Decimal = [1-9]({Digito})*
Octal = ([0-7])*
Hexa = ([0-9A-F])*
Constint = ( ("+"|"-")?{Decimal} | "0"("+"|"-")?{Octal} | "0x"("+"|"-")?{Hexa} )
RealDecimal = ("+"|"-")?("0."{Digito}+|{Decimal}"."{Digito}+)
RealOctal = ("0"("+"|"-")?{Octal}"."{Octal})
RealHexa = "0x"("+"|"-")?({Hexa}"."{Hexa})
Constfloat = ({RealDecimal}|{RealOctal}|{RealHexa})
Constlit = "'"([^"'"]|"\'")*"'"
ComentarioLinea = "//"(.)*
ComentarioLargo = "/*"~"*/"
Comentario = {ComentarioLinea}|{ComentarioLargo}

%{
/*
*/
%}

%%


","	{System.out.println("<Coma,"+yytext()+">");}
";"	{System.out.println("<Punto_Coma,"+yytext()+">");}
"="	{System.out.println("<Asignacion,"+yytext()+">");}
"("	{System.out.println("<Parentesis_A,"+yytext()+">");}
")"	{System.out.println("<Parentesis_C,"+yytext()+">");}
"{"	{System.out.println("<Llave_A,"+yytext()+">");}
"}"	{System.out.println("<Llave_C,"+yytext()+">");}


"*"	{System.out.println("<Producto,"+yytext()+">");}
"/"	{System.out.println("<Division,"+yytext()+">");}
"%"	{System.out.println("<Modulo,"+yytext()+">");}
"=="	{System.out.println("<Igualdad,"+yytext()+">");}
"<"	{System.out.println("<Menor,"+yytext()+">");}
">"	{System.out.println("<Mayor,"+yytext()+">");}
">="	{System.out.println("<Mayor_Igual,"+yytext()+">");}
"<="	{System.out.println("<Menor_Igual,"+yytext()+">");}

"struct"	{System.out.println("<STRUCT,"+yytext()+">");}
"if"	{System.out.println("<IF,"+yytext()+">");}
"then"	{System.out.println("<THEN,"+yytext()+">");}
"else"	{System.out.println("<ELSE,"+yytext()+">");}
"for"	{System.out.println("<FOR,"+yytext()+">");}
"while"	{System.out.println("<WHILE,"+yytext()+">");}
"do"	{System.out.println("<DO,"+yytext()+">");}
"until"	{System.out.println("<UNTIL,"+yytext()+">");}
"not"	{{System.out.println("<NOT,"+yytext()+">");}}
"or"	{System.out.println("<OR,"+yytext()+">");}
"and"	{System.out.println("<AND,"+yytext()+">");}
"return"	{System.out.println("<RETURN,"+yytext()+">");}
"void"	{System.out.println("<VOID,"+yytext()+">");}
"int"	{System.out.println("<INT,"+yytext()+">");}
"float"	{System.out.println("<FLOAT,"+yytext()+">");}

{Identificador}	{System.out.println("<Ident,"+yytext()+">");}
{Constint}	{System.out.println("<Constint,"+yytext()+">");}
{Constfloat}	{System.out.println("<Constfloat,"+yytext()+">");}
{Constlit}	{System.out.println("<Constlit,"+yytext()+">");}
{Comentario}	{System.out.println("<Comentario,"+yytext()+">");}

"+"	{System.out.println("<Suma,"+yytext()+">");}
"-"	{System.out.println("<Resta,"+yytext()+">");}
"."	{System.out.println("<Punto,"+yytext()+">");}
