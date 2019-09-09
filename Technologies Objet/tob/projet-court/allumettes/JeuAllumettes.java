package allumettes;

/** Jeu principal. */
public class JeuAllumettes implements Jeu {
	/** Nombre d'allumettes.*/
	private int nombre;

	/** Lancer une partie du jeu.
	 * @param nbAllu le nombre d'allumettes */
	//@requires nbAllu != 0;
	public JeuAllumettes(int nbAllu) {
		this.nombre = nbAllu;
	}

	@Override
	public int getNombreAllumettes() {
		return this.nombre;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
	    if (nbPrises > Jeu.PRISE_MAX
	    		&& this.getNombreAllumettes() >= Jeu.PRISE_MAX) {
				throw new CoupInvalideException(nbPrises, "> "
	    		+ Jeu.PRISE_MAX);
			} else if (this.getNombreAllumettes() < Jeu.PRISE_MAX
	    		&& nbPrises > this.getNombreAllumettes()) {
			throw new CoupInvalideException(nbPrises, "> "
	    + this.getNombreAllumettes());
		} else if (nbPrises <= 0) {
			throw new CoupInvalideException(nbPrises, "< 1");
		} else {
			this.nombre = this.nombre - nbPrises;
		}

	}

}
