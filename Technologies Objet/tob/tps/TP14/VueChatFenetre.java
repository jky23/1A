import javax.*;
import javax.swing.*;
public class VueChatFenetre extends JFrame {
	
	public VueChatFenetre(String name, VueChat chat) {
		super("Chat de" + name);
		
		this.add(chat);
		this.pack();
		this.setVisible(true);
		
		//boutonFermer.addActionListener(event -> System.exit(1));
	}

}
