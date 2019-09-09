package allumettes;

/** Modeliser un joueur pour une partie du jeu des 13 allumettes.
 * @author jky
 */

public class Joueur {
	/** le nom du joueur. */
	private String nom;
	/** la strategie de jeu du joueur. */
	private Strategie strategie;

	/** Construire un joueur à partir de son nom et de sa stratégie.
	 * @param name le nom du joueur
	 * @param strat la stratégie du joueur */
	public Joueur(String name, Strategie strat) {
		this.nom = name;
		this.strategie = strat;
	}

	/** Recuperer le nom du joueur.
	 * @return le nom du joueur
	 */
	public String getNom() {
		return this.nom;
	}

	/** Recuperer la strategie du joueur.
	 * @return la strategie
	 */
	public Strategie getStrategie() {
		return this.strategie;
	}

	/** Obtenir la prise du joueur.
	 * @param jeu le jeu en cours
	 * @return la prise */
	//@requires jeu != null;
	public int getPrise(Jeu jeu) {
		return this.strategie.getPrise(jeu);
	}

	/** Modifier la strategie du joueur.
	 * @param strategy la nouvelle strategie */
	//@requires strategy != null;
	public void setStrategie(Strategie strategy) {
		this.strategie = strategy;
		}
}
