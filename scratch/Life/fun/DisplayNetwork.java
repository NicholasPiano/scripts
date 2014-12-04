import javax.swing.*;

@SuppressWarnings("serial")
public class DisplayNetwork extends JFrame{
	
	static NetworkPanel pan;
	
	public static void main(String[] args){
		new DisplayNetwork();
	}
	
	public DisplayNetwork(){
		int height = 700;
		int width = 1300;
		double steps = 1000000;
		RandomNetwork array = new RandomNetwork(height,width,steps);
		pan = new NetworkPanel(array.getArray(),height,width);
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		setBounds(1, 1, width+25, height+45);
		setContentPane(pan);
		setVisible(true);
	}


}
