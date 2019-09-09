import javax.swing.JButton;
import javax.swing.JFrame;

public class ChatSwing extends JFrame{
	
	
	public ChatSwing (VueChatFenetre vue, VueControleurChat control) {
		super(vue.getName());
		JButton boutonFermer = new JButton ("Fermer");
		this.add(boutonFermer);
		this.add(vue);
		this.add(control);
		this.pack();
		this.setVisible(true);
		
		boutonFermer.addActionListener(event -> System.exit(1));
	}

}
