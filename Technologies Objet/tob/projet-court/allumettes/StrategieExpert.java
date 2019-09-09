package allumettes;

import java.util.Random;

/** Classe de stratégie experte. */
public class StrategieExpert implements Strategie {
	/** generateur de nombre aleatoires. */
	private Random rand;

    /** Constructeur de la strategie. */
	public StrategieExpert() {
		this.rand = new Random();
	}

	@Override
	public int getPrise(Jeu jeu) {
		if (jeu.getNombreAllumettes() == 1) {
			return 1;
			} else if (jeu.getNombreAllumettes() % (Jeu.PRISE_MAX + 1) == 1) {
			return this.rand.nextInt(Jeu.PRISE_MAX + 1);
		} else {
			int prise = 0;
			int restant = jeu.getNombreAllumettes() - prise;
			while (restant % (Jeu.PRISE_MAX + 1) != 1) {
				prise = this.rand.nextInt(Jeu.PRISE_MAX + 1);
				restant = jeu.getNombreAllumettes() - prise;
			}
			return prise;
		}
	}

}
