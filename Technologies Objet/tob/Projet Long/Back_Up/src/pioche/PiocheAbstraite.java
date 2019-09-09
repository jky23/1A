package pioche;

import java.util.Map;

import tuiles_spec.CreateurTuile;

public abstract class PiocheAbstraite {
	
	public abstract Map<CreateurTuile, Integer> getConstructeurPion();
	public abstract String toString();

}
