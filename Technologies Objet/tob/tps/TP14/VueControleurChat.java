import javax.swing.JFrame;

public class VueControleurChat extends JFrame{
	
	public VueControleurChat(String pseudo, ControleurChat control) {
		super("Chat de" + pseudo);
		this.add(control);
		this.pack();
		this.setVisible(true);
	}

}
