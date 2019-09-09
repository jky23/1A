package tuile_abstraites;

import java.awt.Point;
import java.util.List;
import java.util.Map;

import joueur.Joueur;
import tuiles_spec.VueTuileAbstraite.Rotation;

public class Ville extends TuileAbstraite {
	private static final String CITY_NAME = "City";
	private boolean hasShield;

	public Ville(Map<Rotation, List<Position>> position, Point meeplePlacement, boolean shielded) {
		super(position, meeplePlacement);
		hasShield = shielded;
	}

	@Override
	public boolean estMemeObjet(TuileAbstraite other) {
		return other instanceof Ville;
	}
	
	public boolean hasShield() {
		return hasShield;
	}

	@Override
	public int calculeScore(Joueur player) {
		int score = 0;
		List<TuileAbstraite> connections = traverseConnections();
		
		if (!getJoueurMaxPions(connections).contains(player)) {
			return score;
		}
		
		for (TuileAbstraite object : connections) {
			if (((Ville) object).hasShield()) {score += 2;}
			else {score += 1;}
		}	
		if (estComplete()) {score *= 2;}
		return score;
	}
	
	@Override
	public String toString() {
		return CITY_NAME;
	}

	
}
