import java.awt.Color;
import java.awt.Graphics;

import javax.swing.*;

@SuppressWarnings("serial")
public class Panel extends JPanel{
	
	float[][] array;
	int width;
	int height;
	boolean zoom;
	
	
	public Panel(float[][] array, int width, int height, boolean zoom){
		this.array = array;
		this.width = width;
		this.height = height;
		setBackground(Color.black);	
		this.zoom = zoom;
	}
	
	public void paintComponent(Graphics g){
		super.paintComponent(g);
		
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				// normal
				g.setColor(Color.getHSBColor((array[i][j]),1.0f,1.0f));
				// intersting/sparkling
			//	g.setColor(Color.getHSBColor((array[i][j]),(array[i][j]),(array[i][j])));
				// funky
			//	g.setColor(Color.getHSBColor((array[i][j]),1.0f,(array[i][j])));
				// Black & White
			//	g.setColor(Color.getHSBColor(0.0f,0.0f,(array[i][j])));
				// Blue
			//	g.setColor(Color.getHSBColor(0.6666666f,1.0f,(array[i][j])));
				// Red
			//	g.setColor(Color.getHSBColor(0.0f,1.0f,(array[i][j])));
				// Green
			//	g.setColor(Color.getHSBColor(0.3333333f,1.0f,(array[i][j])));
				
				if (zoom){
					g.fillRect(5*j, 5*i, 5, 5);
				} else {
					g.drawLine(j, i, j, i);
				}
			}
		}
		repaint();
	}
}
