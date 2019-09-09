package pioche;

import java.util.HashMap;
import java.util.Map;

import tuiles.BubbleCity;
import tuiles.CornerCityWithRoad;
import tuiles.StraightRoad;
import tuiles.ThreeWayIntersection;
import tuiles_spec.CreateurTuile;

public class DemoDeck extends PiocheAbstraite {
	
	private static final String DEMO_DECK_NAME = "Demo";

	@Override
	public Map<CreateurTuile, Integer> getConstructeurPion() {
		Map<CreateurTuile, Integer> demo = new HashMap<CreateurTuile, Integer>();
		demo.put(StraightRoad.getConstruction(), 5);
		demo.put(CornerCityWithRoad.getConstruction(), 5);
		demo.put(BubbleCity.getConstruction(), 20);
		demo.put(ThreeWayIntersection.getConstruction(), 5);
		return demo;
	}

	@Override
	public String toString() {
		return DEMO_DECK_NAME;
	}
}
