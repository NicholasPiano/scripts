import java.util.*;


public class RandomNetwork {
	Random ran = new Random();
	Node[][] array;
	
	int x,y,oldx,oldy = 0;
	
	public RandomNetwork(int width, int height, double steps){
		array = new Node[height][width];
		
		for (int i=0; i<height;i++){
			for (int j=0;j<width;j++){
				array[i][j] = new Node(0, 0, 0.1f);
			}
		}
		
				
		double counter = 0;
		while (counter<steps){
			x = ran.nextInt(height);
			y = ran.nextInt(width);
			
			oldx = (int) ran.nextDouble()*((x+20)-(x-20));
			oldy = (int) ran.nextDouble()*((y+20)-(y-20));
			
			
			array[x][y].setPosX(oldx);
			array[x][y].setPosY(oldy);
			array[x][y].setColour(ran.nextFloat());
			
			//oldx = x;
			//oldy = y;
			
			counter++;
			
		}
		
		
		
		
	}
	public Node[][] getArray(){
		return array;
	}
	

}
