package allumettes;
import java.util.Random;

/** Classe de stratégie naive. */
public class StrategieNaive implements Strategie {
	/** Generateur aleatoire de nombres. */
	private Random rand;

	/** Constructeur de la strategie. */
	public StrategieNaive() {
		this.rand = new Random();
	}

	@Override
	public int getPrise(Jeu jeu) {
		return this.rand.nextInt(Math.max(Jeu.PRISE_MAX,
				jeu.getNombreAllumettes()) + 1);
	}

}
