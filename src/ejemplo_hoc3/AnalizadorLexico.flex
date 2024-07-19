package ejemplo_hoc3;

import java_cup.runtime.Symbol;
import java.io.Reader;

%%  /* inicio de declaraciones JFlex */
%class AnalizadorLexico
%line     /* Se habilita el contador de lineas. Variable yyline, de tipo integer */
%column   /* Se habilita el contador de columnas. Variable yycolumn, de tipo integer */
%char     /* Se habilita el contador de caracteres. Variable yychar, de tipo long */
%cup      /* Se habilita la compatibilidad con java cup */

/* el código entre %{ y %} se copia tal cual dentro de la clase del analizador léxico */
%{
public SymbolHoc s;
public int TipSimb;

TablaSimbolos ListaSimb = new TablaSimbolos();
/* Se crean los objetos Symbol para ser utilizados durante la síntesis de los atributos
   Symbol está especificado en java_cup.Symbol */
    private Symbol symbol(int type) {
        return new Symbol(type, yyline, yycolumn);
    }

    private Symbol symbol(int type, Object value) {
        return new Symbol(type, yyline, yycolumn, value);
    }

%}

/* hacemos algunas definiciones regulares, o macro definiciones */
Letra=[a-zA-Z]
Digito=[0-9]

%% /* Ahora van las expresiones regulares */
[ \t\n]+                        { ;}
";"                            { return symbol(AnalizadorSintacticoSym.SEMIC); }
{Digito}+(\.{Digito}+)?        { 
                                    return symbol(AnalizadorSintacticoSym.NUM, new Float(yytext())); 
                               }
"="                            { return symbol(AnalizadorSintacticoSym.OpAsig); }
"/"                            { return symbol(AnalizadorSintacticoSym.OpDiv); }
"*"                            { return symbol(AnalizadorSintacticoSym.OpProd); }
"-"                            { return symbol(AnalizadorSintacticoSym.OpResta); }
"+"                            { return symbol(AnalizadorSintacticoSym.OpSuma); }
"("                            { return symbol(AnalizadorSintacticoSym.ParIzq); }
")"                            { return symbol(AnalizadorSintacticoSym.ParDer); }
\^                            { return symbol(AnalizadorSintacticoSym.OpPotencia); }
{Letra}({Letra}|{Digito})*     {
                                s = ListaSimb.lookup(yytext());
                                if(s == null) // Se agregará como variable no inicializada
                                    s = ListaSimb.install(yytext(), EnumTipoSymbol.UNDEF, (float)0.0);
                                switch(s.TipoSymbol){
                                    case UNDEF:
                                        TipSimb = AnalizadorSintacticoSym.VAR;
                                        break;
                                    case VAR:
                                        TipSimb = AnalizadorSintacticoSym.VAR;
                                        break;
                                    case BLTIN:
                                        TipSimb = AnalizadorSintacticoSym.BLTIN;
                                        break;
                                    case CONST_PREDEF:
                                        TipSimb = AnalizadorSintacticoSym.CONST_PRED;
                                        break;
                                }
                                return symbol(TipSimb, s);
                            }
.   { return symbol(AnalizadorSintacticoSym.error); }


/* Estos comandos deben ejecturase en la consola
    java -jar java-cup-11b.jar SintacHoc3.cup
    java -jar jflex.jar
*/