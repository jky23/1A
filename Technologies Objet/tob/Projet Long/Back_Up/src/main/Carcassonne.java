package main;

import controleur.Controleur;
import vue.VueCarcassonne;

public class Carcassonne {
	public static final String TITRE = "Carcassonne";

	@SuppressWarnings("unused")
	public static void main (String[] args) {
		Controleur controleur = new Controleur();
		VueCarcassonne vueJeu = new VueCarcassonne(controleur);  
	}
}

