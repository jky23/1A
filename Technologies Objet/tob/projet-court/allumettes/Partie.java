package allumettes;

/** Lance une partie des 13 allumettes en fonction des arguments fournis
 * sur la ligne de commande.
 * @author	Xavier Crégut
 * @version	$Revision: 1.5 $
 */
public class Partie {
	/** Nombre de joueurs .*/
	static final int NBJOUEUR = 2;
	/** Nombre d'allumettes .*/
	static final int NBALLU = 13;

	/** Lancer une partie. En argument sont donnés les deux joueurs sous
	 * la forme nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		Boolean option = false;
		int optConfig = 0;
		try {
			verifierNombreArguments(args);
			if (args.length == NBJOUEUR + 1) {
				option = true;
				optConfig = 1;
			}

			//Recuperation des configurations de chaque joueur
			String[] play1 = getConfig(args, 0 + optConfig, "@");
			String[] play2 = getConfig(args, 1 + optConfig, "@");

			//Verification du format des configurations
			verifierNomStrategie(play1);
			verifierNomStrategie(play2);

			//Creation des strategies
			Strategie strategy1 = recupStrategie(play1[1]);
			Strategie strategy2 = recupStrategie(play2[1]);

			//Creation des joueurs
			Joueur j1 = new Joueur(play1[0], strategy1);
			Joueur j2 = new Joueur(play2[0], strategy2);

			//Creation du jeu
			Jeu game = new JeuAllumettes(NBALLU);
			Jeu proxy;
			if (option) {
				proxy = game;
			} else {
				proxy = new JeuProxy(game);
			}

			//Creation de l'arbitre
			Arbitre referee = new Arbitre(j1, j2);
			referee.arbitrer(proxy);

		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Erreur : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}
	/** Verifier le nombre d'arguments entrés par le joueur.
	 * @param args le nombre d'arguments
	 */

	private static void verifierNombreArguments(String[] args) {
		if (args.length < NBJOUEUR) {
			throw new ConfigurationException("Trop peu d'arguments : "
					+ args.length);
		}
		if (args.length > NBJOUEUR + 1) {
			throw new ConfigurationException("Trop d'arguments : "
					+ args.length);
		}
	}

	/** Verifier et recuperer la stratégie entrée par le joueur.
	 * @param strategie la strategie du joueur
	 * @return la strategie du joueur
	 */
	public static Strategie recupStrategie(String strategie) {
		Strategie strat;
		switch (strategie) {
		case "naif":
			strat = new StrategieNaive();
			break;
		case "rapide" :
			strat = new StrategieRapide();
			break;
		case "expert" :
			strat = new StrategieExpert();
			break;
		case "humain" :
			strat = new StrategieHumain();
			break;
		case "tricheur" :
			strat = new StrategieTricheur();
			break;
		default :
			throw new ConfigurationException("Stratégie mal définie");
		}
		return strat;
	}

	/** Verifier le nom et la strategie de chaque joueur entres
	 *  dans la ligne de commande.
	 * @param part argument de la forme nom@strategie
	 */
	public static void verifierNomStrategie(String[] part) {
		if (part.length != 2) {
			throw new ConfigurationException("Mauvaise saisie du nom "
					+ "et de la strategie");
		}
		if (part[0] == null || part[1] == null) {
			throw new ConfigurationException("Mauvaise saisie du nom"
					+ "et de la strategie");
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :"
				+ "\n\t" + "java allumettes.Partie joueur1 joueur2"
				+ "\n\t\t" + "joueur est de la forme nom@stratégie"
				+ "\n\t\t" + "strategie = naif | rapide | expert "
						+ "| humain | tricheur"
				+ "\n"
				+ "\n\t" + "Exemple :"
				+ "\n\t" + "	java allumettes.Partie Xavier@humain "
					   + "Ordinateur@naif"
				+ "\n"
				);
	}

	/** Decouper les paramètres de la ligne de commande.
	 * @param args string à découper
	 * @param caract caractère où découper
	 * @param index partie du tableau à découper
	 * @return un tableau de deux strings
	 */
	public static String[] getConfig(String[] args, int index, String caract) {
		return args[index].split(caract);
	}
}
