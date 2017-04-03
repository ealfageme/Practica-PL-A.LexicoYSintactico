import java_cup.runtime.*;

%%
%class Lexico
%cup
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


","	{return new java_cup.runtime.Symbol(sym.coma);}
";" {return new java_cup.runtime.Symbol(sym.puntoycoma);}
"="	{return new java_cup.runtime.Symbol(sym.igual);}
"("	{return new java_cup.runtime.Symbol(sym.pAbierto);}
")"	{return new java_cup.runtime.Symbol(sym.pCerrado);}
"{"	{return new java_cup.runtime.Symbol(sym.llaveAbierta);}
"}"	{return new java_cup.runtime.Symbol(sym.llaveCerrada);}
" " {return new java_cup.runtime.Symbol(sym.espacio);}

"*"	{return new java_cup.runtime.Symbol(sym.por);}
"/"	{return new java_cup.runtime.Symbol(sym.division);}
"%"	{return new java_cup.runtime.Symbol(sym.resto);}
"=="	{return new java_cup.runtime.Symbol(sym.dobleigual);}
"<"	{return new java_cup.runtime.Symbol(sym.menorque);}
">"	{return new java_cup.runtime.Symbol(sym.mayorque);}
">="	{return new java_cup.runtime.Symbol(sym.mayoroigualque);}
"<="	{return new java_cup.runtime.Symbol(sym.menoroigualque);}


"struct"	{return new java_cup.runtime.Symbol(sym.struct);}
"if"	{return new java_cup.runtime.Symbol(sym.ifaux);}
"then"	{return new java_cup.runtime.Symbol(sym.thenaux);}
"else"	{return new java_cup.runtime.Symbol(sym.elseaux);}
"for"	{return new java_cup.runtime.Symbol(sym.foraux);}
"while"	{return new java_cup.runtime.Symbol(sym.whileaux);}
"do"	{return new java_cup.runtime.Symbol(sym.doaux);}
"until"	{return new java_cup.runtime.Symbol(sym.until);}
"not"	{return new java_cup.runtime.Symbol(sym.not);}
"or"	{return new java_cup.runtime.Symbol(sym.or);}
"and"	{return new java_cup.runtime.Symbol(sym.and);}
"return"	{return new java_cup.runtime.Symbol(sym.returnaux);}
"void"	{return new java_cup.runtime.Symbol(sym.voidaux);}
"int"	{return new java_cup.runtime.Symbol(sym.intaux);}
"float"	{return new java_cup.runtime.Symbol(sym.floataux);}

{Identificador}	{return new java_cup.runtime.Symbol(sym.ident);}
{Constint}	{return new java_cup.runtime.Symbol(sym.constint);}
{Constfloat}	{return new java_cup.runtime.Symbol(sym.constfloat);}
{Constlit}	{return new java_cup.runtime.Symbol(sym.constlit);}
//Control de errores
"'" {System.out.println("\""+"Error. Constante literal incompleta."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{Comentario}	{return java_cup.runtime.Symbol(sym.comentario);}
"/*"  {System.out.println("\""+"Error. Comentario multilinea de apertura incompleto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
"*/"  {System.out.println("\""+"Error. Comentario multilinea de cierre incompleto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{RealHexaError} {System.out.println("\""+"Error. Numero Hexadecimal incorrecto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
{RealOctalError} {System.out.println("\""+"Error. Numero Octal incorrecto."+" Linea: "+yyline+" Columna: "+ yycolumn +" "+ yytext()+"\"");}
"+"	{return new java_cup.runtime.Symbol(sym.suma);}
"-"	{return new java_cup.runtime.Symbol(sym.resta);}
"."	{return new java_cup.runtime.Symbol(sym.punto);}
