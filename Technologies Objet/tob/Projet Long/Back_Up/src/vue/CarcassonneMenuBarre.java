package vue;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;

import javax.swing.JMenu;
import javax.swing.JMenuBar;
import javax.swing.JMenuItem;

import controleur.Controleur;
import pioche.DemoDeck;
import pioche.Pioche;
import pioche.PiocheAbstraite;

@SuppressWarnings("serial")
/** Classe de la barre de Menu du jeu
 * 
 * @author jky
 *
 */
public class CarcassonneMenuBarre extends JMenuBar {
	private Controleur controleur;
	
	public CarcassonneMenuBarre(Controleur nouveauControleur) {
		controleur = nouveauControleur;
		
		initialiserMenu();
		initialiserParametresMenu();
	}	
	/** Initialiser la barre de menu
	 * 
	 */
	public void initialiserMenu() {
		JMenu menu = new JMenu("Fichier");
		
		JMenuItem nouveau = new JMenuItem("Nouveau Jeu");
		nouveau.addActionListener(new ActionNouveauJeu());
		nouveau.setEnabled(true);
		menu.add(nouveau);
		
		JMenuItem sauvegarder = new JMenuItem("Sauvegarder");
		sauvegarder.addActionListener(new ActionSauvegarder());
		sauvegarder.setEnabled(false);
		menu.add(sauvegarder);
			
		add(menu);			
	}
	/** Initialiser le sous menu Parametres
	 * 
	 */
	public void initialiserParametresMenu() {
		JMenu paramMenu = new JMenu("Paramètres");
		
		paramMenu.add(getMenuJoueur());
		paramMenu.add(getPionMenu());
		paramMenu.add(getPionScoreMenu());
		paramMenu.add(getPiocheMenu());
		
		add(paramMenu);
	}
	/** Construire le menu joueur
	 * 
	 * @return joueur menu
	 */
	private JMenu getMenuJoueur() {
		JMenu joueurMenu = new JMenu("Joueurs");
		
		for (int i = 1; i <= Controleur.MAX_JOUEURS; i++) {
			JMenuItem item = new JMenuItem(Integer.toString(i));
			item.addActionListener(new ActionInitialiserJoueur(i));
			item.setEnabled(true);
			joueurMenu.add(item);			
		}
		return joueurMenu;
	}
	/** Construire le menu Pion
	 * 
	 * @return pionMenu
	 */
	private JMenu getPionMenu() {
		JMenu pionMenu = new JMenu("Pions");
		
		for (int i = 1; i <= Controleur.MAX_PIONS; i++) {
			JMenuItem item = new JMenuItem(Integer.toString(i));
			item.addActionListener(new ActionInitialiserPion(i));
			item.setEnabled(true);
			pionMenu.add(item);		
		}
		return pionMenu;
	}
	
	/** Construire le menu des scores des pions
	 * 
	 * @return pionscoreMenu
	 */
	private JMenu getPionScoreMenu() {
		JMenu pionScoreMenu = new JMenu("Score Pions");
		
		JMenuItem actif = new JMenuItem("Activé");
		actif.addActionListener(new ActionMontrerScorePion(true));
		actif.setEnabled(true);
		pionScoreMenu.add(actif);
		
		JMenuItem desactif = new JMenuItem("Désactivé");
		desactif.addActionListener(new ActionMontrerScorePion(false));
		desactif.setEnabled(true);
		pionScoreMenu.add(desactif);
		
		return pionScoreMenu;
	}
	
	/** Construire le menu de la pioche
	 * 
	 * @return piocheMenu
	 */
	private JMenu getPiocheMenu() {
		JMenu piocheMenu = new JMenu("Pioche");
		
		/**JMenuItem demoDeck = new JMenuItem((new DemoDeck()).toString());
		demoDeck.addActionListener(new ActionInitialiserPioche(new DemoDeck()));
		demoDeck.setEnabled(true);
		piocheMenu.add(demoDeck);**/
		
		JMenuItem standardDeck = new JMenuItem((new Pioche()).toString());
		standardDeck.addActionListener(new ActionInitialiserPioche(new Pioche()));
		standardDeck.setEnabled(true);
		piocheMenu.add(standardDeck);
	
		return piocheMenu;
	}
		
	
	private class ActionNouveauJeu implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			controleur.nouveauJeu();
		}
	}
	
	private class ActionSauvegarder implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			controleur.sauvegarder();
		}
	}
	
	private class ActionInitialiserJoueur implements ActionListener {
		private int nbjoueur;	
		
		public ActionInitialiserJoueur(int i) {
			nbjoueur = i;
		}
		
		public void actionPerformed(ActionEvent e) {
			controleur.initialiserNombreJoueur(nbjoueur);
		}
	}
	
	private class ActionInitialiserPion implements ActionListener {
		private int nbPion;
		
		public ActionInitialiserPion(int i) {
			nbPion = i;
		}
		
		public void actionPerformed(ActionEvent e) {
			controleur.setNombrePion(nbPion);
		}
	}
	
	
	private class ActionInitialiserPioche implements ActionListener {
		private PiocheAbstraite pioche;
		
		public ActionInitialiserPioche(PiocheAbstraite pioc) {
			pioche = pioc;
		}
		
		public void actionPerformed(ActionEvent e) {
			controleur.initialiserPioche(pioche);
		}
	} 
	
	private class ActionMontrerScorePion implements ActionListener {
		private boolean estActive;
		
		public ActionMontrerScorePion(boolean esActif) {
			estActive = esActif;
		}
		
		public void actionPerformed(ActionEvent e) {
			controleur.montrerPionScore(estActive);
		}
	}
	
	
		
		

}
