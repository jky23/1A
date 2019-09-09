package allumettes;

/** Modeliser la strategie de jeu du joueur.
 * @author jky
 */

public interface Strategie {

	/** Obtenir la prise du joueur.
	 * @param jeu la partie en cours
	 * @return la prise du joueur */
	//@requires jeu != null;
	int getPrise(Jeu jeu);

}
