import java.io.IOException;


public class Body {
	public static void main (String args[]) throws IOException {
		String directoryName = "./images";
		String csvOutputFile = "";
		FrameSet frameSet = new FrameSet(directoryName);
		
		//calculate density of each frame
		
		//display graphically
		BodyFrame BodyFrame = new BodyFrame(frameSet);
		BodyFrame.pack();
		BodyFrame.setVisible(true);
		
		//send FrameSet to density as well
		Density D = new Density(frameSet);
		D.printNeighbors(csvOutputFile);
		
		//display works, ui does not work, start on image processesing techniques (edge detection, color area extent)
	}
}