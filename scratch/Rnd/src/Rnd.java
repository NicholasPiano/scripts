import java.util.*;
import java.lang.Math;

public class Rnd {
	public static void main(String args[]) {
		Random R = new Random();
		int a[][] = new int[200][200];

		for (int i=0; i<a.length; i++) {
			for (int j=0; j<a.length; j++) {
				if (i>20 && i<180 && j>20 && j<180) {
					if (R.nextDouble() > 0.4) {
						a[i][j] = 1;
					} else {
						a[i][j] = 0;
					}
				} else {
					if (R.nextDouble() > 0.6) {
						a[i][j] = 0;
					} else {
						a[i][j] = 0;
					}
				}
			}
		}

		RndFrame F = new RndFrame(a);
		F.pack();
		F.setVisible(true);
		
		try {
			Thread.sleep(50);
		} catch (InterruptedException e) {
		}
		
		for (int k=0; k<200; k++) { //generations
			int rule[] = new int[6];
			//rule = new int[]{3,3,3,3,2,3};
			//conway {3,3,3,3,2,3}
			///*
			if (k%3==0) {
				rule = new int[]{5,6,7,8,4,8}; //vote
			} else if (k%3==1) {
				rule = new int[]{4,4,4,4,0,8}; //4
			} else {
				rule = new int[]{5,5,5,5,0,8}; //5
			}//*/
			int b[][] = new int[a.length][a[0].length];
			for (int i=0; i<a.length; i++) { //every element loops
				for (int j=0; j<a[0].length; j++) {
					int c = 0;
					b[i][j] = 0;
					for (int m=i-1; m<i+2; m++) { //sub array loops
						for (int n=j-1; n<j+2; n++) {
							if (!(m==i && n==j)) {
								try {
									c += a[m][n];
								} catch (ArrayIndexOutOfBoundsException e) {}
							}
						}
					}
					if (a[i][j] == 0 && (c==rule[0] || c==rule[1] || c==rule[2] || c==rule[3])) {
						b[i][j] = 1;
					} else if (a[i][j] == 1 && c < rule[4] || c > rule[5]) {
						b[i][j] = 0;
					} else {
						b[i][j] = a[i][j];
					}
				}
			}
			try {
				Thread.sleep(50);
			} catch (InterruptedException e) {
			}
			a = b;
			F.update(a);
		}
	}
}