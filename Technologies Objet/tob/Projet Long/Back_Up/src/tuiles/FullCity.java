package tuiles;

import java.awt.Point;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import tuile_abstraites.TuileAbstraite;
import tuile_abstraites.Ville;
import tuiles_spec.CreateurTuile;
import tuiles_spec.VueTuileAbstraite;

@SuppressWarnings("serial")
public class FullCity extends VueTuileAbstraite {
	private static final String IMAGE_PATH = "src/resources/Full_City.png";
	
	public FullCity(int row, int col) {
		super(IMAGE_PATH, row, col);
	}
	
	private FullCity() {}

	@Override
	public List<TuileAbstraite> construireObjetListe() {
		List<TuileAbstraite> objects = new ArrayList<TuileAbstraite>();
		
		Map<Rotation, List<TuileAbstraite.Position>> temp = new HashMap<Rotation, List<TuileAbstraite.Position>>();
		temp.put(Rotation.NORTH, Arrays.asList(TuileAbstraite.Position.CENTRE));
		temp.put(Rotation.EAST, Arrays.asList(TuileAbstraite.Position.CENTRE));
		temp.put(Rotation.SOUTH, Arrays.asList(TuileAbstraite.Position.CENTRE));
		temp.put(Rotation.WEST, Arrays.asList(TuileAbstraite.Position.CENTRE));
		objects.add(new Ville(temp, new Point(LARGEUR_TUILE / 2, HAUTEUR_TUILE / 2), true));
		
		return objects;
	}

	@Override
	public VueTuileAbstraite construireTuile(int row, int col) {
		return new FullCity(row, col);
	}
	
	public static CreateurTuile getConstruction() {
		return new CreateurTuile(new FullCity());
	}

	
	
	
	
}
