/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package ejemplo_hoc3;

/**
 *
 * @author Rebus
 */
public class SymbolHoc {
    public String name;
    public EnumTipoSymbol TipoSymbol;
    public float val;
    public EnumBLTIN FuncPredef;
    
    public SymbolHoc(){
        name = "";
        val = 0;
    }
    public SymbolHoc(String nombre, EnumTipoSymbol TipSimbolo, float valor){
        name = nombre;
        TipoSymbol = TipSimbolo;
        val = valor;
    }
    public SymbolHoc(String nombre, EnumTipoSymbol TipSimbolo, EnumBLTIN func){
        name = nombre;
        TipoSymbol = TipSimbolo;
        FuncPredef = func;
    }
    public void SetSymbol(String nombre, EnumTipoSymbol TipSimbolo, float valor){
        name = nombre;
        TipoSymbol = TipSimbolo;
        val = valor;
    }
    public void SetSymbol(String nombre, EnumTipoSymbol TipSimbolo, EnumBLTIN func){
        name = nombre;
        TipoSymbol = TipSimbolo;
        FuncPredef = func;
    }
}
