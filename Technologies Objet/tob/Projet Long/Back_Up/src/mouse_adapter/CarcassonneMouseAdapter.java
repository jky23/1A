package mouse_adapter;

import java.awt.Component;
import java.awt.Point;
import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

import javax.swing.JLayeredPane;
import javax.swing.SwingUtilities;

import controleur.Controleur;
import pioche.VuePioche;
import plateau.PlateauCarcassonne;
import plateau.VueTuile;
import tuiles_spec.TuileVide;
import tuiles_spec.VueTuileAbstraite;

/** Redifinition des actions d'écoute liés a la souris
 * 
 * @author jky
 *
 */
public class CarcassonneMouseAdapter extends MouseAdapter {
	private Controleur controleur;
	private JLayeredPane layeredPane;
	private VueTuile fenetreClic;
	private VueTuileAbstraite titre;
	
	public CarcassonneMouseAdapter(Controleur nouveauControleur, JLayeredPane nouveauLayeredPane) {
		controleur = nouveauControleur;
		layeredPane = nouveauLayeredPane;
	}
	/** Reinitialiser une tuile
	 * 
	 */
	private void reinitialiser() {
		if (titre != null) {
			layeredPane.remove(titre);
			layeredPane.revalidate();
			layeredPane.repaint();
		}
		titre = null;
		fenetreClic = null;
	}
	/** convertir un point des coordonnées de sa modelisation a ses coordonnées dans un composant graphique
	 * 
	 * @param composant
	 * @param e
	 * @return nouveaupoint
	 */
	public Point translaterPoint(Component composant, MouseEvent e) {		
		return SwingUtilities.convertPoint((Component) e.getSource(), e.getPoint(), composant);
	}
	
	/** Verifie si les coordonnees du point converti sont bien dans le composant
	 * 
	 * @param composant
	 * @param e
	 * @return
	 */
	public boolean contientPoint(Component composant, MouseEvent e) {
		Point translate = translaterPoint(composant, e );
		return translate.getX() > 0 && translate.getY() > 0
			&& translate.getX() < composant.getWidth() && translate.getY() < composant.getHeight();
	}
	/** Verifie si les coordonnees d'un point sont dans un certain intervalle (cercle)
	 * 
	 * @param composant
	 * @param p
	 * @param rayon
	 * @param e
	 * @return
	 */
	public boolean contientPoint(Component composant, Point p, int rayon, MouseEvent e) {
		Point translate = translaterPoint(composant.getParent(), e);
		double translateX = translate.getX();
		double translateY = translate.getY();
		return translateX < p.x + rayon && translateX > p.x - rayon && translateY > p.y - rayon && translateY < p.y + rayon;	
	}
	
	@Override
	public void mouseClicked(MouseEvent event) {
		PlateauCarcassonne plateau = PlateauCarcassonne.getPlateau();
		VuePioche pioche = VuePioche.getVue();
		VueTuile fenetreClic = null;
		
		if (contientPoint(pioche, event)) {
			fenetreClic = pioche;
		}
		else if (contientPoint(PlateauCarcassonne.getVue(), event)) {
			Component composant = plateau.getComponentAt(translaterPoint(plateau, event));
			if (!(composant instanceof VueTuile)) {return;} 
			fenetreClic = (VueTuile) composant;		
		}
	
		if (fenetreClic == null || fenetreClic.getTuile() instanceof TuileVide) {
			return;
		}
		VueTuileAbstraite tuile = fenetreClic.getTuile();
		
		if (tuile.montrePionPlacement()) {
			for (Point point : tuile.getPionPoints()) {
				if (contientPoint(tuile, point, 4, event)) {
					if (tuile.aPion(point)) {
						controleur.getJoueurActuel().retirerPion(tuile.getPion());		
					}
					else {
						tuile.setPion(controleur.getJoueurActuel().getNouveauPion(tuile, tuile.getObjectAt(point)));
					}
					reinitialiser();
					return;
				}
			}
		}
		if (tuile.esDNDActive()) {
			tuile.rotate();
		}
		reinitialiser();	
	}
	
	@Override
	public void mousePressed(MouseEvent event) {
		PlateauCarcassonne plateau = PlateauCarcassonne.getPlateau();
		VuePioche deck = VuePioche.getVue();
		
		if (contientPoint(deck, event)) {
			fenetreClic = deck;
			titre = fenetreClic.getTuile();
		}
		else if  (contientPoint(PlateauCarcassonne.getVue(), event)) {
			Component composant = plateau.getComponentAt(translaterPoint(plateau, event));
			if (composant instanceof VueTuile) { //to make sure hasn't clicked in between tiles
				fenetreClic = (VueTuile) composant;
				titre = fenetreClic.getTuile();
			}
		}
		
		if (titre == null || titre instanceof TuileVide || !titre.esDNDActive()) {
			reinitialiser();
			return;
		}
	}
	
	@Override
	public void mouseDragged(MouseEvent event) {
		if (titre == null) {
			reinitialiser();
			return;
		}
		fenetreClic.setVide();
		try {
			layeredPane.add(titre, JLayeredPane.DRAG_LAYER);
		} catch (IllegalArgumentException e) {
			
		}	
		int x = translaterPoint(layeredPane, event).x - titre.getWidth() / 2;
		int y = translaterPoint(layeredPane, event).y - titre.getHeight() / 2;		
		titre.setLocation(x, y);
		layeredPane.revalidate();
		layeredPane.repaint();	
	}
	
	@Override 
	public void mouseReleased(MouseEvent event) {
		if (titre == null) {
			return;
		}
		
		PlateauCarcassonne plateau = PlateauCarcassonne.getPlateau();
		layeredPane.remove(titre);
		
		VueTuile drop = null;
		if (contientPoint(PlateauCarcassonne.getVue(), event)) {
			drop = (VueTuile) plateau.getComponentAt(translaterPoint(plateau, event));
		}
		if (drop == null || !(drop.getTuile() instanceof TuileVide)) {
			
			fenetreClic.initialiserTuile(titre);
			reinitialiser();
			return;
		}
		drop.initialiserTuile(titre);
		reinitialiser();
	}
}
