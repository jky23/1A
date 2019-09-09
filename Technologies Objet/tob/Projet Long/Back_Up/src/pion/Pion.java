package pion;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.imageio.ImageIO;

import joueur.Joueur;
import tuile_abstraites.TuileAbstraite;
import tuiles_spec.VueTuileAbstraite;

public class Pion {

	private final static String PATH_PION_ROUGE = "src/resources/Red_Meeple.png";
	private final static String PATH_PION_JAUNE = "src/resources/Yellow_Meeple.png";
	private final static String PATH_PION_VERT = "src/resources/Green_Meeple.png";
	private final static String PATH_PION_BLE = "src/resources/Blue_Meeple.png";
	private final static String PATH_PION_NOIR = "src/resources/Black_Meeple.png";
	private final static Map<Color, String> COULEURS = construireTableCouleur();		
	private Color couleur;
	private TuileAbstraite tuileAbstraite;
	private VueTuileAbstraite vueTuileAbstraite;
	private Joueur joueur;

	public enum Color {
		ROUGE, JAUNE, VERT, BLEU, NOIR;
	}
	
	public Pion(Color color, VueTuileAbstraite tile, TuileAbstraite object, Joueur player) {
		couleur = color;
		tuileAbstraite = object;
		tuileAbstraite.setPion(this);
		vueTuileAbstraite = tile;
		vueTuileAbstraite.setPion(this);
		joueur = player;
	}
	
	public Joueur getJoueur() {
		return joueur;
	}
	
	private static Map<Color, String> construireTableCouleur() {
		Map<Color, String> couleurs = new HashMap<Color, String>();
		couleurs.put(Color.ROUGE, PATH_PION_ROUGE);
		couleurs.put(Color.JAUNE, PATH_PION_JAUNE);
		couleurs.put(Color.VERT, PATH_PION_VERT);
		couleurs.put(Color.BLEU, PATH_PION_BLE);
		couleurs.put(Color.NOIR, PATH_PION_NOIR);
		return couleurs;	
	}
	
	public static BufferedImage getBufferedImage(Color couleur) {
		try {
			BufferedImage image = ImageIO.read(new File(COULEURS.get(couleur)));
			return image;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public  BufferedImage getBufferedImage() {
		try {
			BufferedImage image = ImageIO.read(new File(COULEURS.get(couleur)));
			return image;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static Color getCouleur(int playerID) {
		return (new ArrayList<Color>(COULEURS.keySet())).get(playerID - 1);
	}
	
	public TuileAbstraite getObject() {
		return tuileAbstraite;
	}
	
	public VueTuileAbstraite getTuile() {
		return vueTuileAbstraite;
	}
	
	public void retirer() {
		if (vueTuileAbstraite != null) {vueTuileAbstraite.retirerPion();}
		if (tuileAbstraite != null) {tuileAbstraite.retirerPion();}
	}
	
	public int getScore() {
		return tuileAbstraite.calculeScore(joueur);
	}
	
	public boolean estObjetComplet() {
		return tuileAbstraite.estComplete();
	}

}
