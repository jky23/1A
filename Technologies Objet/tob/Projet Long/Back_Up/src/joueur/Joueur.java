package joueur;

import java.util.ArrayList;
import java.util.List;

import pion.Pion;
import tuile_abstraites.TuileAbstraite;
import tuiles_spec.VueTuileAbstraite;

public class Joueur {
	private int iD;
	private int nombrePionsTotal;
	private List<Pion> pions;
	private int score;
	
	public Joueur(int id, int nombrePions) {
		iD = id;
		nombrePionsTotal = nombrePions;
		pions = new ArrayList<Pion>();
		score = 0;
	}
	
	public int getID() {
		return iD;
	}
	
	public int getPionsRestant() {
		return nombrePionsTotal - pions.size();
	}
	
	public boolean aAutrePion() {
		return getPionsRestant() > 0;
	}
	
	public Pion getNouveauPion(VueTuileAbstraite tuile, TuileAbstraite tuileAbstraite) {
		Pion pion = new Pion(Pion.getCouleur(iD), tuile, tuileAbstraite, this);
		pions.add(pion);
		VueJoueur.getVue().reinitialiser();
		return pion;
	}
	
	public void retirerPion(Pion pion) {
		pion.retirer();
		pions.remove(pion);
		VueJoueur.getVue().reinitialiser();
	}
	
	public int getScore() {
		return score;
	}
	
	public void augmenterScore(int points) {
		score += points;
		VueJoueur.getVue().reinitialiser();
	}
	
	public void vider(boolean gameOver) {
		List<Pion> pionComplet = new ArrayList<Pion>();
		for (Pion pion : pions) {
			if (pion.estObjetComplet() || gameOver) {
				score += pion.getScore();
				pionComplet.add(pion);
			}
		}
		for (Pion pion : pionComplet) {
			retirerPion(pion);
		}
	}
	

}
