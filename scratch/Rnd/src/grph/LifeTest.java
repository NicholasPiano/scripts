public class LifeTest {
    public static void main (String args[]) {
	double tolerance = 0;
	try {
	    tolerance = Double.parseDouble(args[0].trim());
	} catch (ArrayIndexOutOfBoundsException e) {
	}

	Life L = new Life(tolerance, "45678/5678");
	
	LifeFrame F = new LifeFrame(L);
	F.pack();
	F.setVisible(true);
	
	for (int i=0; i<1; i++) {
	    System.out.println(i);
	    L.update();
	    F.update(L);
	    try {
		Thread.sleep(1000);
	    } catch (InterruptedException e) {	
	    }
	}
    }
}