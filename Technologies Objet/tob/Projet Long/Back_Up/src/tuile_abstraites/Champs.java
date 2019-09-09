package tuile_abstraites;

import java.awt.Point;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import joueur.Joueur;
import tuiles_spec.VueTuileAbstraite.Rotation;

public class Champs extends TuileAbstraite {
	private static final String NOM_FERME = "Ferme";
	private List<Ville> ville;

	public Champs(Map<Rotation, List<Position>> position, Point emplacementPion, List<Ville> villes) {
		super(position, emplacementPion);
		ville = villes;
	}

	@Override
	public boolean estMemeObjet(TuileAbstraite autresTuiles) {
		return autresTuiles instanceof Champs;
	}
	
	public List<Ville> getVilles() {
		return ville;
	}

	@Override
	public int calculeScore(Joueur joueur) {
		List<TuileAbstraite> connections = traverseConnections();
		if (!getJoueurMaxPions(connections).contains(joueur)) {
			return 0;
		}
		
		List<Ville> villes = new ArrayList<Ville>();
		villes.addAll(ville);
		for (TuileAbstraite objet : connections) {
			Champs ferme = (Champs) objet;
			villes.addAll(ferme.getVilles());
		}
		
		List<Ville> allComplete = new ArrayList<Ville>();
		for (Ville city : villes) {
			if (!city.estComplete()) {continue;}
			
			boolean flag = false;
			for (Ville complete : allComplete) {
				if (complete.traverseConnections().contains(city)) {flag = true;}
			}
			
			if (!flag) {allComplete.add(city);}
		}
		return allComplete.size() * 3;
	}
	
	@Override
	public boolean estComplete() {
		return false;
	}

	@Override
	public String toString() {
		return NOM_FERME;
	}

}
