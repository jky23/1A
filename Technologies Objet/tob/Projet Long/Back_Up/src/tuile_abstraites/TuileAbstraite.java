package tuile_abstraites;

import java.awt.Point;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import joueur.Joueur;
import pion.Pion;
import tuiles_spec.VueTuileAbstraite;

public abstract class TuileAbstraite {
	
	private Map<VueTuileAbstraite.Rotation, List<Position>> maPosition;
	private List<TuileAbstraite> mesObjetsConnectes;
	private Pion monPion;
	private Point monEmplacementPion;
	
	/*				   NORTH
	 * 		      Left Center Right 
	 * 				 ____________
	 * 		Right  |			 | Left
	 * WEST Center |	TILE	 | Center EAST
	 * 	    Left   |			 | Right
	 * 			   |_____________|
	 * 			  Right Center Left
	 *            		SOUTH
	 * 
	 */
	public enum Position {
		GAUCHE, CENTRE, DROITE;
	}
	
	public TuileAbstraite(Map<VueTuileAbstraite.Rotation, List<Position>> position, Point emplacementPion) {
		maPosition = position;
		mesObjetsConnectes = new ArrayList<TuileAbstraite>();
		monEmplacementPion = emplacementPion;
	}
	
	public abstract boolean estMemeObjet(TuileAbstraite autresTuiles);
	public abstract int calculeScore(Joueur joueur);
	public abstract String toString();
	
	public boolean estComplete() {
		List<TuileAbstraite> connections = traverseConnections();
		for (TuileAbstraite objet : connections) {
			if (!objet.estFerme()) {return false;}
		}
		return true;
	}
	
	private boolean estFerme() {
		return maPosition.size() == mesObjetsConnectes.size();
	}
	public void setPion(Pion pion) {
		monPion = pion;
	}
	
	public void retirerPion() {
		monPion = null;
	}
	
	public boolean aPion() {
		return monPion != null;
	}
	
	public Point getPionPlacement() {
		return monEmplacementPion;
	}
	
	public boolean connectedObjetsOccupe() {
		List<TuileAbstraite> connections = traverseConnections();
		for (TuileAbstraite connection : connections) {
			if (connection.aPion()) {
				return true;
			}
		}
		return false;
	}
	
	/*
	 * Traverses the linked list of tile object nodes and returns the connected tile objects as 
	 * a list so that the score for these connected objects can be more easily calculated. 
	 * Visited is a list of visited tile object so that we do not traverse the same object twice.
	 */
	
	protected List<TuileAbstraite> traverseConnections() {
		return new ArrayList<TuileAbstraite>(traverseConnections(new HashSet<TuileAbstraite>()));
	}
	
	private Set<TuileAbstraite> traverseConnections(Set<TuileAbstraite> visite) {
		if (!visite.contains(this)) {visite.add(this);}
		for (TuileAbstraite object : mesObjetsConnectes) {
			if (visite.contains(object)) {continue;}
			visite.addAll(object.traverseConnections(visite));
		}
		return visite;
	}
	
	/*
	 * Rotation is the "rotated" side of the tile we are connecting to the other tile and other_rotation is the
	 * "rotated" side of the tile we are connecting to. Other is the tile that we are connecting to. 
	 * An example of a "rotated" side is if a tile is rotated 90 degrees clockwise, then its "rotated" northern side is WEST.
	 */
	public boolean connect(VueTuileAbstraite.Rotation rotation, VueTuileAbstraite.Rotation autresRotations, TuileAbstraite autreTuiles) {
		if (!validateConnection(rotation, autresRotations, autreTuiles)) {return false;}
		mesObjetsConnectes.add(autreTuiles);
		return true;
	}
	
	public boolean validateConnection(VueTuileAbstraite.Rotation rotation, VueTuileAbstraite.Rotation autresRotations, TuileAbstraite autresTuiles) {
		if (!estMemeObjet(autresTuiles) || !contientCote(rotation) || !autresTuiles.contientCote(autresRotations)) {return false;}
		List<Position> position = getPositionPourCote(rotation);
		List<Position> other_position = autresTuiles.getPositionPourCote(autresRotations);		
		if (!((position.contains(Position.CENTRE) && other_position.contains(Position.CENTRE))
			|| (position.contains(Position.GAUCHE) && other_position.contains(Position.DROITE)) 
			|| (position.contains(Position.DROITE) && other_position.contains(Position.GAUCHE)))) {return false;}
		return true;		
	}
	
	public boolean contientCote(VueTuileAbstraite.Rotation cote) {
		return maPosition.containsKey(cote);
	}
	
	private List<Position> getPositionPourCote(VueTuileAbstraite.Rotation cote) {
		return maPosition.get(cote);
	}

	private Pion getPion() {
		return monPion;
	}
	
	protected List<Joueur> getJoueurMaxPions(List<TuileAbstraite> connections) {
		Map<Joueur, Integer> pionsParJoueur = new HashMap<Joueur, Integer>();
		
		for (TuileAbstraite objet : connections) {
			if (!objet.aPion()) {continue;}
			Pion pion = objet.getPion();
			Joueur player = pion.getJoueur();
			if (!pionsParJoueur.containsKey(player)) {
				pionsParJoueur.put(player, 0);
			}
			pionsParJoueur.put(player, pionsParJoueur.get(player) + 1);
		}
		
		int maxPions = 0;
		List<Joueur> joueurs = new ArrayList<Joueur>();
		
		for (Joueur joueur : pionsParJoueur.keySet()) {
			if (pionsParJoueur.get(joueur) == maxPions) {
				joueurs.add(joueur);
			}
			else if (pionsParJoueur.get(joueur) >= maxPions) {
				joueurs = new ArrayList<Joueur>();
				joueurs.add(joueur);
				maxPions = pionsParJoueur.get(joueur);
			}
		}
		return joueurs;
	}



}
