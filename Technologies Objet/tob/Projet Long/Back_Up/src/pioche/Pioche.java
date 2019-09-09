package pioche;

import java.util.HashMap;
import java.util.Map;

import tuiles.*;
import tuiles_spec.CreateurTuile;

/** Creation de la base de données de tuiles
 * 
 * @author jky
 *
 */
public class Pioche extends PiocheAbstraite {
	private static final String NOM_DECK = "Standard";
	
	@Override 
	public Map<CreateurTuile, Integer> getConstructeurPion() {
		Map<CreateurTuile, Integer> standard = new HashMap<CreateurTuile,Integer>();
		standard.put(FullCity.getConstruction(), 1);
		standard.put(GateCity.getConstruction(), 3);
		standard.put(GateCityWithShield.getConstruction(), 1);
		standard.put(Gatehouse.getConstruction(), 1);
		standard.put(GatehouseWithShield.getConstruction(), 2);
		standard.put(CornerCity.getConstruction(), 3);
		standard.put(CornerCityWithShield.getConstruction(), 2);
		standard.put(CornerCityWithRoad.getConstruction(), 3);
		standard.put(CornerCityWithRoadAndShield.getConstruction(), 2);
		standard.put(BridgeCity.getConstruction(), 1);
		standard.put(BridgeCityWithShield.getConstruction(), 2);
		standard.put(ButtCity.getConstruction(), 2);
		standard.put(DoubleBubbleCity.getConstruction(), 3);
		standard.put(BubbleCity.getConstruction(), 5);
		standard.put(BubbleCityWithCurvedRoadOne.getConstruction(), 3);
		standard.put(BubbleCityWithCurvedRoadTwo.getConstruction(), 3);
		standard.put(BubbleCityWithThreeWayIntersection.getConstruction(), 3);
		standard.put(BubbleCityWithStraightRoad.getConstruction(), 3);
		standard.put(StraightRoad.getConstruction(), 8);
		standard.put(CurvedRoad.getConstruction(), 9);
		standard.put(ThreeWayIntersection.getConstruction(), 4);
		standard.put(FourWayIntersection.getConstruction(), 1);
		standard.put(MonasteryTile.getConstruction(), 4);
		standard.put(MonasteryTileWithRoad.getConstruction(), 2);
		return standard;
	}

	@Override
	public String toString() {
		return NOM_DECK;
	}
}
