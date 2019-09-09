package tuiles_spec;

import java.util.ArrayList;
import java.util.List;

import tuile_abstraites.TuileAbstraite;

@SuppressWarnings("serial")
public class TuileVide extends VueTuileAbstraite {
	private static final String IMAGE_PATH = "src/resources/Empty_Tile.png";
	
	public TuileVide(int row, int col) {
		super(IMAGE_PATH, row, col);
	}
	
	@Override
	public List<TuileAbstraite> construireObjetListe() {
		return new ArrayList<TuileAbstraite>();
	}

	@Override
	public VueTuileAbstraite construireTuile(int row, int col) {
		return new TuileVide(row, col);
	}
	
}
