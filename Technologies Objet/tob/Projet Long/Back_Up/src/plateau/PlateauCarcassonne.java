package plateau;

import java.awt.Dimension;

import java.awt.GridLayout;
import java.util.ArrayList;
import java.util.List;
import javax.swing.JPanel;
import javax.swing.JScrollBar;
import javax.swing.JScrollPane;
import javax.swing.JViewport;

import plateau.VueTuile;
import tuiles.StraightRoad;
import tuiles_spec.CreateurTuile;
import tuiles_spec.TuileVide;
import tuiles_spec.VueTuileAbstraite;

@SuppressWarnings("serial")
public class PlateauCarcassonne extends JPanel {
	private int taillePlateau;
	private int nombreTuiles = 30;
	private static final CreateurTuile TUILE_DEPART = StraightRoad.getConstruction();
	private VueTuileAbstraite tuileDepart;
	private VueTuile[][] tuiles;
	private static JScrollPane ScrollPane;
	private static PlateauCarcassonne VuePrincipale;
	
	private PlateauCarcassonne() {
		initialiser(nombreTuiles);
	}
	
	public static PlateauCarcassonne getPlateau() {
		if (VuePrincipale == null) {
			VuePrincipale = new PlateauCarcassonne();
		}
		return VuePrincipale;
	}
	
	public static void setScrollAffichage(JScrollPane scrollPane) {
		ScrollPane = scrollPane;
	}
	
	public static JScrollPane getScrollAffichage() {
		return ScrollPane;
	}
	
	public static JViewport getVue() {
		return ScrollPane.getViewport();
	}
	
	public void initialiser(int nouveauNombreTuiles) {
		removeAll();
		nombreTuiles = nouveauNombreTuiles;
		taillePlateau = (int) Math.ceil(nouveauNombreTuiles / 2.0);
		
		setLayout(new GridLayout(taillePlateau, taillePlateau, 0, -5));

		setPreferredSize(new Dimension(taillePlateau * VueTuileAbstraite.LARGEUR_TUILE, taillePlateau * VueTuileAbstraite.HAUTEUR_TUILE + taillePlateau));	
		tuileDepart = TUILE_DEPART.creerTuile((int) Math.ceil(taillePlateau / 2.0 - 1), (int) Math.ceil(taillePlateau / 2.0 - 1));
		
		tuiles = new VueTuile[taillePlateau][taillePlateau];
		for (int i = 0; i < taillePlateau; i++) {
			for (int j = 0; j < taillePlateau; j++) {
				tuiles[i][j] = new VueTuile(i, j);
				add(tuiles[i][j]);
			}
		}
		tuiles[tuileDepart.getLigne()][tuileDepart.getColonnes()].initialiserTuile(tuileDepart);
		
		centrerVue();
		revalidate();
		repaint();
	}
	
	public void centrerVue() {
		if (ScrollPane == null) {return;}
		JScrollBar horizontal = ScrollPane.getHorizontalScrollBar();
		JScrollBar vertical = ScrollPane.getVerticalScrollBar();
		horizontal.setValue((horizontal.getMaximum() + horizontal.getMinimum() - horizontal.getVisibleAmount()) / 2);
		vertical.setValue((vertical.getMaximum() + vertical.getMinimum() - vertical.getVisibleAmount())/ 2);
		vertical.setUnitIncrement(5);
		horizontal.setUnitIncrement(5);
	}
	
	/**
	 * Obtenir toutes les tuiles voisines qui ne sont pas vides
	 */
	public List<VueTuileAbstraite> getTuilesVoisins(VueTuileAbstraite tuile) {
		List<VueTuileAbstraite> tuilesVoisines = new ArrayList<VueTuileAbstraite>();
		int ligne = tuile.getLigne();
		int colonne = tuile.getColonnes();
		tuilesVoisines.addAll(getTuile(ligne + 1, colonne));
		tuilesVoisines.addAll(getTuile(ligne - 1, colonne));
		tuilesVoisines.addAll(getTuile(ligne, colonne + 1));
		tuilesVoisines.addAll(getTuile(ligne, colonne - 1));
		return tuilesVoisines;
	}
	
	public List<VueTuileAbstraite> getTuilesMonastere(VueTuileAbstraite tuile) {
		List<VueTuileAbstraite> tuilesVoisines = new ArrayList<VueTuileAbstraite>();
		int ligne = tuile.getLigne();
		int colonne = tuile.getColonnes();
		tuilesVoisines.addAll(getTuile(ligne + 1, colonne));
		tuilesVoisines.addAll(getTuile(ligne - 1, colonne));
		tuilesVoisines.addAll(getTuile(ligne, colonne + 1));
		tuilesVoisines.addAll(getTuile(ligne, colonne - 1));
		tuilesVoisines.addAll(getTuile(ligne + 1, colonne + 1));
		tuilesVoisines.addAll(getTuile(ligne - 1, colonne - 1));
		tuilesVoisines.addAll(getTuile(ligne + 1, colonne - 1));
		tuilesVoisines.addAll(getTuile(ligne - 1, colonne + 1));
		return tuilesVoisines;
	}
	
	/**
	 * retourne une tuile à l'emplacement donné (si elle existe)
	 */
	private List<VueTuileAbstraite> getTuile(int ligne, int colonne) {
		List<VueTuileAbstraite> tile_list = new ArrayList<VueTuileAbstraite>();	
		if (ligne < 0 || ligne >= taillePlateau || colonne < 0 || colonne >= taillePlateau 
		   || tuiles[ligne][colonne].getTuile() instanceof TuileVide) {return tile_list;}
		tile_list.add(tuiles[ligne][colonne].getTuile());
		return tile_list;
	}
}
