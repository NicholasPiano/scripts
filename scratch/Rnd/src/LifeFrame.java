import java.awt.*;
import javax.swing.*;

public class LifeFrame extends JFrame {

    LifePanel P;

    public LifeFrame(int a[][]) {
	setBounds(100, 30, a[0].length, a.length);
	setPreferredSize(new Dimension(a.length,a[0].length));
	setBackground(Color.black);

	getContentPane().setLayout(new BorderLayout());

	P = new LifePanel(a);
	getContentPane().add(P, BorderLayout.CENTER);

	setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }
    public void update(int a[][]) {
	P.update(a);
    }
}

class LifePanel extends JPanel {

    private int a[][];

    public LifePanel(int a[][]) {
	this.a = a;
	setBackground(Color.black);
    }
    public void paintComponent(Graphics g) {
	//paint background
	super.paintComponent(g);
	//paint each point
	for (int i=0; i<a.length/2.0; i++) {
	    for (int j=0; j<a[0].length/2.0; j++) {
		int h = a[2*i][2*j]*255;
		g.setColor(new Color(h, h, h));
		g.fillRect(i, j, 1, 1);
	    }
	}
    }
    public void update(int a[][]) { //update panel
	this.a = a;
	repaint();
    }
}