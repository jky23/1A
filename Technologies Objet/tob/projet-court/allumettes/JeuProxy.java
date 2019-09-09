package allumettes;

/** Jeu proxy. */
public class JeuProxy implements Jeu {
	/** Jeu réel sur lequel créer le proxy. */
	private Jeu reel;

	/** Creer le proxy à partir du jeu reel.
	 * @param jeureel le jeu
	 */
	public JeuProxy(Jeu jeureel) {
		this.reel = jeureel;
	}

	/** Recuperer le jeu réel d'un proxy.
	 */
	public Jeu getRealgame() {
		return this.reel;
	}

	@Override
	public int getNombreAllumettes() {
		return this.reel.getNombreAllumettes();
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		throw new OperationInterditeException();

	}

}
