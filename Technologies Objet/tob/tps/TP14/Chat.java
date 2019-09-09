import java.util.List;
import java.util.Observable;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;

public class Chat extends Observable implements Iterable<Message>  {

	private List<Message> messages;

	public Chat() {
		this.messages = new ArrayList<Message>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		this.notifyObservers();
		this.setChanged();
	}

	@Override
	public Iterator iterator() {
		return Collections.unmodifiableList(this.messages).iterator();
	}
}
