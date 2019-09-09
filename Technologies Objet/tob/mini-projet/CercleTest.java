import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
 * Classe de test des exigences E12, E13, E14.
 * 
 * @author Joel Roman KY
 */

public class CercleTest {

	// précision pour les comparaisons réelle
	public final static double EPSILON = 0.001;

	// rayon du cercle
	public static final double R = 2.0;
	public static final double R1 = 5.0;

	// Les points du sujet
	private Point A, B, C, D, E, F, G;

	// Les cercles
	private Cercle C0, C1, C2, C3, C4, C5;

	@Before
	public void setPoint() {
		A = new Point(0, 0);
		B = new Point(2, 0);
		C = new Point(-2, 0);
		D = new Point(0, -2);
		E = new Point(0, 2);
		F = new Point(-3, 0);
		G = new Point(7, 0);

		C0 = new Cercle(A, R); // Cercle crée par E
		C1 = new Cercle(C, B); // Cercle crée par E12
		C2 = new Cercle(E, D, Color.red); // Cercle crée par E13
		C3 = Cercle.creerCercle(A, E); // Cercle crée par E14
		C4 = new Cercle(B, R1);
		C5 = new Cercle(F, G, Color.gray);
	}

	/**
	 * Vérifier si deux points ont mêmes coordonnées.
	 * 
	 * @param c1
	 *            le premier cercle
	 * @param c2
	 *            le deuxième cercle
	 */
	static void memesCercles(Cercle c1, Cercle c2) {
		SujetCercleTest.memesCoordonnees("meme centre", c1.getCentre(), c2.getCentre());
		assertEquals(c1.getRayon(), c2.getRayon(), EPSILON);
	}

	@Test
	public void testerE12() {
		memesCercles(C0, C1);
		assertEquals(C0.getCouleur(), C1.getCouleur());
		C0.translater(1, 1);
		C1.translater(1, 1);
		memesCercles(C0, C1);
		C1.setCouleur(Color.black);
		assertFalse(C0.getCouleur() == C1.getCouleur());
	}

	@Test
	public void testerE13() {
		memesCercles(C0, C2);
		assertEquals(C2.getCouleur(), Color.red);
		C0.translater(-4, 2);
		C2.translater(-4, 2);
		memesCercles(C0, C2);
		C2.setCouleur(Color.yellow);
		assertFalse(C0.getCouleur() == C2.getCouleur());
		memesCercles(C4, C5);
		C4.setCouleur(Color.gray);
		assertEquals(C4.getCouleur(), Color.gray);
	}

	@Test
	public void testerE14() {
		memesCercles(C0, C3);
		assertEquals(C0.getCouleur(), C3.getCouleur());
		C0.translater(2.5, 1);
		C3.translater(2.5, 1);
		memesCercles(C0, C3);
		C3.setCouleur(Color.green);
		assertFalse(C0.getCouleur() == C3.getCouleur());
	}

}
