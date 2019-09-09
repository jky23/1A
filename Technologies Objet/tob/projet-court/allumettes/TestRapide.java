package allumettes;

import static org.junit.Assert.*;
import org.junit.*;

/** Test de la stratégie rapide. */
public class TestRapide {
	private StrategieRapide strategy; //Stratégie à tester

	@Before 
	public void setUp() {
		this.strategy = new StrategieRapide();
	}

	@Test
	public void test1() {
		for (int i = 3; i <= 13; i++) {
			assertEquals(3,this.strategy.getPrise(new JeuAllumettes(i)));
		}
	}
	
	@Test
	public void test2() {
		assertEquals(2,this.strategy.getPrise(new JeuAllumettes(2)));
	}
	
	@Test
	public void test3() {
		assertEquals(1,this.strategy.getPrise(new JeuAllumettes(1)));
	}
}
