package allumettes;

import static org.junit.Assert.*;
import org.junit.*;

/** Test de la stratégie expert. */
public class TestExpert {
	 /** Stratégie à tester.*/
	private StrategieExpert strategy;

	@Before
	public void setUp() {
		this.strategy = new StrategieExpert();
	}

	@Test
	public void test1() {
		int prise = this.strategy.getPrise(new JeuAllumettes(12));
		int reste = 12 - prise;
		assertEquals(9, reste);
	}

	@Test
	public void test2() {
		int prise = this.strategy.getPrise(new JeuAllumettes(4));
		int reste = 4 - prise;
		assertEquals(1, reste);
	}

	@Test
	public void test3() {
		int prise = this.strategy.getPrise(new JeuAllumettes(3));
		int reste = 3 - prise;
		assertEquals(1, reste);
	}

	@Test
	public void test4() {
		int prise = this.strategy.getPrise(new JeuAllumettes(2));
		int reste = 2 - prise;
		assertEquals(1, reste);
	}

	@Test
	public void test5() {
		int prise = this.strategy.getPrise(new JeuAllumettes(1));
		int reste = 1 - prise;
		assertEquals(0, reste);
	}

	@Test
	public void test6() {
		int prise = this.strategy.getPrise(new JeuAllumettes(8));
		int reste = 8 - prise;
		assertEquals(5, reste);
	}
}
