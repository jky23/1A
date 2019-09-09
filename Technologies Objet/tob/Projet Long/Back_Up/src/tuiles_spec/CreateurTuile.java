package tuiles_spec;

public class CreateurTuile {
	private VueTuileAbstraite myTile;

	public CreateurTuile(VueTuileAbstraite tile) {
		myTile = tile;
	}
	
	public VueTuileAbstraite creerTuile(int row, int col) {
		return myTile.construireTuile(row, col);
	}
}