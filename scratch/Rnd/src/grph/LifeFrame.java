import java.awt.*;
import javax.swing.*;

public class LifeFrame extends JFrame {

    LifePanel P;

    public LifeFrame(Life L) {
	int a[][] = L.getArray();

	setBounds(100, 30, a[0].length, a.length);
	setPreferredSize(new Dimension(a.length,a[0].length));
	setBackground(Color.black);

	getContentPane().setLayout(new BorderLayout());

	P = new LifePanel(L);
	getContentPane().add(P, BorderLayout.CENTER);

	setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    public void update(Life L) {
	P.update(L);
    }
}

class LifePanel extends JPanel {

    private int a[][];

    public LifePanel(Life L) {
	this.a = L.getArray();
	setBackground(Color.black);
    }
    public void paintComponent(Graphics g) {
	//paint background
	super.paintComponent(g);
	//paint each point
	for (int i=0; i<a.length; i++) {
	    for (int j=0; j<a[0].length; j++) {
		int h = a[i][j]*255;
		g.setColor(new Color(h, h, h));
		g.fillRect(i, j, 1, 1);
	    }
	}
    }
    public void update(Life L) { //update panel
	this.a = L.getArray();
	repaint();
    }
}