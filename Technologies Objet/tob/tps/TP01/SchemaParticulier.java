/** Programme schema particulier
 *author Joel Roman Ky
**/

public class SchemaParticulier {
	
	public static void main(String[] args) {
		//Creer trois points
		Point p1 = new Point(3.0,2.0);
		Point p2 = new Point(6.0,9.0);
		Point p3 = new Point(11.0,4.0);
		
		//Construire trois segments a partir de ces trois points
		Segment s12 = new Segment(p1,p2);
		Segment s23 = new Segment(p2,p3);
		Segment s31 = new Segment(p3,p1);
		
		//Determiner le barycentre des trois points
		double barx = (p1.getX() + p2.getX() + p3.getX())/3;
		double bary = (p1.getY() + p2.getY() + p3.getY())/3;
		Point bar = new Point(barx,bary);
		
		//Afficher le  schema
		s12.afficher(); s23.afficher(); s31.afficher(); bar.afficher();
	}
}
