import java.io.*;

public class LifeTest {
	public static void main (String args[]) throws IOException {
		double fillRatio = 0.1;
		int size = 400;
		try {
			fillRatio = Double.parseDouble(args[0].trim());
		} catch (ArrayIndexOutOfBoundsException e) {
		}

		int rules[] = {0,1,2};
		
		//Life L = new Life(size, fillRatio, 2);
		Life L = new Life(size, fillRatio, rules, "0-100:1-100:2-100:1-100");

		LifeFrame F = new LifeFrame(L);
		F.pack();
		F.setVisible(true);

		PrintWriter P = new PrintWriter(new FileWriter("pop.dat"));	
		
		for (int i=0; i<4000; i++) {
			try {
				Thread.sleep(0);
			} catch (InterruptedException e) {}
			L.update();
			P.write(i + "\t" + L.getP() + "\n");
			F.update(L);
			//System.out.println(i);
		}
		P.close();
	}
}