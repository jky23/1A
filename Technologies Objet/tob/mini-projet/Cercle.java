import java.awt.Color;
/** Cercle modélise une courbe plane constitué de points
 * à égale distance d'un point nommé centre.
 * Le cercle peut être translaté.
 * On peut obtenir son centre, son rayon, son diamètre.
 */

public class Cercle implements Mesurable2D {
	/**Centre du cercle.*/
	private Point centre;

	/**rayon du cercle.*/
	private double rayon;

	/**Couleur du cercle.*/
	private Color couleur;

	/**Constante pi.*/
	public static final double PI = Math.PI;

	/** E12 Construire un cercle à partir de son centre et de son rayon.
	 * @param pt0 centre
	 * @param r rayon
	 * @pre pt != null;
	 * @pre r > 0
	 */
	public Cercle(Point pt0, double r) {
		assert (pt0 != null);
		assert (r > 0);
		System.out.println("CONSTRUCTEUR Cercle(" + pt0 + "," + r + ")");
		this.centre = new Point(0, 0);
		this.centre.setX(pt0.getX());
		this.centre.setY(pt0.getY());
		this.rayon = r;
		this.couleur = Color.blue;
	}


	/** E13 Construire un cercle à partir de deux points diamétralement opposés.
	 *  les deux points étant distincts.
	 * @param pt1 point1
	 * @param pt2 point2
	 * @pre pt1 != null
	 * @pre pt2 != null
	 */
	public Cercle(Point pt1, Point pt2) {
		this(pt1, pt2, Color.blue);
	}


	/** E14 Construire un cercle à partir de deux points diamétralement opposés
	 * et de sa couleur; les deux points étant distincts.
	 * @param pt1 point1
	 * @param pt2 point2
	 * @param col couleur
	 * @pre pt1 != null
	 * @pre pt2 != null
	 * @pre col != null
	 */
	public Cercle(Point pt1, Point pt2, Color col) {
		assert (pt2 != null);
		assert (pt1 != null);
		assert (col != null);
		assert (pt1.getX() != pt2.getX() || (pt1.getY() != pt2.getY()));
		System.out.println("CONSTRUCTEUR Cercle (" + pt1 + "," + pt2
		+ "," + col + ")");
		double r = pt1.distance(pt2) / 2;
		Point pt0 = new Point((pt1.getX() + pt2.getX()) / 2,
		(pt1.getY() + pt2.getY()) / 2);
		this.rayon = r;
		this.centre = pt0;
		this.couleur = col;
	}


	/** E1 Translater un cercle.
	 * @param dx deplacement selon l'axe des x
	 * @param dy deplacement selon l'axe des y
	 */
	 public void translater(double dx, double dy) {
		 this.centre.translater(dx, dy);
	 }


	/** E2 Obtenir le centre du cercle.
	 * @return centre du cercle
	 */
	 public Point getCentre() {
		 return new Point(this.centre.getX(), this.centre.getY());
	 }

	/** E3 Obtenir le rayon du cercle.
	 * @return rayon du cercle
	 */
	public double getRayon() {
		return this.rayon;
	}


	/** E4 Obtenir le diametre du cercle.
	 * @return diametre du cercle
	 */
	public double getDiametre() {
		return 2 * this.rayon;
	}


	/**E5  Verifie si un point se trouve a l'interieur du cercle.
	 * @param pt point à verifier
	 * @pre pt != null
	 * @return si contient
	 */
	public boolean contient(Point pt) {
		assert (pt != null);
		return (pt.distance(this.centre) <= this.rayon);
	}


	/** E6 Obtenir le perimetre du cercle.
	 * @return perimetre du cercle P = 2*Pi*r
	 */
	@Override
	public double perimetre() {
		return 2 * PI * this.rayon;
	}


	/** E6 Obtenir l'aire du cercle.
	 * @return aire du cercle A = 2*Pi*r^2
	 */
	@Override
	public double aire() {
		return PI * this.rayon * this.rayon;
	}


	/**E9 Obtenir la couleur du cercle.
	 * @return couleur du cercle
	 */
	public Color getCouleur() {
		return this.couleur;
	}


	/** E10 Modifier la couleur d'un cercle.
	 * @param col nouvelle couleur en anglais
	 * ecrit sous la forme Color.couleurenanglais
	 * @pre col != null
	 */
	public void setCouleur(Color col) {
		assert (col != null);
		this.couleur = col;
	}


	/** E16 Modifier le rayon d'un cercle.
	 * @param r nouveau rayon du cercle
	 * @pre r > 0
	 */
	public void setRayon(double r) {
		assert (r > 0);
		this.rayon = r;
	}


	/** E17 le diametre du cercle.
	 * @param d nouveau diametre du cercle
	 * @pre d > 0
	 */
	 public void setDiametre(double d) {
		 assert (d > 0);
		 this.rayon = d / 2;
	 }


	/** E14 Methode de creation de cercle.
	 * @param pt Centre du cercle
	 * @param pt2 Point quelconque de la circonference
	 * @return Cercle creer
	 * @pre pt != null
	 * @pre pt2 != null
	 */
	 public static Cercle creerCercle(Point pt, Point pt2) {
		 assert (pt2 != null);
		 assert (pt != null);
		 double r = pt.distance(pt2);
		 return new Cercle(pt, r);
	 }


	 /** E15 Afficher un cercle.
	  * @return l'affichage du cercle
	  */
	  public String toString() {
		  return "C" + this.rayon + "@" + this.centre;
	  }
}
