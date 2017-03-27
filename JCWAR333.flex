
%%
%standalone
%class Fallo

%line
%column

Letra = [a-zA-Z]
Digito = [0-9]
Identificador = ({Letra}|"$")( {Letra}|{Digito}|"$"|"_" )*
Decimal = [1-9]({Digito})*
Octal = ([0-7])*

Hexa = ([0-9A-F])*
HexaError = ([0-9a-zG-Z])*
Constint = ( ("+"|"-")?{Decimal} | "0"("+"|"-")?{Octal} | "0x"("+"|"-")?{Hexa} )
RealDecimal = ("+"|"-")?("0."{Digito}+|{Decimal}"."{Digito}+)
RealOctal = ("0"("+"|"-")?{Octal}"."{Octal})
RealOctalError = ("0"("+"|"-")?({Octal}"."{Digito}*|{Digito}*"."{Octal}|{Digito}*"."{Digito}*))
RealHexa = "0x"("+"|"-")?({Hexa}"."{Hexa})
RealHexaError = "0x"("+"|"-")?({Hexa}"."{HexaError}|{HexaError}"."{Hexa}|{HexaError}"."{HexaError})
Constfloat = ({RealDecimal}|{RealOctal}|{RealHexa})
Constlit = "'"([^\n]|"\\'"|[^'])+"'"
ComentarioLinea = "//"(.)*
ComentarioLargo = "/*"~"*/"
Comentario = {ComentarioLinea}|{ComentarioLargo}

%{

%}

%%


","	{System.out.println("<Coma,"+yytext()+">");}
";"	{System.out.println("<Punto_Coma,"+yytext()+">");}
"="	{System.out.println("<Asignacion,"+yytext()+">");}
"("	{System.out.println("<Parentesis_A,"+yytext()+">");}
")"	{System.out.println("<Parentesis_C,"+yytext()+">");}
"{"	{System.out.println("<Llave_A,"+yytext()+">");}
"}"	{System.out.println("<Llave_C,"+yytext()+">");}
" " {System.out.println("<Espacio,"+yytext()+">");}

"*"	{System.out.println("<Producto,"+yytext()+">");}
"/"	{System.out.println("<Division,"+yytext()+">");}
"%"	{System.out.println("<Modulo,"+yytext()+">");}
"=="	{System.out.println("<Igualdad,"+yytext()+">");}
"<"	{System.out.println("<Menor,"+yytext()+">");}
">"	{System.out.println("<Mayor,"+yytext()+">");}
">="	{System.out.println("<Mayor_Igual,"+yytext()+">");}
"<="	{System.out.println("<Menor_Igual,"+yytext()+">");}

"struct"	{return java_cup.runtime.Symbol(sym.struct);}
"if"	{return java_cup.runtime.Symbol(sym.if);}
"then"	{return java_cup.runtime.Symbol(sym.then);}
"else"	{return java_cup.runtime.Symbol(sym.else);}
"for"	{return java_cup.runtime.Symbol(sym.for);}
"while"	{return java_cup.runtime.Symbol(sym.while);}
"do"	{return java_cup.runtime.Symbol(sym.do);}
"until"	{return java_cup.runtime.Symbol(sym.until);}
"not"	{return java_cup.runtime.Symbol(sym.not);}
"or"	{return java_cup.runtime.Symbol(sym.or);}
"and"	{return java_cup.runtime.Symbol(sym.and);}
"return"	{return java_cup.runtime.Symbol(sym.return);}
"void"	{return java_cup.runtime.Symbol(sym.void);}
"int"	{return java_cup.runtime.Symbol(sym.int);}
"float"	{return java_cup.runtime.Symbol(sym.float);}

{Identificador}	{return java_cup.runtime.Symbol(sym.ident);}
{Constint}	{return java_cup.runtime.Symbol(sym.constint);}
{Constfloat}	{return java_cup.runtime.Symbol(sym.constfloat);}
{Constlit}	{return java_cup.runtime.Symbol(sym.constlit);}
//Control de errores
"'" {System.out.println("\""+"Error. Constante literal incompleta."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{Comentario}	{return java_cup.runtime.Symbol(sym.comentario);}
"/*"  {System.out.println("\""+"Error. Comentario multilinea de apertura incompleto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
"*/"  {System.out.println("\""+"Error. Comentario multilinea de cierre incompleto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{RealHexaError} {System.out.println("\""+"Error. Numero Hexadecimal incorrecto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{RealOctalError} {System.out.println("\""+"Error. Numero Octal incorrecto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
"+"	{return java_cup.runtime.Symbol(sym.suma);}
"-"	{return java_cup.runtime.Symbol(sym.resta);}
"."	{return java_cup.runtime.Symbol(sym.punto);}
