package com.mycompany.fechanacimiento;

import java.util.Calendar;
import javax.swing.JOptionPane;

/**
 *
 * @author mdavi
 */
public class FechaNacimiento {

    public static void main(String[] args) {
        String an=JOptionPane.showInputDialog(null,"Ingrese su amo de nacimiento");
        int ano=Integer.parseInt(an);
        String mess=JOptionPane.showInputDialog(null,"Ingrese el numero de mes de nacimiento");
        int mes=Integer.parseInt(mess);
        mes--;
        String dias=JOptionPane.showInputDialog(null,"Ingrese su dia de nacimiento");
        int dia=Integer.parseInt(dias);
        Calendar calendario=Calendar.getInstance();
        int anoACT=calendario.get(Calendar.YEAR);
        int mesACT=calendario.get(Calendar.MONTH);
        int diaACT=calendario.get(Calendar.DAY_OF_MONTH);
        ano=anoACT-ano;
        
        if (mes>mesACT){
            ano--;
            if (dia<=diaACT){
            ano++;}
        }
        mes=12-mes+(mesACT-1);
        
        dia=30-dia+diaACT;
        if (dia >=30){
            mes++;
            dia-=30;
        }
        JOptionPane.showMessageDialog(null, "Tienes "+ano+" amos con "+mes+" meses y "+dia+" dias", "Imformacion", JOptionPane.QUESTION_MESSAGE);
    
    }
}
