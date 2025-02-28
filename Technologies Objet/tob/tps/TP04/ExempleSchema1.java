import afficheur.Ecran;
import afficheur.AfficheurSVG;
/** Construire le schéma proposé dans le sujet de TP avec des points,
  * et des segments.
  *
  * @author	Xavier Crégut
  * @version	$Revision: 1.7 $
  */
public class ExempleSchema1 {

	/** Construire le schéma et le manipuler.
	  * Le schéma est affiché.
	  * @param args les arguments de la ligne de commande
	  */
	public static void main(String[] args)
	{
		// Créer les trois segments
		Point p1 = new Point(3, 2);
		Point p2 = new Point(6, 9);
		Point p3 = new Point(11, 4);
		Segment s12 = new Segment(p1, p2);
		Segment s23 = new Segment(p2, p3);
		Segment s31 = new Segment(p3, p1);

		// Créer le barycentre
		double sx = p1.getX() + p2.getX() + p3.getX();
		double sy = p1.getY() + p2.getY() + p3.getY();
		Point barycentre = new Point(sx / 3, sy / 3);

		// Afficher le schéma
		System.out.println("Le schéma est composé de : ");
		s12.afficher();		System.out.println();
		s23.afficher();		System.out.println();
		s31.afficher();		System.out.println();
		barycentre.afficher();	System.out.println();
		
		//Afficher le schema graphiquement
		Ecran E = new Ecran("ExempleSchema1", 600, 400, 20);
		E.dessinerAxes();
		s12.dessiner(E, s12.getCouleur());
		s23.dessiner(E, s23.getCouleur());
		s31.dessiner(E, s31.getCouleur());
		barycentre.dessiner(E, barycentre.getCouleur());
		
		//Translater le schema de (4, -3)
		s12.translater(4, -3);
		s23.translater(4, -3);
		s31.translater(4, -3);
		barycentre.translater(4, -3);
		
		//Afficher le schema
		s12.dessiner(E, s12.getCouleur());
		s23.dessiner(E, s23.getCouleur());
		s31.dessiner(E, s31.getCouleur());
		barycentre.dessiner(E, barycentre.getCouleur());
		
		//Afficher avec l'afficheur SVG
		AfficheurSVG E1 = new AfficheurSVG();
		E1.dessinerLigne(p1.getX(), p1.getY(), p2.getX(), p2.getY(), s12.getCouleur());
		E1.dessinerLigne(p2.getX(), p2.getY(), p3.getX(), p3.getY(), s23.getCouleur());
		E1.dessinerLigne(p3.getX(), p3.getY(), p1.getX(), p1.getY(), s31.getCouleur());
		E1.dessinerPoint(barycentre.getX(), barycentre.getY(), barycentre.getCouleur());
		E1.ecrire();
		E1.ecrire("schema.svg");
		
	}

}
