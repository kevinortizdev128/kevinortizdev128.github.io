package com.mycompany.credito;

import javax.swing.JOptionPane;

/**
 *
 * @author mdavi
 */
public class Credito {

    public static void main(String[] args) {
        String cuenta=JOptionPane.showInputDialog(null,"Introdusca el numero de cuenta:");
        String inicia=JOptionPane.showInputDialog(null,"Introdusca el saldo inicial");
        int inicial=Integer.parseInt(inicia);
        String carg=JOptionPane.showInputDialog(null,"Introdusca la cantidad de articulos cargados");
        int cargo=Integer.parseInt(carg);
        String credit=JOptionPane.showInputDialog(null, "Introdusca la cantidad de credito");
        int credito=Integer.parseInt(credit);
        int fin=(inicial+cargo)-credito;
        if (fin<100000){
        JOptionPane.showMessageDialog(null, "La cuenta "+cuenta+"\nNo a excedido el limite con "+fin,"Aviso",JOptionPane.QUESTION_MESSAGE);
    }else{
            JOptionPane.showMessageDialog(null, "La cuenta "+cuenta+"\nA excedido el limite con "+fin,"Aviso",JOptionPane.QUESTION_MESSAGE);
}
    }
}
