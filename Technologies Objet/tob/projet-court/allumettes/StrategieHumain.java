package allumettes;

import java.util.Scanner;

/** Classe de stratégie humain. */
public class StrategieHumain implements Strategie {
	/** scanner pour la saisie du joueur. */
	private Scanner scan;

	/** Constructeur de la strategie. */
	public StrategieHumain() {
		this.scan = new Scanner(System.in);
	}

	@Override
	public int getPrise(Jeu jeu) {
		int prise = 0;
		try {
			System.out.print("Combien prenez-vous d'allumettes ? ");
			prise = Integer.parseInt(this.scan.nextLine().trim());
			return prise;
		} catch (NumberFormatException e) {
			System.out.println("Vous devez donner un entier.");
			return getPrise(jeu);
		}
	}

}
