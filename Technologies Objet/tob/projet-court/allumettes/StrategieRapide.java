package allumettes;

/** Classe de stratégie rapide. */
public class StrategieRapide implements Strategie {

	/** Constructeur de la strategie. */
	public StrategieRapide() {
	}

	@Override
	public int getPrise(Jeu jeu) {
		return Math.min(Jeu.PRISE_MAX, jeu.getNombreAllumettes());
	}

}
