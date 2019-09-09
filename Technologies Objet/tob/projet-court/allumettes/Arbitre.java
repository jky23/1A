package allumettes;

/** Modeliser un arbitre pour faire respecter les règles du jeux.
 * @author jky
 */

public class Arbitre {
	/** le 1er joueur. */
	private Joueur joueur1;
	 /** le 2e joueur. */
	private Joueur joueur2;

	/** Construire un arbitre à partir de deux joueurs.
	 * @param j1 le 1er joueur
	 * @param j2 le 2e joueur */
	public Arbitre(Joueur j1, Joueur j2) {
		this.joueur1 = j1;
		this.joueur2 = j2;
	}
	/** Accorder allumettes en fonction du nombre d'allumettes.
	 * @param al le nombre d'allumettes
	 * @return orthographe */
	 //@requires al > 0;
	public String getAccord(int al) {
		if (al <= 1) {
			return "allumette";
		} else {
			return "allumettes";
		}
	}

	/** Arbitrer une partie.
	 * @param jeu la partie en cours
	 */
	public void arbitrer(Jeu jeu) {
		Jeu game;
		Jeu proxy = jeu;
		if (jeu instanceof JeuProxy) {
			game = ((JeuProxy) jeu).getRealgame();
		} else {
			game = jeu;
		}
		boolean tour1 = true;
		Joueur joueurActuel = this.joueur1;
		Joueur vainqueur;
		while (game.getNombreAllumettes() != 0) {
			try {
			System.out.println("\n" + "Nombre d'allumettes restantes : "
			+ game.getNombreAllumettes());
			if (tour1) {
				joueurActuel = this.joueur1;
			} else {
				joueurActuel = this.joueur2;
			}
			System.out.println("Au tour de " + joueurActuel.getNom()
			+ ".");
			int prise = joueurActuel.getPrise(proxy);
			System.out.println(joueurActuel.getNom() + " prend " + prise
					+ " " + getAccord(prise) + ".");
			game.retirer(prise);
			tour1 = !tour1;
		} catch (CoupInvalideException e) {
			System.out.print("Erreur ! ");
			System.out.println(e.getMessage());
			System.out.println("Recommencez !");
		} catch (OperationInterditeException e) {
			System.out.println("Partie abandonnée car "
		+ joueurActuel.getNom()
			+ " a triché !");
			System.exit(1);
			}
		}
		if (joueurActuel == this.joueur1) {
			vainqueur = this.joueur2;
		} else {
			vainqueur = this.joueur1;
		}

		System.out.println(joueurActuel.getNom() + " a perdu !");
		System.out.println(vainqueur.getNom() + " a gagné !");
	}
}
