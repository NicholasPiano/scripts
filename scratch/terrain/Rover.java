//(terrain/rover) - rover constructor

public class Rover {
    private double mass, energy;
    private int x_coord, y_coord;
    //constructor
    public Rover(double mass, double energy, int x, int y) {
	mass = M;
	energy = E;
	x_coord = x;
	y_coord = y;
    }
    //getters
    public double getM () {return mass;}
    public double getE () {return energy;}
    public double getx () {return x_coord;}
    public double gety () {return y_coord;}
    //setters
    public void setM (double M) {mass = M;}
    public void setE (double E) {energy = E;}
    public void setx (int x) {x_coord = x;}
    public void sety (int y) {y_coord = y;}
}