import javax.*;
import javax.swing.*;
import java.awt.*;
/** Classe presentant les messages à l'utilisateur. */
public class VueChat extends JTextArea {
	//final static int NBCOLONNES;
	//private JTextArea affichage;
	
	public VueChat(Chat tchat, int NBLIGNES, int NBCOLONNES) {
		super(NBLIGNES, NBCOLONNES);
		this.setEditable(false);
		
		for(Message m: tchat) {
		this.append(""+ m +"/n");
		}
	}
		
	

}
