import javax.swing.*;

@SuppressWarnings("serial")
public class DisplayArray extends JFrame{

	static Panel pan;
	int height,width;
	boolean zoom = false;
	ClusterArray array2;

	public static void main(String[] args){
		new DisplayArray();
	}

	public DisplayArray(){
		setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		height = 70;
		/*
		width = 130;
		zoom = true;
		//*/

		//*
		height = 350;
		width = 650;
		//*/
		/*
		height = 700;
		width = 1300;
		//*/

		double steps = 23000000;
		RandomArray array = new RandomArray(width,height, steps);
		array2 = new ClusterArray(width, height, array.getArray());

		pan = new Panel(array2.getArray2(),width,height, zoom);


		
		if (zoom){
			setBounds(1, 1, 5*width+25, 5*height+45);
		} else {
			setBounds(1, 1, width+25, height+45);
		}
		setContentPane(pan);
		setVisible(true);

		//*
		while (true){

		//	array2.roundArray(array2.getArray());
		//	array2.maxArray(array2.getArray());
		//	array2.clusterArray(array2.getArray());
		//	array2.clusterArrayRandom(array2.getArray());

		//	array2.roundArray(array2.getArray2());
		//	array2.maxArray2(array2.getArray2());
		//	array2.clusterArray2(array2.getArray2());
		//	array2.clusterArray2Wrong(array2.getArray2());
			array2.clusterArray2Random(array2.getArray2(), 0.999999);
				
		//	array2.moveUpArray2(array2.getArray2());
		//	array2.moveDownArray2(array2.getArray2());
		//	array2.moveLeftArray2(array2.getArray2());
		//	array2.moveRightArray2(array2.getArray2());

		/*
			try {
				Thread.sleep(10);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			//*/

			pan.repaint();

			//counter++;

		}

		//*/
	}
}
