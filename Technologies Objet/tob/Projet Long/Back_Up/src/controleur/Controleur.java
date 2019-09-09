package controleur;

import java.util.ArrayList;
import java.util.List;
import javax.swing.JOptionPane;

import joueur.Joueur;
import joueur.VueJoueur;
import pioche.Pioche;
import pioche.PiocheAbstraite;
import pioche.VuePioche;
import vue.VueCarcassonne;
import plateau.PlateauCarcassonne;
import plateau.VueTuile;
import tuiles_spec.VueTuileAbstraite;

public class Controleur {
	public static final int MAX_JOUEURS = 5;
	public static final int MAX_PIONS = 9;
	
	// Paramètres du jeu -> à changer pour modifier les paramètres de la partie
	private int nombreJoueurs = 5;
	private int nombrePions = 6;
	private PiocheAbstraite pioche = new Pioche();
	private static boolean scorePion = true;
	
	
	// Autres attributs
	private PlateauCarcassonne plateau;
	private VuePioche deck;
	private VueJoueur fenetreJoueur;
	private List<Joueur> joueurs;
	private VueTuileAbstraite tuileActuelle;
	private Joueur joueurActuel;
	private boolean tourFini = true;
	private boolean gameOver = false;
	
	public Controleur() {
		plateau = PlateauCarcassonne.getPlateau();
		deck = VuePioche.getVue();
		fenetreJoueur = VueJoueur.getVue();
	}
	
	private void initialiserJoueur() {
		joueurs = new ArrayList<Joueur>();
		for (int i = 1; i <= nombreJoueurs; i++) {
			joueurs.add(new Joueur(i, nombrePions));
		}
		joueurActuel = joueurs.get(0);
		tourFini = true;  
	}
	
	public void nouveauJeu() {
		gameOver = false;
		deck.reinitialiser(pioche);
		plateau.initialiser(deck.getPiocheTaille());
		initialiserJoueur();	
		fenetreJoueur.initialiser(joueurs);
		tuileActuelle = null;
	}
	
	public Joueur getJoueurActuel() {
		return joueurActuel;
	}
	
	public boolean valider() {
		if (tuileActuelle == null) {return false;}
		List<VueTuileAbstraite> tuilesVoisines = plateau.getTuilesVoisins(tuileActuelle);
		if (!tuileActuelle.validerMouvement(tuilesVoisines)) {return false;}
		tuileActuelle.majAllConnexions(tuilesVoisines);
		tuileActuelle.activerDND(false);
		tuileActuelle.montrerPlacementPion(false);
		tuileActuelle = null;
		plateau.revalidate();
		plateau.repaint();
		tourFini = true;
		
		verifiersiJeuTermine();
		int index = joueurs.indexOf(joueurActuel);
		int next = (index + 1) % joueurs.size();
		joueurActuel = joueurs.get(next);
		reinitialiserJoueur();
		
		return true;
	}
	
	
	public void finduJeu(VueCarcassonne vue) {
		if (gameOver) {
			
			int maxScore = -1;
			List<Joueur> gagnant = new ArrayList<Joueur>();
			for (Joueur joueur : joueurs) {
				if (joueur.getScore() > maxScore) {
					gagnant = new ArrayList<Joueur>();
					maxScore = joueur.getScore();
					gagnant.add(joueur);			
				}
				else if (joueur.getScore() == maxScore) {
					gagnant.add(joueur);
				}
			}
			
			String message = "";
			if (gagnant.size() == 1) {
				message = "Joueur " + gagnant.get(0).getID() + " Gagne !";
			}
			if (gagnant.size() > 1) {
				message = "Match nul ! Joueurs ";
				for (Joueur joueur : gagnant) {
					message = message + joueur.getID() + ", ";
				}
				message = message.substring(0, message.length() - 2);
				message = message + "Gagnent !";
			}
			
			
			int decision = JOptionPane.showConfirmDialog(vue, message + ". Nouveau Jeu (Y) ou Quitter (N) ?", "Fin de la Partie", JOptionPane.YES_NO_OPTION);
			if (decision == 0) {
				nouveauJeu();
			}
			else {
				vue.dispose();
			}
		}
	}
	
	private void verifiersiJeuTermine() {
		if (!deck.aTuileSuivante()) {
			gameOver = true;
		}
	}
	
	private void reinitialiserJoueur() {
		for (Joueur joueur : joueurs) {
			joueur.vider(gameOver);
		}
	}
	
	public boolean getTuileSuivante() {
		if (!tourFini) {return false;}
		tuileActuelle = deck.getTuileSuivante();
		tourFini = false;
		return true;
	}
	
	public void passerTour(VueCarcassonne vue) {
		if (JOptionPane.showConfirmDialog(vue, "Voulez-vous passer votre tour ?") == 0) {
			if (tuileActuelle != null && tuileActuelle.getPion() != null) {
				joueurActuel.retirerPion(tuileActuelle.getPion());
			}
			if (tuileActuelle != null) {
				deck.passerTour(tuileActuelle); 
				
				VueTuile parent = (VueTuile) tuileActuelle.getParent();
				if (parent != null) {
					parent.setVide();
					parent.revalidate();
					parent.repaint();
				}
				
				tuileActuelle = null;		
			}
			
			int index = joueurs.indexOf(joueurActuel);
			int next = (index + 1) % joueurs.size();
			joueurActuel = joueurs.get(next);
			tourFini = true;
		}
	}
	
	
	public void sauvegarder() {
		
	}
	
	public void initialiserPioche(PiocheAbstraite nouvellePioche) {
		pioche = nouvellePioche;
	}
	
	public void initialiserNombreJoueur(int nouveauxJoueurs) {
		nombreJoueurs = nouveauxJoueurs;
	}
	
	public int getNombreJoueur() {
		return nombreJoueurs;
	}
	
	public void setNombrePion(int nouveauxPiions) {
		nombrePions = nouveauxPiions;
	}
	
	public int getNombrePion() {
		return nombrePions;
	}
	
	public void montrerPionScore(boolean affichageScore) {
		scorePion = affichageScore;
		plateau.revalidate();
		plateau.repaint();
	}
	
	public static boolean estMontrerPionScore() {
		return scorePion;
	}
	

}
