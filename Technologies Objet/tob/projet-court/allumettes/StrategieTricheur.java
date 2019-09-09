package allumettes;

/** Classe de stratégie tricheur. */
public class StrategieTricheur implements Strategie {

	@Override
	public int getPrise(Jeu jeu) {
		try {
			while (jeu.getNombreAllumettes() > 2) {
				jeu.retirer(1);
			}
		} catch (CoupInvalideException e) {
		}
		return 1;
	}
}
