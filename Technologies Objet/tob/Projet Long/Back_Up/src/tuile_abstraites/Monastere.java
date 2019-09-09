package tuile_abstraites;

import java.awt.Point;
import java.util.HashMap;
import java.util.List;

import joueur.Joueur;
import plateau.PlateauCarcassonne;
import tuiles_spec.VueTuileAbstraite;
import tuiles_spec.VueTuileAbstraite.Rotation;

public class Monastere extends TuileAbstraite {
	private static final String NOM_MONASTERE = "Monastère";
	private VueTuileAbstraite tuile;

	public Monastere(Point emplacementPion, VueTuileAbstraite nouvelleTuile) {
		super(new HashMap<Rotation, List<Position>>(), emplacementPion);
		tuile = nouvelleTuile;
	}

	@Override
	public boolean estMemeObjet(TuileAbstraite autresTuiles) {
		return autresTuiles instanceof Monastere;
	}
	
	@Override
	public boolean estComplete() {
		PlateauCarcassonne plateau = PlateauCarcassonne.getPlateau();
		return plateau.getTuilesMonastere(tuile).size() == 8;
	}

	@Override
	public int calculeScore(Joueur player) {
		PlateauCarcassonne plateau = PlateauCarcassonne.getPlateau();
		return plateau.getTuilesMonastere(tuile).size() + 1;
	}

	@Override
	public String toString() {
		return NOM_MONASTERE;
	}

}
