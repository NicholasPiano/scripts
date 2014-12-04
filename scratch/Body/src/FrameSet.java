import java.awt.Color;
import java.io.*;
import java.util.Arrays;
import java.util.HashMap;
import java.util.TreeMap;

public class FrameSet {
	private Frame frames[];
	private Color[] mostCommonColors;
	private int[] mostCommonColorFrequency;
	private int mostCommonNumber;
	
	public FrameSet (String directory) throws IOException {
		setFrameSetFromDirectory(directory);
		setMostCommonNumber(15);
		setMostCommonColors();
	}
	
	public void setFrameSetFromDirectory (String dirName) throws IOException {
		File directory = new File(dirName);
		Frame FramesTemp[];
		if (directory.isDirectory()) {
			//System.out.println(directory.listFiles());
			File dir[] = directory.listFiles();
			FramesTemp = new Frame[dir.length];
			for (int i=0; i<dir.length; i++) {
				//System.out.println(dir[i].getName());
				FramesTemp[i] = new Frame(dir[i]);
			}
		} else {
			throw new IOException("This is not the directory you were looking for.");
		}
		//System.out.println("FrameSet " + directory.listFiles().length);
		setFrames(FramesTemp);
	}
	
	public Color[] getMostCommonColors () {
		return mostCommonColors;
	}
	public void setMostCommonColors () {
		//build dictionary of top colors
		HashMap<Color,Integer> records = new HashMap<Color,Integer>();
        ValueComparator bvc =  new ValueComparator(records);
        TreeMap<Color,Integer> sortedMap = new TreeMap<Color,Integer>(bvc);
		for (int i=0; i<frames.length; i++) {
			Color[] FrameColors = frames[i].getTop();
			for (int j=0; j<FrameColors.length; j++) {
				if (!FrameColors[j].equals(new Color(0,0,0))) {
					if (records.containsKey(FrameColors[j])) {
						records.put(FrameColors[j], records.get(FrameColors[j]) + 1); //add one to current value for each color
					} else {
						records.put(FrameColors[j], 0); //initialize to zero
					}
				}
			}
		}
		sortedMap.putAll(records);
		int[] tempFreqArray = new int[mostCommonNumber];
		for (int i=0; i<mostCommonNumber; i++) {
			System.out.println(sortedMap.values().toArray()[i] + "\t" + sortedMap.keySet().toArray()[i]);
			tempFreqArray[i] = (int)sortedMap.values().toArray()[i];
		}
		Color[] almostFinalArrayOfColors = sortedMap.keySet().toArray(new Color[0]);
		Color[] finalArrayOfColors = Arrays.copyOfRange(almostFinalArrayOfColors, 0, mostCommonNumber);
		this.mostCommonColors = finalArrayOfColors; //return array of colors
		setFrequencies(tempFreqArray);
	}
	public int[] getFrequencies () {
		return mostCommonColorFrequency;
	}
	public void setFrequencies (int[] freq) {
		this.mostCommonColorFrequency = freq;
	}
	public Frame[] getFrames() {
		return frames;
	}
	public void setFrames(Frame Frames[]) {
		this.frames = Frames;
	}
	public int getMostCommonNumber () {
		return mostCommonNumber;
	}
	public void setMostCommonNumber (int number) {
		mostCommonNumber = number;
	}
}
