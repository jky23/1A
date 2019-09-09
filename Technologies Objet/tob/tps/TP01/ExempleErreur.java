/** Une erreur à la compilation !
  * Pourquoi ?
  * @author	Xavier Crégut
  * @version	1.3
  */
public class ExempleErreur {

	/** Méthode principale */
	public static void main(String[] args) {
		Point p1 = new Point(0,0);
		p1.setX(1);
		p1.setY(2);
		p1.afficher();
		System.out.println();
	}
// le compilateur refuse la creation parce que la signature du constructeur n'est pas respectée.Cela permet d'eviter les erreurs d'appel pour les 
// constructeurs ayant le meme nom que celui de la classe mais une signature differente
}
