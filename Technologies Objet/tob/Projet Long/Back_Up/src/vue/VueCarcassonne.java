package vue;

import controleur.Controleur;
import joueur.VueJoueur;

import java.awt.BorderLayout;
import java.awt.Dimension;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.ImageIcon;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLayeredPane;
import javax.swing.JOptionPane;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import mouse_adapter.CarcassonneMouseAdapter;
import pioche.VuePioche;
import plateau.PlateauCarcassonne;

/** Classe de la vue du Jeu
 * 
 * @author jky
 *
 */
public class VueCarcassonne extends JFrame {
	private static final String TITRE = "Carcassonne";
	private static final String LOGO = "src/resources/Carcassone_Logo.png";
	private Controleur controleur;
	private CarcassonneMenuBarre barreMenu;
	private JButton passerTourBouton;
	private JButton validerBouton;
	private JButton tuileSuivanteBouton;
	
	/** Constructeur de la classe
	 * 
	 * @param nouveauControleur
	 */
	public VueCarcassonne(Controleur nouveauControleur) {
		setTitle(TITRE);
		setIconImage(new ImageIcon(LOGO).getImage()); 
		controleur = nouveauControleur;
		
		initialiserBarreMenu();
		initialiserAffichage();
		
		setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
		setVisible(true);
		pack();
		
		controleur.nouveauJeu();
	}
	/** Initialiser la barre de menu
	 * 
	 */
	public void initialiserBarreMenu() {
		barreMenu = new CarcassonneMenuBarre(controleur);
		setJMenuBar(barreMenu);
	}
	
	public void initialiserAffichage() {
		JLayeredPane layeredPane = new JLayeredPane();
		layeredPane.setLayout(new BorderLayout());
		
		layeredPane.add(getAffichageJoueur(), BorderLayout.NORTH);
		layeredPane.add(getAffichagePlateau(), BorderLayout.CENTER);
		layeredPane.add(getAffichageInf(), BorderLayout.SOUTH);
		
		CarcassonneMouseAdapter adapter = new CarcassonneMouseAdapter(controleur, layeredPane);
		layeredPane.addMouseListener(adapter);
		layeredPane.addMouseMotionListener(adapter);
		
		PlateauCarcassonne.getScrollAffichage().addMouseListener(adapter);
		PlateauCarcassonne.getScrollAffichage().addMouseMotionListener(adapter);
		
		add(layeredPane);
		controleur.nouveauJeu();	
		this.setPreferredSize(new Dimension(1250, 750));
	}
	/** Obtenir l'affichage d'un joueur
	 * 
	 * @return la vue joueur
	 */
	private JPanel getAffichageJoueur() {
		return VueJoueur.getVue();
	}
	
	/** Obtenir l'affichage du plateau
	 * 
	 * @return affichage plateau
	 */
	private JScrollPane getAffichagePlateau() {
		JScrollPane scrollPane = new JScrollPane(PlateauCarcassonne.getPlateau());		
		PlateauCarcassonne.setScrollAffichage(scrollPane);
		return scrollPane;
	}
	/** Obtenir la zone d'affichage inferieure
	 * 
	 * @return affichage inferieur
	 */
	private JPanel getAffichageInf() {
		JPanel panel = new JPanel();
		panel.setLayout(new BorderLayout());
		panel.add(getAffichagePioche(), BorderLayout.WEST);
		panel.add(getAffichageBouton(), BorderLayout.EAST);
		return panel;
	}
	/** Obtenir affichage de la pioche de tuiles
	 * 
	 * @return affichage tuiles
	 */
	private JPanel getAffichagePioche() {
		return VuePioche.getVue();
	}
	
	/** Obtenir la barre d'affichage des boutons
	 * 
	 * @return affichage boutons
	 */
	private JPanel getAffichageBouton() {
		JPanel panel = new JPanel();
		
		tuileSuivanteBouton = new JButton("Tuile Suivante");
		tuileSuivanteBouton.addActionListener(new ProchaineTuileAction());
		panel.add(tuileSuivanteBouton);
		
		passerTourBouton = new JButton("Passer");
		passerTourBouton.addActionListener(new PasserAction(this));
		panel.add(passerTourBouton);
		
		validerBouton = new JButton("Valider");
		validerBouton.addActionListener(new ValiderAction(this));
		panel.add(validerBouton);
		
		activerBoutons();
		return panel;
	}
	
	/** Activer les boutons
	 * 
	 */
	private void activerBoutons() {
		tuileSuivanteBouton.setEnabled(true);
		passerTourBouton.setEnabled(true);
		validerBouton.setEnabled(true);
	}
	/** Ecouter l'action sur le bouton Suivant
	 * 
	 * @author jky
	 *
	 */
	private class ProchaineTuileAction implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			if (!controleur.getTuileSuivante()) {
				JOptionPane.showMessageDialog(PlateauCarcassonne.getPlateau(), "Vous devez valider votre dernier jeu!", "Ce n'est pas votre tour", JOptionPane.PLAIN_MESSAGE);
			}
		}
	}
	/** Ecouter l'action sur le bouton Passer
	 * 
	 * @author jky
	 *
	 */
	private class PasserAction implements ActionListener {
		private VueCarcassonne myView;
		
		public PasserAction(VueCarcassonne view) {
			myView = view;
		}
		public void actionPerformed(ActionEvent e) {
			controleur.passerTour(myView);
		}
	}
	
	/** Ecouter l'action sur le bouton Valider
	 * 
	 * @author jky
	 *
	 */
	private class ValiderAction implements ActionListener {
		private VueCarcassonne vue;
		
		public ValiderAction(VueCarcassonne nouvelleVue) {
			vue = nouvelleVue;
		}
		
		public void actionPerformed(ActionEvent e) {
			if (!controleur.valider()) {
				JOptionPane.showMessageDialog(PlateauCarcassonne.getPlateau(), "Reessayez, Mouvement pas possible", "Mouvement non autorisé", JOptionPane.PLAIN_MESSAGE);
			}
			controleur.finduJeu(vue);
		}
	}
}
