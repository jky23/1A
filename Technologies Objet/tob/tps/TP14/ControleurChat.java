import java.awt.FlowLayout;
import java.awt.event.ActionListener;
import javax.*;
import javax.swing.*;
public class ControleurChat extends JPanel {
	//final static int NBCOLONNES = 10;
	//private JPanel barre;
	//private ActionListener saisie;
	
	public ControleurChat(String pseudo, Chat tchat) {
		super(new FlowLayout());
		
		//this.barre = new JPanel();
		JLabel ident = new JLabel(pseudo);
		
		JTextField texte = new JTextField(20);
		
		JButton boutonOk = new JButton("OK");
		this.add(ident);
		this.add(texte);
		this.add(boutonOk);
		
		boutonOk.addActionListener(ev -> tchat.ajouter( new MessageTexte(ident.getText(), texte.getText())));
	}

}
