import java.awt.*;
import java.awt.event.*;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import javax.swing.*;

public class Density {
	//takes in FrameSet
	//get list of all colors that occur in all frames
	//loops through frames to count the number of times a pixel of a certain color is next to every other color.
	//sort lists by number of occurrences
	//print to csv file
	
	private FrameSet frameSet;
	private ArrayList<Color> allColors;
	private float neighbors[][];
	
	public Density (FrameSet frameSet) {
		this.frameSet = frameSet;
		setAllColors();
	}
	public void setAllColors() {
		//arraylist to store results
		Frame frameArray[] = frameSet.getFrames();
		ArrayList<Color> allColors = new ArrayList<Color>();
		for (int i=0; i<frameArray.length; i++) { //loop over all frames
			Color listOfColors[] = frameArray[i].getColorArray();
			for (int j=0; j<listOfColors.length; j++) {
				if (allColors.indexOf(listOfColors[j])==-1) { //if color is not in the arraylist
					allColors.add(listOfColors[j]);
				}
			}
		}
	}
	public ArrayList<Color> getAllColors() {
		return allColors;
	}
	public void setNeighbors() {
		//pass 9 cell mask over color array of each frame
		for (int i=0; i<; i++) { //i and j for color map of frame
			for (int j=0; j<; j++) {
				for (int k=i-1; k<i+2; k++) { //k and l for mask
					for (int l=i-1; l<j+2; l++) {
						//one counter for each frame
						//another counter for over all
					}
				}
			}
		}
		//
	}
	public void printNeighbors(String filename) {
		//open file and print in csv format
		//also print to matlab 3d graph format
	}
	public float[][] getNeighbors() {
		return neighbors;
	}
}

class DensityFrame {
	
}

class DensityPanel {
	
}