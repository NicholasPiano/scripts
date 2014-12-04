import java.awt.Color;
import java.util.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import javax.imageio.ImageIO;

public class Frame {
	private Color map[][], top[], colorArray[];
	
	public Frame (File file) {
		setMapFromImage(file);
		setTopFromMap();
	}
	
	public void setMapFromImage (File file) {
		//read in image from file
		BufferedImage img = null;
		try {
			img = ImageIO.read(file);
		} catch (IOException e) {
		}
		//get size of image
		int y = img.getHeight();
		int x = img.getWidth();
		//make array
		Color[][] mapTemp = new Color[x][y];
		//populate array, biasing black and white in binary
		for (int i=0; i<x; i++) {
			for (int j=0; j<y; j++) {
				mapTemp[i][j] = new Color(img.getRGB(i, j));
				//System.out.println(mapTemp[i][j]);
			}
		}
		//System.out.println("Frame");
		setMap(mapTemp);
	}
	
	public void setTopFromMap () {
		//build dictionary of top colors
		HashMap<Color,Integer> records = new HashMap<Color,Integer>();
        ValueComparator bvc =  new ValueComparator(records);
        TreeMap<Color,Integer> sortedMap = new TreeMap<Color,Integer>(bvc);
		//loop through array of colors
		for (int i=0; i<map.length; i++) {
			for (int j=0; j<map[0].length; j++) {
				if (!map[i][j].equals(new Color(0,0,0))) {
					if (records.containsKey(map[i][j])) {
						records.put(map[i][j], records.get(map[i][j]) + 1); //add one to current value for each color
					} else {
						records.put(map[i][j], 0); //initialize to zero
					}
				}
			}
		}
		sortedMap.putAll(records);
		//System.out.println(sortedMap);
		Color[] almostFinalArrayOfColors = sortedMap.keySet().toArray(new Color[0]);
		setColorArray(almostFinalArrayOfColors);
		Color[] finalArrayOfColors = Arrays.copyOfRange(almostFinalArrayOfColors, 0, 8);
		setTop(finalArrayOfColors); //return array of colors
	}
	
	public void getDensity () {
		
	}

	public Color[][] getMap() {
		return map;
	}

	public void setMap(Color map[][]) {
		this.map = map;
	}

	public Color[] getTop() {
		return top;
	}

	public void setTop(Color top[]) {
		this.top = top;
	}

	public Color[] getColorArray() {
		return colorArray;
	}

	public void setColorArray(Color colorArray[]) {
		this.colorArray = colorArray;
	}
}
