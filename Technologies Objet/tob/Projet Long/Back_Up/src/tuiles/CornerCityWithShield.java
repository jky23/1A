package tuiles;

import java.awt.Point;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import tuile_abstraites.Champs;
import tuile_abstraites.TuileAbstraite;
import tuile_abstraites.Ville;
import tuiles_spec.CreateurTuile;
import tuiles_spec.VueTuileAbstraite;

@SuppressWarnings("serial")
public class CornerCityWithShield extends VueTuileAbstraite { 
	private static final String IMAGE_PATH = "src/resources/Corner_City_With_Shield.png";

	public CornerCityWithShield(int row, int col) {
		super(IMAGE_PATH, row, col);
	}
	
	private CornerCityWithShield() {}
	
	@Override
	public List<TuileAbstraite> construireObjetListe() {
		List<TuileAbstraite> objects = new ArrayList<TuileAbstraite>();
		
		Map<Rotation, List<TuileAbstraite.Position>> temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.NORTH, Arrays.asList(TuileAbstraite.Position.CENTRE));
		temp.put(Rotation.WEST, Arrays.asList(TuileAbstraite.Position.CENTRE));
		Ville city1 = new Ville(temp, new Point(LARGEUR_TUILE / 4, HAUTEUR_TUILE / 4), true);
		objects.add(city1);
		
		temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.EAST, Arrays.asList(TuileAbstraite.Position.GAUCHE, TuileAbstraite.Position.CENTRE, TuileAbstraite.Position.DROITE));
		temp.put(Rotation.SOUTH, Arrays.asList(TuileAbstraite.Position.DROITE, TuileAbstraite.Position.CENTRE, TuileAbstraite.Position.GAUCHE));
		objects.add(new Champs(temp, new Point(LARGEUR_TUILE * 3 / 4, HAUTEUR_TUILE * 3 / 4), Arrays.asList(city1)));
		
		return objects;
	}

	@Override
	public VueTuileAbstraite construireTuile(int row, int col) {
		return new CornerCityWithShield(row, col);
	}
	
	public static CreateurTuile getConstruction() {
		return new CreateurTuile(new CornerCityWithShield());
	}
}