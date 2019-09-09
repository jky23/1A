package tuiles;

import java.awt.Point;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import tuile_abstraites.*;
import tuiles_spec.CreateurTuile;
import tuiles_spec.VueTuileAbstraite;

@SuppressWarnings("serial")
public class CornerCityWithRoad extends VueTuileAbstraite {
	private static String IMAGE_PATH = "src/resources/Corner_City_With_Road.png";
	
	public CornerCityWithRoad(int row, int col) {
		super(IMAGE_PATH, row, col);
	}
	
	private CornerCityWithRoad() {}

	@Override
	public List<TuileAbstraite> construireObjetListe() {
		List<TuileAbstraite> objects = new ArrayList<TuileAbstraite>();
		
		Map<Rotation, List<TuileAbstraite.Position>> temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.EAST, Arrays.asList(TuileAbstraite.Position.CENTRE));
		temp.put(Rotation.SOUTH, Arrays.asList(TuileAbstraite.Position.CENTRE));
		objects.add(new Route(temp, new Point(LARGEUR_TUILE * 2 / 3, HAUTEUR_TUILE  * 2 / 3)));
		
		temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.NORTH, Arrays.asList(TuileAbstraite.Position.CENTRE));
		temp.put(Rotation.WEST, Arrays.asList(TuileAbstraite.Position.CENTRE));
		Ville city1 = new Ville(temp, new Point(LARGEUR_TUILE / 4, HAUTEUR_TUILE / 4), false);
		objects.add(city1);
		
		temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.EAST, Arrays.asList(TuileAbstraite.Position.GAUCHE));
		temp.put(Rotation.SOUTH, Arrays.asList(TuileAbstraite.Position.DROITE));
		objects.add(new Champs(temp, new Point(LARGEUR_TUILE * 3 / 4, HAUTEUR_TUILE / 2), Arrays.asList(city1)));
		
		temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.EAST, Arrays.asList(TuileAbstraite.Position.DROITE));
		temp.put(Rotation.SOUTH, Arrays.asList(TuileAbstraite.Position.GAUCHE));
		objects.add(new Champs(temp, new Point(LARGEUR_TUILE * 7 / 8, HAUTEUR_TUILE * 7 / 8), new ArrayList<Ville>()));
		
		return objects;
	}

	@Override
	public VueTuileAbstraite construireTuile(int row, int col) {
		return new CornerCityWithRoad(row, col);
	}
	
	public static CreateurTuile getConstruction() {
		return new CreateurTuile(new CornerCityWithRoad());
	}

}
