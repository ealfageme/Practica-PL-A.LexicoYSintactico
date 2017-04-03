import java_cup.runtime.*

%%
%cup
%class Lexico
%unicode
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


","	{return java_cup.runtime.Symbol(sym.coma);}
";" {return java_cup.runtime.Symbol(sym.puntoycoma);}
"="	{return java_cup.runtime.Symbol(sym.igual);}
"("	{return java_cup.runtime.Symbol(sym.pAbierto);}
")"	{return java_cup.runtime.Symbol(sym.pCerrado);}
"{"	{return java_cup.runtime.Symbol(sym.llaveAbierta);}
"}"	{return java_cup.runtime.Symbol(sym.llaveCerrada);}
" " {return java_cup.runtime.Symbol(sym.espacio);}

"*"	{return java_cup.runtime.Symbol(sym.por);}
"/"	{return java_cup.runtime.Symbol(sym.division);}
"%"	{return java_cup.runtime.Symbol(sym.resto);}
"=="	{return java_cup.runtime.Symbol(sym.dobleigual);}
"<"	{return java_cup.runtime.Symbol(sym.menorque);}
">"	{return java_cup.runtime.Symbol(sym.mayorque);}
">="	{return java_cup.runtime.Symbol(sym.mayoroigualque);}
"<="	{return java_cup.runtime.Symbol(sym.menoroigualque);}


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
