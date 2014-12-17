import java.util.*;
import java.lang.Math;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import javax.imageio.*;

public class Life {
    private LifeRule R, Rs[];
    private int a[][];

    public Life (String imgfile) { //default
	setArrayFromImage(imgfile);
	this.R = new LifeRule("23/3"); //conway
    }
    public Life (String imgfile, LifeRule R) {
	setArrayFromImage(imgfile);
	this.R = R;
    }
    public Life (String imgfile, LifeRule Rs[]) {
	setArrayFromImage(imgfile);
	this.Rs = Rs;
    }    
    public Life (String imgfile, String s) {
	setArrayFromImage(imgfile);
	this.R = new LifeRule(s);
    }
    public Life (double tolerance) {
	setRandomArray(tolerance);
	this.R = new LifeRule("23/3");
    }
    public Life (double tolerance, LifeRule R) {
	setRandomArray(tolerance);
	this.R = R;
    }
    public Life (double tolerance, LifeRule Rs[]) {
	setRandomArray(tolerance);
	this.Rs = Rs;
    }
    public Life (double tolerance, String s) {
	setRandomArray(tolerance);
	this.R = new LifeRule(s);
    }
    public void setArrayFromImage (String fileName) {
	//read in image from file
	BufferedImage img = null;
	try {
	    img = ImageIO.read(new File(fileName));
	} catch (IOException e) {
	}
	//get size of image
	int y = img.getHeight();
	int x = img.getWidth();
	//make array
	a = new int[x][y];
	//populate array, biasing black and white in binary
	for (int i=0; i<x; i++) {
	    for (int j=0; j<y; j++) {
		Color C = new Color(img.getRGB(i, j));
		int r = C.getRed();
		int g = C.getGreen();
		int b = C.getBlue();
		if (r>127 && g>127 && b>127) {
		    a[i][j] = 1;
		} else {
		    a[i][j] = 0;
		}
	    }
	}
    }
    public void setRandomArray (double tolerance) {
	int size = 400;
	a = new int[size][size];
	Random r = new Random();
	//populate array, biasing black and white in binary
	for (int i=0; i<size; i++) {
	    for (int j=0; j<size; j++) {
		if (r.nextDouble() < tolerance) {
		    a[i][j] = 1;
		} else {
		    a[i][j] = 0;
		}
	    }
	}	
    }
    public void update () {
	LifeRule RCurrent = R;
	int b[][] = new int[a.length][a[0].length]; //temp
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
		if (RCurrent.verdict(a[i][j], c)) {
		    b[i][j] = 1 - a[i][j]; //swap
		} else {
		    b[i][j] = a[i][j];
		}
	    }
	}
	a = b;
    }
    public int[][] getArray () {
	return a;
    }
}