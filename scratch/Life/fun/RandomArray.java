import java.util.*;


public class RandomArray {
	Random ran1 = new Random();
	Random ran2 = new Random();
	float[][] array;


	public RandomArray(int width, int height){
		array = new float[width][height];
		for (int i=0; i<width;i++){
			for (int j=0;j<height;j++){
				array[i][j] = ran1.nextFloat();
			}
		}
	}


	public RandomArray(int width, int height, double steps){
		array = new float[height][width];
		double counter = 0;
		while (counter<steps){
			int x = ran1.nextInt(height);
			int y = ran2.nextInt(width);
			array[x][y] += ran1.nextFloat();
			counter++;
		}
	}
	
	public float[][] getArray(){
		return array;
	}


}
