import java.awt.Color;
/** Definir un afficheur sous une forme textuelle qui permet de comprendre 
 * facilement la nature des objets.
 */

public class AfficheurTexte implements afficheur.Afficheur {

	@Override
	public void dessinerCercle(double x, double y, double rayon, Color c) {
		System.out.println("Cercle {");
		System.out.println("       centre_x = " +x);
		System.out.println("       centre_y = " +y);
		System.out.println("       rayon = " +rayon);
		System.out.println("       couleur = " +c);
		System.out.println("}");
	}

	@Override
	public void dessinerLigne(double x1, double y1, double x2, double y2, Color c) {
		System.out.println("Ligne {");
		System.out.println("      centre_x = " +x1);
		System.out.println("      centre_y = " +y1);
		System.out.println("      centre_x = " +x2);
		System.out.println("      centre_y = " +y2);
		System.out.println("      couleur = " +c);
		System.out.println("}");
	}

	@Override
	public void dessinerPoint(double x, double y, Color c) {
		System.out.println("Point {");
		System.out.println("      centre_x = " +x);
		System.out.println("      centre_y = " +y);
		System.out.println("      couleur = " +c);
		System.out.println("}");
	}

	@Override
	public void dessinerTexte(double x, double y, String texte, Color c) {
		System.out.println("Texte {");
		System.out.println("      centre_y = " +y);
		System.out.println("      valeur = " +texte);
		System.out.println("      couleur = " +c);
		System.out.println("}");
	}
	
	
}