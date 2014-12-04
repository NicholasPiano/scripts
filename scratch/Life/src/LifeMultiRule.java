import java.io.*;

public class LifeMultiRule {
	public static void main (String[] args) throws IOException {
		double fillRatio = 0.2;
		int size = 400;
		try {
			fillRatio = Double.parseDouble(args[0].trim());
		} catch (ArrayIndexOutOfBoundsException e) {
		}
		
		//Life L = new Life(size, fillRatio, 2);
		//Life L = new Life(size, fillRatio, rules, "0-100:1-100:2-100:1-100");
		Life L = new Life(size, fillRatio, true);

		LifeFrame F = new LifeFrame(L);
		F.pack();
		F.setVisible(true);

		PrintWriter P = new PrintWriter(new FileWriter("pop.dat"));	
		
		for (int i=0; i<4000; i++) {
			//System.out.print(i);
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
