//(terrain/grid) - grid constructor
import java.io.*;
import java.lang.Math;
import java.util.*;

public class Grid {
    Console con = System.console();
    Random generator = new Random(); //activate random generator
    private int x_size, y_size, count; //instances of Percolation
    private double average_height, cell_array[][];
    public Grid (int x, int y, double avg_height) { //Grid constructor
	System.out.println("\n");
	System.out.println("Constructor called...\n");
	x_size = x;
	y_size = y;
	double num_array[][] = new double[x][y]; //temporary holding array
	int cells_filled = x*y;
	for (int i=0; i<x_size; i++) { //set all elements to zero initially
	    for (int j=0; j<y_size; j++) {
		num_array[i][j] = 1;
	    }
	}
	do { //randomly fill specific density
	    int mask = generator.nextInt(2)+3; 
	    average_height = 1;
	    int z = generator.nextInt(x_size-2*mask)+mask; //two random coordinates
	    int m = generator.nextInt(y_size-2*mask)+mask; //
	    for (int k=-mask; k<mask+1; k++) {
		for (int n=-mask; n<mask+1; n++) {
		    double random = generator.nextDouble()*0.9; //random height increase
		    if (n==k && n==0) { //center cell
			num_array[z+k][m+n] *= (random-Math.exp(-2*num_array[z+k][m+n])+0.9);
		    } else if ((n<mask) && (n>-mask) && (k<mask) && (k>-mask)) { //next layer
			num_array[z+k][m+n] *= (random-Math.exp(-2*num_array[z+k][m+n])+1.2);
		    } else { //surrounding 
			num_array[z+k][m+n] *= (random-Math.exp(-2*num_array[z+k][m+n])+0.8);
		    }
		}
	    }
	    for (int i=0; i<x_size; i++) { //set all elements to zero initially
		for (int j=0; j<y_size; j++) {
		    average_height += (num_array[i][j])/(x_size*y_size);
		    if (num_array[i][j]>avg_height) {
			count++;
		    }
		}
	    }
	    System.out.println(count + " " + average_height);
	} while (count < 0.6*x_size*y_size);
	System.out.println("Constructor done\n");
	cell_array = num_array; //set grid instance array to temp array
    }
    //public static double getAverageHeight() {
	//method to return the average height of the terrain
	//}
    public void printGridToFile() {
	try {
	    FileWriter fstream = new FileWriter("grid.m");
	    BufferedWriter out = new BufferedWriter(fstream);
	    //print meshgrid for x,y
	    int x = x_size - 1;
	    int y = y_size - 1;
	    out.write("[x,y] = meshgrid(0:1:" + x + ",0:1:" + y + ");\n");
	    //print z-array
	    out.write("z = [");
	    for (int i=0; i<y_size; i++) { //start column
		for (int j=0; j<x_size; j++) { //start row
		    out.write(cell_array[j][i] + " ");
		}
		out.write(";\n");
	    }
	    out.write("];\n");
	    out.write("surf(x,y,z);");
	    out.close();
	} catch (Exception e) {//Catch exception if any
	    System.err.println("Error: " + e.getMessage());
	}
    }
    public void printArray() {
	for (int i=0; i<y_size; i++) {
	    for (int j=0; j<x_size; j++) {
		System.out.printf("%d ", cell_array[j][i]);
	    }
	    System.out.printf("\n");
	}
	System.out.printf("\n");
    }
}