package tuiles_spec;

import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;
import java.awt.geom.AffineTransform;
import java.awt.geom.Point2D;
import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.awt.image.BufferedImageOp;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.imageio.ImageIO;
import javax.swing.ImageIcon;
import javax.swing.JLabel;

import controleur.Controleur;
import pion.Pion;
import tuile_abstraites.Champs;
import tuile_abstraites.Route;
import tuile_abstraites.TuileAbstraite;

@SuppressWarnings("serial")
public abstract class VueTuileAbstraite extends JLabel {
	
	public static final int LARGEUR_TUILE = 80;
	public static final int HAUTEUR_TUILE = 80;
	private static final float ROTATION_ANGLE = 90;
	private Rotation[] myRotation = {Rotation.NORTH, Rotation.EAST, Rotation.SOUTH, Rotation.WEST};
	private List<TuileAbstraite> myObjects;
	private boolean showMeeplePlacement = false;
	private boolean isDNDEnabled = false;
	private BufferedImage myImage;
	private Pion myMeeple;
	private String myName;
	private int myRow;
	private int myCol;
	
	public enum Rotation {
		NORTH, EAST, SOUTH, WEST
	}
	
	public VueTuileAbstraite(String image_path, int row, int col) {
		super(new ImageIcon(image_path));
		lireImage(image_path);
		decoupeNom(image_path);
		setCaseEmplacement(row, col);
		myObjects = construireObjetListe();
	}
	
	protected VueTuileAbstraite() {}
	
	public abstract List<TuileAbstraite> construireObjetListe();
	public abstract VueTuileAbstraite construireTuile(int row, int col);
	
	private void lireImage(String image_path) {
		try {
			myImage = ImageIO.read(new File(image_path));
		} catch (IOException e) {e.printStackTrace();}
	}
	
	private void decoupeNom(String image_path) {
		myName = image_path.split("/")[2].split("\\.")[0];
	}
	
	public List<TuileAbstraite> getObjects() {
		return myObjects;
	}
	
	public void montrerPlacementPion(boolean isShown) {
		showMeeplePlacement = isShown;
		revalidate();
		repaint(); //required
	}
	
	public void setPion(Pion meeple) {
		myMeeple = meeple;
		revalidate();
		repaint(); //required
	}
	
	public Pion getPion() {
		return myMeeple;
	}
	
	public void retirerPion() {
		myMeeple = null;
		revalidate();
		repaint(); //required
		
	}
	
	public void setCaseEmplacement(int row, int col) {
		myRow = row;
		myCol = col;
	}
	
	public int getLigne() {
		return myRow;
	}
	
	public int getColonnes() {
		return myCol;
	}
	
	public void activerDND(boolean isEnabled) {
		isDNDEnabled = isEnabled;
	}
	
	public boolean esDNDActive() {
		return isDNDEnabled;
	}
	
	public List<Point> getPionPoints() {
		List<Point> meeple_points = new ArrayList<Point>();
		for (TuileAbstraite object : myObjects) {
			meeple_points.add(rotatePoint(object.getPionPlacement(), false));
		}
		return meeple_points;
	}
	
	public void rotate() {
		Rotation[] copy = {myRotation[0], myRotation[1], myRotation[2], myRotation[3]};
		for (int i = 0; i < myRotation.length; i++) {
			myRotation[i] = copy[(i + 3) % 4];
		}
		myImage = rotateImage(ROTATION_ANGLE);
		setIcon(new ImageIcon(myImage));
	}
	
	private BufferedImage rotateImage(float angle) {
		AffineTransform transform = new AffineTransform();
		transform.rotate(Math.toRadians(angle), myImage.getWidth() / 2.0, myImage.getHeight() / 2.0);
		transform.preConcatenate(trouverTranslation(transform, angle));
		BufferedImageOp op = new AffineTransformOp(transform, AffineTransformOp.TYPE_NEAREST_NEIGHBOR);
		return op.filter(myImage, null);
	}
	
	private AffineTransform trouverTranslation(AffineTransform transform, float angle) {
		Point2D point_in = null, point_out = null;
		if (angle > 0 && angle <= 90) {point_in = new Point2D.Double(0,0);}
		else if (angle >= 270 && angle < 360) {point_in = new Point2D.Double(myImage.getWidth(), 0);}
		point_out = transform.transform(point_in, null);
		double  ytrans = point_out.getY();
		if (angle > 0 && angle <= 90) {point_in = new Point2D.Double(0, myImage.getHeight());}
		else if (angle >= 270 && angle < 360) {point_in = new Point2D.Double(0,0);}
		point_out = transform.transform(point_in,  null);
		double xtrans = point_out.getX();
		AffineTransform tat = new AffineTransform();
		tat.translate(-xtrans, -ytrans);
		return tat;
	}
	
	public void majAllConnexions(List<VueTuileAbstraite> tiles) {
		for (VueTuileAbstraite tile : tiles) {
			Rotation other_side = getCoteCorrespondant(tile);
			if (other_side == null) {continue;}
			Rotation my_side = getCoteOppose(other_side);
			other_side = tile.getCoteRotate(other_side);
			my_side = getCoteRotate(my_side);
			
			for (TuileAbstraite object : myObjects) {
				if (!object.contientCote(my_side)) {continue;}
				for (TuileAbstraite other_object : tile.getObjects()) {
					if (!other_object.contientCote(other_side)) {continue;}
						object.connect(my_side, other_side, other_object);
						other_object.connect(other_side, my_side, object);
				}
			}
		}
	}
	
	/*
	 * Check to see if tiles current placement is valid. Surrounding_tiles should
	 * be a list of all tiles adjacent to this tile (i.e. north, east, south, west) of
	 * this tile that are non-empty.
	 */
	public boolean validerMouvement(List<VueTuileAbstraite> surrounding_tiles) {
		if (surrounding_tiles.isEmpty()) {return false;} //all surrounding tiles do not contain non-empty tiles
		for (VueTuileAbstraite other : surrounding_tiles) {
			if (!validateMove(other)) {return false;}
		}
		return true;
	}
	
	private boolean validateMove(VueTuileAbstraite other) {
		Rotation other_side = getCoteCorrespondant(other);
		Rotation my_side = getCoteOppose(other_side);
		other_side = other.getCoteRotate(other_side);
		my_side = getCoteRotate(my_side);
		return other.matchHash(other_side) == matchHash(my_side) && validePionPosition(my_side, other_side, other.getObjects());
	}
	
	
	private boolean validePionPosition(Rotation my_rotation, Rotation other_rotation, List<TuileAbstraite> connected) {
		if (myMeeple == null) {return true;}
		for (TuileAbstraite object : connected) {
			if (myMeeple.getObject().validateConnection(my_rotation, other_rotation, object)) {
				if (object.connectedObjetsOccupe()) {return false;} 
			}
		}
		return true;
	}
	
	
	private int matchHash(Rotation side) {
		final int prime = 2;
		int num_roads = 0;
		int num_cities = 0;
		int num_farms = 0;
		
		for (TuileAbstraite object : myObjects) {
			if (!object.contientCote(side)) {continue;}
			if (object instanceof Route) {num_roads++;}
			else if (object instanceof Champs) {num_farms++;}
			else {num_cities++;}
		}
		
		return ((prime * 1 + num_roads) * prime + num_farms) * prime + num_cities;
	}
	
	private Rotation getCoteOppose(Rotation side) {
		Rotation[] rotations = {Rotation.NORTH, Rotation.EAST, Rotation.SOUTH, Rotation.WEST};
		int index = Arrays.asList(rotations).indexOf(side);
		return rotations[(index + 2) % 4];
	}
	
	private Rotation getCoteRotate(Rotation side) {
		Rotation[] rotations = {Rotation.NORTH, Rotation.EAST, Rotation.SOUTH, Rotation.WEST};
		int index = Arrays.asList(rotations).indexOf(side);
		return myRotation[index];
	}
	
	//return other tile's matching side, doesnt account for other tile's rotations
	private Rotation getCoteCorrespondant(VueTuileAbstraite tile) {
		if (tile.getLigne() == myRow - 1) {return Rotation.SOUTH;}
		else if (tile.getLigne() == myRow + 1) {return Rotation.NORTH;}
		else if (tile.getColonnes() == myCol - 1) {return Rotation.EAST;}
		else if (tile.getColonnes() == myCol + 1) {return Rotation.WEST;}
		return null;
	}
	
	@Override
	public String toString() {
		return myName;
	}
	
	@Override
	protected void paintComponent(Graphics g) {
		super.paintComponent(g);
			
		if (showMeeplePlacement) {
			g.setColor(Color.RED);
			for (Point point : getPionPoints()) {
				g.fillOval(point.x - 4, point.y - 4, 8, 8);
			}
		}
		
		if (myMeeple != null) {
			int x = myMeeple.getObject().getPionPlacement().x;
            int y = myMeeple.getObject().getPionPlacement().y;
            Point p = new Point();
            p.setLocation(x, y);
            p = rotatePoint(p, false);
            g.drawImage(myMeeple.getBufferedImage(), p.x - myMeeple.getBufferedImage().getWidth() / 2, p.y - myMeeple.getBufferedImage().getHeight() / 2, this);
            if (!showMeeplePlacement && Controleur.estMontrerPionScore()) {
            	g.drawString(Integer.toString(myMeeple.getScore()), x, y);
            }
		}
	}
	
	/*
	public void debug() {
		System.out.println("\n \n \n debug");
		for (AbstractTileObject object : myObjects) {
			System.out.println(object.toString() + ": " + object.calculateScore());
		}
	} */

	public boolean aPion(Point point) {
		if (myMeeple == null) {return false;}
		return myMeeple.getObject().getPionPlacement().equals(rotatePoint(point, true));
	}

	public boolean montrePionPlacement() {
		return showMeeplePlacement;
	}

	public TuileAbstraite getObjectAt(Point point) {
		
		for (TuileAbstraite object : myObjects) {
			if (object.getPionPlacement().equals(rotatePoint(point, true))) {
				return object;
			}
		}
		return null;
	}
	
	private int getNombreRotations() {
		 return Arrays.asList(myRotation).indexOf(Rotation.NORTH);
	}
	
	
	private Point rotatePoint(Point point, boolean unrotate) {
		int numRotations = getNombreRotations();
		if (unrotate) {numRotations = 4 - getNombreRotations();}
		
		double radians = Math.toRadians(90 * numRotations);
		double x = point.x;
		double y= point.y;
		
		x = x - LARGEUR_TUILE / 2.0;
		y = y - HAUTEUR_TUILE / 2.0;
		
		double xPrime= Math.cos(radians) * x - Math.sin(radians) * y + LARGEUR_TUILE / 2.0;
		double yPrime = Math.sin(radians) * x + Math.cos(radians) * y + HAUTEUR_TUILE / 2.0;
		
		Point rotated = new Point();
		rotated.setLocation(xPrime, yPrime);
		return rotated;
		
		
	}
}
