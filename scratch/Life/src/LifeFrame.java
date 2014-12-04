import java.awt.*;
import javax.swing.*;

public class LifeFrame extends JFrame {

	LifePanel P;

	public LifeFrame(Life L) {
		LifeCell a[][] = L.getArray();

		int factor = (int)(800.0/a.length);

		setLocation(100, 30);
		setPreferredSize(new Dimension(a.length*factor,a[0].length*factor));
		setBackground(Color.black);

		getContentPane().setLayout(new BorderLayout());

		P = new LifePanel(L, factor);
		getContentPane().add(P, BorderLayout.CENTER);

		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	public void update(Life L) {
		P.update(L);
	}
}

class LifePanel extends JPanel {

	private LifeCell[][] array;
	private int factor;

	public LifePanel(Life L, int factor) {
		this.array = L.getArray();
		this.factor = factor;
		setBackground(Color.black);
	}
	public void paintComponent(Graphics g) {
		//paint background
		super.paintComponent(g);
		//paint each point
		for (int i=0; i<array.length; i++) {
			for (int j=0; j<array[0].length; j++) {
				//color
				int r=0, gr=0, b=0; //for dead
				if (array[i][j].isAlive()) {
					int rank = array[i][j].getRank();
					switch (rank) {
						case 0: r=255; gr=255; b=255; break;
						case 1: r=255; gr=255; b=255; break;
						case 2: r=255; gr=255; b=255; break;
						//case 3: r=255; gr=255; b=255; break;
						//case 4: r=255; gr=255; b=255; break;
						case 3: r=255; break;
					}
				}
				g.setColor(new Color(r, gr, b));
				g.fillRect(factor*i, factor*j, factor*2, factor*2);
			}
		}
	}
	public void update(Life L) { //update panel
		this.array = L.getArray();
		repaint();
	}
}