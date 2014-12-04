import java.awt.Color;
import java.awt.Graphics;

import javax.swing.*;

@SuppressWarnings("serial")
public class NetworkPanel extends JPanel{
	
	Node[][] array;
	int width;
	int height;
	
	
	public NetworkPanel(Node[][] array, int width, int height){
		this.array = array;
		this.width = width;
		this.height = height;
		setBackground(Color.white);
		
	}
	
	public void paintComponent(Graphics g){
		super.paintComponent(g);
		
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				g.setColor(Color.getHSBColor((array[i][j].getColour()),1.0f,1.0f));
				g.drawLine(i, j, array[i][j].getPosX(), array[i][j].getPosY());
			}
		}
		
		
	}

}
