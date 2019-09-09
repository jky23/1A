package pioche;

import java.awt.BorderLayout;
import java.util.Collections;
import java.util.Map;
import java.util.Stack;

import plateau.VueTuile;
import tuiles_spec.CreateurTuile;
import tuiles_spec.VueTuileAbstraite;

@SuppressWarnings("serial")
public class VuePioche extends VueTuile {
	private static Map<CreateurTuile, Integer> constructeurDeck;
	private Stack<VueTuileAbstraite> deck;
	private static VuePioche vuePrincipale;

	
	private VuePioche() {
		super(-1, -1);
		reinitialiser(new DemoDeck());
	}
	
	public static VuePioche getVue() {
		if (vuePrincipale == null) {
			vuePrincipale = new VuePioche();
		}
		return vuePrincipale;
	}
	
	private void creerPion() {
		deck = new Stack<VueTuileAbstraite>();
		for (CreateurTuile constructeur : constructeurDeck.keySet()) {
			for (int i = 0; i < constructeurDeck.get(constructeur); i++) {
				deck.push(constructeur.creerTuile(-1, -1));
			}
		}
		shuffleDeck();
	}
	
	private void shuffleDeck() {
		Collections.shuffle(deck);
	}
	
	public VueTuileAbstraite getTuileSuivante() {
		if (!aTuileSuivante()) {return null;}
		VueTuileAbstraite next = deck.pop();
		next.activerDND(true);
		next.montrerPlacementPion(true);
		initialiserTuile(next);
		revalidate();
		repaint();
		return next;
	}
	
	public boolean aTuileSuivante() {
		return !deck.isEmpty();
	}
	
	public void passerTour(VueTuileAbstraite tuile) {
		setVide();
		deck.add(tuile);
		shuffleDeck();
	}
	
	public int getPiocheTaille() {
		int size = 0;
		for (CreateurTuile constructeur : constructeurDeck.keySet()) {
			size += constructeurDeck.get(constructeur);
		}
		return size;
	}
	
	public int getTuilesRestantes() {
		return deck.size();
	}
	
	public void reinitialiser(PiocheAbstraite deck) {
		constructeurDeck = deck.getConstructeurPion();
		removeAll();
		setLayout(new BorderLayout());
		setVide();
		creerPion();
		revalidate();
	}
	
}
