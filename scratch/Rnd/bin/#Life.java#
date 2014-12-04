import java.util.*;
import java.lang.Math;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import javax.imageio.*;

public class Life {
    public static void main(String args[]) throws IOException {

	Random R = new Random();

	//read in image from file
	BufferedImage img = null;
	try {
	    img = ImageIO.read(new File("IMG_0069.JPG"));
	} catch (IOException e) {
	}
	//get size of image
	int y = img.getHeight();
	int x = img.getWidth();
	System.out.println(x + " " + y);
	//make array
	int a[][] = new int[x][y];
	//populate array, biasing black and white in binary
	for (int i=0; i<x; i++) {
	    for (int j=0; j<y; j++) {
		Color C = new Color(img.getRGB(i, j));
		int r = C.getRed();
		int g = C.getGreen();
		int b = C.getBlue();
		if (r>127 && g>127 && b>127 && R.nextDouble()>0.4) {
		    a[i][j] = 1;
		} else {
		    a[i][j] = 0;
		}
	    }
	}

	LifeFrame F = new LifeFrame(a);
	F.pack();
	F.setVisible(true);
		
	try {
	    Thread.sleep(10);
	} catch (InterruptedException e) {
	}
		
	for (int k=0; k<100; k++) { //generations
	    int rule[] = new int[6];
	    //rule = new int[]{5,6,7,8,4,8};
	    //conway {3,3,3,3,2,3}
	    ///*
	    if (k%3==0 && k<100) {
		rule = new int[]{5,5,5,5,0,8}; //5
	    } else if (k%3==1 && k<100) {
		rule = new int[]{4,4,4,4,0,8}; //4
	    } else {
		rule = new int[]{5,6,7,8,4,8}; //vote
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
		Thread.sleep(100);
	    } catch (InterruptedException e) {
	    }
	    a = b;
	    F.update(a);
	}
    }
}