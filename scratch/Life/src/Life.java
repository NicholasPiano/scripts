import java.util.*;
import java.lang.Math;
import java.io.*;
import java.awt.*;
import java.awt.image.*;
import javax.imageio.*;

public class Life {
	private LifeRuleSet lifeRuleSet;
	private LifeCell[][] lifeCellArray;
	private int pop, size=800, gen=0;

	public Life (String imgfile) { //default
		setArrayFromImage(imgfile);
		this.lifeRuleSet = new LifeRuleSet("23/3"); //conway
	}
	public Life (String imgfile, String s) {
		setArrayFromImage(imgfile);
		this.lifeRuleSet = new LifeRuleSet(s);
	}
	public Life (String imgfile, int i) { //predef
		setArrayFromImage(imgfile);
		this.lifeRuleSet = new LifeRuleSet(i);
	}
	public Life (String imgfile, String s[], String l) {
		setArrayFromImage(imgfile);
		this.lifeRuleSet = new LifeRuleSet(s, l);
	}
	public Life (String imgfile, int i[], String l) { //predef
		setArrayFromImage(imgfile);
		this.lifeRuleSet = new LifeRuleSet(i, l);
	}
	public Life (double fillRatio) {
		setRandomArray(fillRatio);
		this.lifeRuleSet = new LifeRuleSet("23/3");
	}
	public Life (int size, double fillRatio) {
		this.size = size;
		setRandomArray(fillRatio);
		this.lifeRuleSet = new LifeRuleSet("23/3");
	}
	public Life (int size, double fillRatio, boolean multi) {
		this.size = size;
		setRandomArray(fillRatio);
		this.lifeRuleSet = new LifeRuleSet();
	}
	public Life (int size, double fillRatio, String s) {
		this.size = size;
		setRandomArray(fillRatio);
		this.lifeRuleSet = new LifeRuleSet(s);
	}
	public Life (int size, double fillRatio, String s[], String l) { //with iterator
		this.size = size;
		setRandomArray(fillRatio);
		this.lifeRuleSet = new LifeRuleSet(s, l);
	}
	public Life (int size, double fillRatio, int i[], String l) { //with iterator
		//System.out.println(l + " L");
		this.size = size;
		setRandomArray(fillRatio);
		this.lifeRuleSet = new LifeRuleSet(i, l);
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
		lifeCellArray = new LifeCell[x][y];
		//populate array, biasing black and white in binary
		for (int i=0; i<x; i++) {
			for (int j=0; j<y; j++) {
				Color C = new Color(img.getRGB(i, j));
				int r = C.getRed();
				int g = C.getGreen();
				int b = C.getBlue();
				if (r>127 && g>127 && b>127) {
					lifeCellArray[i][j] = new LifeCell(true, 0); //1 alive
				} else {
					lifeCellArray[i][j] = new LifeCell(false, 0); //0
				}
			}
		}
	}
	public void setRandomArray (double fillRatio) {
		lifeCellArray = new LifeCell[size][size];
		Random r = new Random();
		//populate array, biasing black and white in binary
		for (int i=0; i<size; i++) {
			for (int j=0; j<size; j++) {
				if (r.nextDouble() < fillRatio) {
					lifeCellArray[i][j] = new LifeCell(true, 0); //1 alive
				} else {
					lifeCellArray[i][j] = new LifeCell(false, 0); //0
				}
			}
		}	
	}
	public void update () {	
		this.pop = 0;
		Random r = new Random();
		LifeCell tempLifeCellArray[][] = new LifeCell[lifeCellArray.length][lifeCellArray[0].length];
		for (int i=0; i<lifeCellArray.length; i++) { //every element loops
			for (int j=0; j<lifeCellArray[0].length; j++) {
				int c = 0; //neighbors
				float prob = 0; //probability of switching to new rule
				tempLifeCellArray[i][j] = new LifeCell(false, 0);
				//get number of neighbors
				for (int m=i-1; m<i+2; m++) { //sub array loops
					for (int n=j-1; n<j+2; n++) {
						if (!(m==i && n==j)) {
							try {
								if (lifeCellArray[m][n].isAlive()) {
									c++;
									if (lifeCellArray[m][n].getRank() == 3) {
										prob += 0.01; //more likely if more neighbors are rank 5
									}
								}
							} catch (ArrayIndexOutOfBoundsException e) {}
						}
					}
				}
				//apply rule
				//System.out.println(lifeCellArray[i][j].getRank());
				if (lifeCellArray[i][j].getRank() == 3 || prob > r.nextFloat()) {
					lifeCellArray[i][j].setRank(3);
					if (lifeRuleSet.verdict(lifeCellArray[i][j].isAlive(), c, 1) /*|| (r.nextDouble()<0.02 && c>0)*/) {
						tempLifeCellArray[i][j].setAlive(!(lifeCellArray[i][j].isAlive())); //swap
					} else {
						tempLifeCellArray[i][j] = lifeCellArray[i][j];
					}
				} else {
					if (lifeRuleSet.verdict(lifeCellArray[i][j].isAlive(), c, 0) /*|| (r.nextDouble()<0.02 && c>0)*/) {
						tempLifeCellArray[i][j].setAlive(!(lifeCellArray[i][j].isAlive())); //swap
					} else {
						tempLifeCellArray[i][j] = lifeCellArray[i][j];
					}
				}
				//if alive increase rank and increment pop
				if (lifeCellArray[i][j].isAlive()) {
					if (lifeCellArray[i][j].getRank() != 3) { //stops at four levels
						lifeCellArray[i][j].setRank(lifeCellArray[i][j].getRank()+1);
					}
					this.pop++;
				} else {
					lifeCellArray[i][j].setRank(0);
				}
			}
		}
		this.lifeCellArray = tempLifeCellArray;
		this.gen++;
	}
	public LifeCell[][] getArray () {return lifeCellArray;}
	public int getP() {return pop;}
	public int getGen () {return gen;}
}