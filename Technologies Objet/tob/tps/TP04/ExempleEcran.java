import java.awt.Color;
import afficheur.Ecran;
/** Definir un ecran de dimension 400x250 avec une unite de 15 pixels.
 * 
 * @author Joel Roman Ky
 *
 */

public class ExempleEcran {
	public static void main(String[] args) {
		// Construire l'ecran
		Ecran E = new Ecran("Exemple Ecran", 400, 250, 15);
		
		// Dessiner les axes
		E.dessinerAxes();
		
		// Dessiner un point de couleur verte
		E.dessinerPoint(1, 2, Color.green);
		
		//Dessiner un segment de couleur rouge
		E.dessinerLigne(6, 2, 11, 9, Color.red);
		
		//Dessiner un cercle jaune
		E.dessinerCercle(4, 4, 2.5, Color.yellow);
		
		//Dessiner un texte
		E.dessinerTexte(1, -2, "Premier dessin", Color.blue);
		
	}
}
