
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


","	{return java_cup.runtime.Synbol(sym.coma);}
";"{return java_cup.runtime.Synbol(sym.puntoycoma);}
"="	{return java_cup.runtime.Synbol(sym.igual);}
"("	{return java_cup.runtime.Synbol(pAbierto);}
")"	{return java_cup.runtime.Synbol(sym.pCerrado);}
"{"	{return java_cup.runtime.Synbol(sym.llaveAbierta);}
"}"	{return java_cup.runtime.Synbol(sym.llaveCerrada);}
" " {return java_cup.runtime.Synbol(sym.espacio);}

"*"	{return java_cup.runtime.Synbol(sym.por);}
"/"	{return java_cup.runtime.Synbol(sym.barrainclinada);}
"%"	{return java_cup.runtime.Synbol(sym.resto);}
"=="	{return java_cup.runtime.Synbol(sym.igual);}
"<"	{return java_cup.runtime.Synbol(sym.menorque);}
">"	{return java_cup.runtime.Synbol(sym.mayorque);}
">="	{return java_cup.runtime.Synbol(sym.mayoroigualque);}
"<="	{return java_cup.runtime.Synbol(sym.menoroigualque);}

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
"'" {System.out.println("\""+"Error. Constante literal incompleta."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{Comentario}	{System.out.println("<Comentario,"+yytext()+">");}
"/*"  {System.out.println("\""+"Error. Comentario multilinea de apertura incompleto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
"*/"  {System.out.println("\""+"Error. Comentario multilinea de cierre incompleto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{RealHexaError} {System.out.println("\""+"Error. Numero Hexadecimal incorrecto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{RealOctalError} {System.out.println("\""+"Error. Numero Octal incorrecto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
"+"	{System.out.println("<Suma,"+yytext()+">");}
"-"	{System.out.println("<Resta,"+yytext()+">");}
"."	{System.out.println("<Punto,"+yytext()+">");}
