%% //prueba 


%standalone
%class practicaobligatoria
%line
%column


%xstate negritaA, cursivaA, negritaAnidadaA, cursivaAnidadaA, negritaB, cursivaB, negritaAnidadaB, cursivaAnidadaB, lista

%init{
	System.out.println("<!DOCTYPE html>");
	System.out.println("<html>");
	System.out.println("<head>");
	System.out.println("	<title>MarkDown2HTML</title>");
	System.out.println("<style>");
	System.out.println("	.bold {font-weight: bold;}");
	System.out.println("	.ital {font-style: italic;}");
	System.out.println("</style>");
	System.out.println("</head>");
	System.out.println("<body>");
%init}

%{
	String[] parts;
	String reconocer, href;
%}

%eof{
	System.out.println("</body>");
	System.out.println("</html>");
%eof}
	NoFinal = [^~] | "~"[^~] | "~~"[^~]
	NoFinalNegrita = [a-zA-Z0-9]
	NoFinalCursiva = [a-zA-Z0-9]
	urlcorrecta = [a-zA-Z0-9]
	item = "- ".+[^.]"\r\n"
	http = "http://"{urlcorrecta}+"."{urlcorrecta}+"."{urlcorrecta}+
	https = "https://"{urlcorrecta}+"."{urlcorrecta}+"."{urlcorrecta}+
%%

//Aprobado

"# ".*	{parts = yytext().split("# ");
		 reconocer = parts[1];
		 System.out.println("<H1>"+reconocer+"</H1>");}
"## ".*	{parts = yytext().split("# ");
		 reconocer = parts[1];
		 System.out.println("<H2>"+reconocer+"</H2>");}
"### ".*	{parts = yytext().split("# ");
		 reconocer = parts[1];
		 System.out.println("<H3>"+reconocer+"</H3>");}
"#### ".*	{parts = yytext().split("# ");
		 reconocer = parts[1];
		 System.out.println("<H4>"+reconocer+"</H4>");}
"##### ".*	{parts = yytext().split("# ");
		 reconocer = parts[1];
		 System.out.println("<H5>"+reconocer+"</H5>");}
"###### ".*	{parts = yytext().split("# ");
		 reconocer = parts[1];
		 System.out.println("<H6>"+reconocer+"</H6>");}

"> ".* {System.out.println("<blockquote>");
		 parts = yytext().split("> ");
		 reconocer = parts[1];
		 System.out.println(reconocer);
		 System.out.println("</blockquote>");}

"***"|"---"|"___"	{System.out.print("<HR>");}

"~~~"{NoFinal}+"~~~"	{reconocer = yytext().replaceAll("~~~", "");
					 System.out.print("<code> <pre>");
					 System.out.print(reconocer);
					 System.out.println("</pre> </code>");}

//Notable

<YYINITIAL>"__"	{ System.out.print("<SPAN class=\"bold\">");yybegin(negritaB);}
<YYINITIAL>"**" { System.out.print("<SPAN class=\"bold\">");yybegin(negritaA);}
<negritaB> "__" { System.out.println("</SPAN>"); yybegin(YYINITIAL);}
<negritaA> "**" { System.out.println("</SPAN>"); yybegin(YYINITIAL);}
<cursivaA> "__" { System.out.print("<SPAN class=\"bold\">");yybegin(negritaAnidadaB);}
<cursivaB> "**"	{ System.out.print("<SPAN class=\"bold\">");yybegin(negritaAnidadaA);}
<negritaAnidadaA> "**" { System.out.println("</SPAN>"); yybegin(cursivaB);}
<negritaAnidadaB> "__" { System.out.println("</SPAN>"); yybegin(cursivaA);}
<negritaA, negritaAnidadaA, negritaB, negritaAnidadaB> {NoFinalNegrita} {System.out.print(yytext());}

<YYINITIAL> "*"	{ System.out.print("<SPAN class=\"ital\">");yybegin(cursivaA);}
<YYINITIAL> "_" { System.out.print("<SPAN class=\"ital\">");yybegin(cursivaB);}
<cursivaA> "*"	{System.out.println("</SPAN>"); yybegin(YYINITIAL);}
<cursivaB> "_" { System.out.println("</SPAN>"); yybegin(YYINITIAL);}
<negritaA> "_" { System.out.print("<SPAN class=\"ital\">");yybegin(cursivaAnidadaB);}
<negritaB> "*"	{ System.out.print("<SPAN class=\"ital\">");yybegin(cursivaAnidadaA);}
<cursivaAnidadaA> "*"	{ System.out.println("</SPAN>"); yybegin(negritaB);}
<cursivaAnidadaB> "_" { System.out.println("</SPAN>"); yybegin(negritaA);}
<cursivaA, cursivaAnidadaA, cursivaB, cursivaAnidadaB> {NoFinalCursiva} {System.out.print(yytext());}

//Sobresaliente

{item}+ {

			parts = yytext().split("- ");
			System.out.println("<UL>");
			for (int i=1; i<parts.length; i++){
				reconocer = parts[i];
				System.out.print("<LI>");
				reconocer = reconocer.replaceAll("\r", "");
				reconocer = reconocer.replaceAll("\n", "");
				System.out.print(reconocer);
				System.out.println("</LI>");
			}
				System.out.println("</UL>");
			}


"[".+"]""("({http}|{https})")"	{reconocer = yytext().replaceAll("\\[", "");
							 reconocer = reconocer.replaceAll("\\]", "");
							 parts = reconocer.split("\\(");
							 reconocer = parts[0];
							 href = parts[1];
							 href = href.replaceAll("\\)", "");
							 System.out.println("<A HREF=\"" + href + "\">");
							 System.out.println(reconocer);
							 System.out.println("</A>");}

"[".+"]""(".+")"	{reconocer = yytext().replaceAll("\\[", "");
							 reconocer = reconocer.replaceAll("\\]", "");
							 parts = reconocer.split("\\(");
							 reconocer = parts[0];
							 href = parts[1];
							 href = href.replaceAll("\\)", "");
							 System.out.println("<A HREF=\"" + href + "\">");
							 System.out.println(reconocer + " (URL enlace aparentemente incorrecta)");
							 System.out.println("</A>");}
