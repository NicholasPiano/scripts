import java.awt.*;
import java.awt.event.*;
import java.util.ArrayList;
import java.util.Arrays;
import javax.swing.*;

public class BodyFrame extends JFrame {

	private static final long serialVersionUID = 1L;
	bodyPanel P;
	ButtonPanel BP;
	FrameSet f;

	public BodyFrame(FrameSet f) {
		//local vars
		this.f = f;
		int xSize = 1041;
		int ySize = 600;
		//properties
		setLocation(100, 30);
		setPreferredSize(new Dimension(xSize,ySize+200));
		setBackground(Color.black);
		getContentPane().setLayout(new BorderLayout());
		//panels
		P = new bodyPanel(f, xSize, ySize);
		getContentPane().add(P, BorderLayout.CENTER);
		BP = new ButtonPanel();
		BP.setPanel(P);
		getContentPane().add(BP, BorderLayout.SOUTH);
		//control = new panelControl();

		//other
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
}

class ButtonPanel extends JPanel {

	private static final long serialVersionUID = 1L;
	private JButton next, previous, playFromBeginning, stop;
	private bodyPanel panel;
	
	public ButtonPanel () {
		next = new JButton("next");
		next.addActionListener(new ActionListener() {
	         public void actionPerformed(ActionEvent e) {
	        	 panel.next(true);
	         }
	    });
		add(next);
		previous = new JButton("previous");
		previous.addActionListener(new ActionListener() {
	         public void actionPerformed(ActionEvent e) {
	        	 panel.next(false);
	         }
	    });
		add(previous);
	}
	
	public void setPanel (bodyPanel panel) {
		this.panel = panel;
	}
}

class bodyPanel extends JPanel {

	private static final long serialVersionUID = 1L;
	private FrameSet f;
	private Frame display, Frames[];
	private int index, xSize, ySize;
	private boolean play;

	public bodyPanel(FrameSet f, int xSize, int ySize) {
		this.f = f;
		this.Frames = f.getFrames();
		//System.out.println(f);
		this.index = 0;
		this.xSize = xSize;
		this.ySize = ySize;
		this.display = Frames[index];
		setBackground(Color.black);
		setLayout(null);
	}
	public void paintComponent(Graphics g) {
		//paint background
		super.paintComponent(g);
		//image IO
		//BufferedImage B = new BufferedImage(1041, 670, BufferedImage.TYPE_INT_RGB);
		//Graphics G = B.createGraphics();
		//paint each point
		ArrayList<Integer> numberList = new ArrayList<Integer>(0);
		for (int i=0; i<xSize; i++) {
			for (int j=0; j<ySize; j++) {
				if (i < 347) { //grid - there's probably a better way of doing this
					if (j < 200) {
						//print original
						g.setColor(display.getMap()[i][j]);
					} else if (j >= 200 && j < 400) {
						Color c = display.getTop()[0];
						if (display.getMap()[i][j-200].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					} else {
						Color c = display.getTop()[1];
						//System.out.println(j);
						if (display.getMap()[i][j-400].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					}
				} else if (i >= 347 && i < 694) {
					if (j < 200) {
						Color c = display.getTop()[2];
						if (display.getMap()[i-347][j].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					} else if (j >= 200 && j < 400) {
						Color c = display.getTop()[3];
						if (display.getMap()[i-347][j-200].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					} else {
						Color c = display.getTop()[4];
						if (display.getMap()[i-347][j-400].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					}
				} else {
					if (j < 200) {
						Color c = display.getTop()[5];
						if (display.getMap()[i-694][j].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					} else if (j >= 200 && j < 400) {
						Color c = display.getTop()[6];
						if (display.getMap()[i-694][j-200].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					} else {
						Color c = display.getTop()[7];
						if (display.getMap()[i-694][j-400].equals(c)) {
							g.setColor(c);
						} else {
							g.setColor(Color.black);
						}
					}
				}
				g.fillRect(i, j, 1, 1);
				if (Arrays.asList(f.getMostCommonColors()).contains(g.getColor())) {
					//System.out.println();
					int index = 0;
					for (int k=0; k<f.getMostCommonNumber(); k++) {
						if (f.getMostCommonColors()[k].getBlue()==g.getColor().getBlue() &&
								f.getMostCommonColors()[k].getRed()==g.getColor().getRed() &&
								f.getMostCommonColors()[k].getGreen()==g.getColor().getGreen() && !(i<347 && j<200)) {
							index = k;
							//System.out.println("actual " + k);
							if (!numberList.contains(k)) {
								//System.out.println("list " + k);
								numberList.add(k);
							}
							break;
						}
						//System.out.println("index " + k);
					}
					//System.out.println(index);
					//snap coords
					int xCoord = (int)(Math.floor(i/347.0)*347.0);
					int yCoord = (int)(Math.floor(j/200)*200.0);
					g.setColor(Color.red);
					if (i<347 && j<200) {
						g.drawRect(xCoord, yCoord, 70, 50);
						g.drawString("original", xCoord + 10, yCoord + 20);
					} else {
						g.drawRect(xCoord, yCoord, 50, 50);
						g.drawString("" + index + "", xCoord + 10, yCoord + 20);
					}
				}
			}
		}
		//draw number boxes
		g.setColor(Color.red);
		for (int i=0; i<numberList.size(); i++) {
			int x = 50*(int)numberList.toArray()[i];
			g.drawRect(x, 600, 50, 50);
			g.drawString("" + (int)(x/50.0) + "", x+10, 620);
		}
		numberList.clear();
	}
	public void next(boolean inc) { //update panel
		if (index < Frames.length-1 && index >= 0) {
			this.index += (inc?1:-1); //boolean to int 
			//System.out.println(index);
		} else {
			if (inc) {
				this.index = 0;
				//System.out.println(index);
			} else {
				this.index = Frames.length-1;
				//System.out.println(index);
			}
		}
		this.display = Frames[index];
		repaint();
	}
	public void play(boolean inc) {
		//could not get play method to work 9/3/13
		play = true;
		index = 0;
		while (play) {
			next(inc);
		}
	}
	public int searchArray (Color[] array, Color key) {
		int temp = 0;
		for (int i=0; i<array.length; i++) {
			if (array[i].toString().equals(key.toString())) {
				temp = i;
				break;
			}
		}
		return temp;
	}
}
