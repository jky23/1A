package plateau;

import javax.swing.JPanel;

import tuiles_spec.TuileVide;
import tuiles_spec.VueTuileAbstraite;

/** Classe qui definit l'affichage d'une tuile
 * 
 * @author jky
 *
 */
@SuppressWarnings("serial")
public class VueTuile extends JPanel {
	
	private VueTuileAbstraite tuile;
	private int ligne;
	private int colonne;
	
	public VueTuile(int nouvelleLigne, int nouvelleColonne) {
		ligne = nouvelleLigne;
		colonne = nouvelleColonne;
		initialiserTuile(new TuileVide(nouvelleLigne, nouvelleColonne));
	}
	
	/** Initialiser une tuile
	 * 
	 * @param nouvelleTuile
	 */
	public void initialiserTuile(VueTuileAbstraite nouvelleTuile) {
		removeAll();
		nouvelleTuile.setCaseEmplacement(ligne, colonne);
		tuile = nouvelleTuile;
		add(tuile);
		revalidate();
	}
	/** Recuperer la tuile
	 * 
	 * @return
	 */
	public VueTuileAbstraite getTuile() {
		return tuile;
	}
	public void setVide() {
		initialiserTuile(new TuileVide(ligne, colonne));
	}
}
	