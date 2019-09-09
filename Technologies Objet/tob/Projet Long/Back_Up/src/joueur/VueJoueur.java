package joueur;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.swing.ImageIcon;
import javax.swing.JLabel;
import javax.swing.JPanel;

import pion.Pion;

/** Classe qui definit l'affichage d'un joueur
 * 
 * @author jky
 *
 */
@SuppressWarnings("serial")
public class VueJoueur extends JPanel {
	private List<Joueur> joueurs;
	private static VueJoueur vuePrincipale;
	
	private VueJoueur() {
		joueurs = new ArrayList<Joueur>(Arrays.asList(new Joueur(1, 6), new Joueur(2, 6), new Joueur(3, 6)));
		initialiser(joueurs);
	}
	
	public static VueJoueur getVue() {
		if (vuePrincipale == null) {
			vuePrincipale = new VueJoueur();
		}
		return vuePrincipale;
	}
	/** Initialiser la vue avec les joueurs
	 * 
	 * @param initJoueurs
	 */
	public void initialiser(List<Joueur> initJoueurs) {
		joueurs = initJoueurs;
		removeAll();
		setLayout(new BorderLayout());

		JPanel fenetrePion = new JPanel();
		fenetrePion.setLayout(new GridLayout(1, initJoueurs.size()));
		JPanel fenetreJoueurs = new JPanel();
		
		int nombreColonnes = (int) Math.ceil(initJoueurs.size() / 3);
		fenetreJoueurs.setLayout(new GridLayout(3, nombreColonnes));
		
		for (Joueur joueur : initJoueurs) {
			
			JLabel pion = new JLabel(getInfoJoueur(joueur), new ImageIcon(Pion.getBufferedImage(Pion.getCouleur(joueur.getID()))), 0);
			fenetrePion.add(pion);
			
			JLabel nouvelleFenetreJoueur = new JLabel("Joueur " + joueur.getID() + ": " + joueur.getScore() + " ");
			fenetreJoueurs.add(nouvelleFenetreJoueur);
		}
		
		add(fenetrePion, BorderLayout.CENTER);
		add(fenetreJoueurs, BorderLayout.WEST);	
		revalidate();
		repaint();
	}
	
	public void reinitialiser() {
		initialiser(joueurs);
	}
	/** Afficher les infos des differents joueurs
	 * 
	 * @param player
	 * @return
	 */
	public String getInfoJoueur(Joueur player) {
		return "x" + player.getPionsRestant() + " (Joueur " + player.getID() + ")";
	}
	

}
