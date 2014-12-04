//(terrain/grid) - coordinate constructor

public class Coord {
    private double height, friction;
    //constructors
    public Coord(double h, double f) {
	height = h;
	friction = f;
    }
    public Coord(double h) {
	height = h;
	friction = 0.0;
    }
    //getters
    public double getH () {return height;}
    public double getF () {return friction;}
    //setters
    public void setH (double h) {height = h;}
    public void setF(double f) {friction = f;}
}