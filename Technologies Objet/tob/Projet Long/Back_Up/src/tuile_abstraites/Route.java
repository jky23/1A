package tuile_abstraites;

import java.awt.Point;
import java.util.List;
import java.util.Map;

import joueur.Joueur;
import tuiles_spec.VueTuileAbstraite.Rotation;

public class Route extends TuileAbstraite {
	private static final String ROAD_NAME = "Road";

	public Route(Map<Rotation, List<Position>> position, Point meeplePlacement) {
		super(position, meeplePlacement);
	}

	@Override
	public boolean estMemeObjet(TuileAbstraite other) {
		return other instanceof Route;
	}

	@Override
	public int calculeScore(Joueur player) {
		List<TuileAbstraite> connections = traverseConnections();
		if (!getJoueurMaxPions(connections).contains(player)) {
			return 0;
		}
		
		return connections.size();
	}

	@Override
	public String toString() {
		return ROAD_NAME;
	}

}
