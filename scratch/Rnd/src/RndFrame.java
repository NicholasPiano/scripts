import java.awt.*;
import javax.swing.*;

public class RndFrame extends JFrame {

	RndPanel P;

	public RndFrame(int a[][]) {
		setBounds(100, 30, a[0].length, a.length);
		setPreferredSize(new Dimension(4*a[0].length,4*a.length));
		setBackground(Color.black);

		getContentPane().setLayout(new BorderLayout());

		P = new RndPanel(a);
		getContentPane().add(P, BorderLayout.CENTER);

		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
	public void update(int a[][]) {
		P.update(a);
	}
}

class RndPanel extends JPanel {

	private int a[][];

	public RndPanel(int a[][]) {
		this.a = a;
		setBackground(Color.black);
	}
	public void paintComponent(Graphics g) {
		//paint background
		super.paintComponent(g);
		//paint each point
		for (int i=0; i<a.length; i++) {
			for (int j=0; j<a.length; j++) {
				int h = a[i][j]*255;
				g.setColor(new Color(h, h, h));
				g.fillRect(4*i, 4*j, 4, 4);
			}
		}
	}
	public void update(int a[][]) { //update panel
		this.a = a;
		repaint();
	}
}