
public class LifeCell {
	private boolean alive;
	private int rank;
	
	public LifeCell (boolean alive, int rank) {
		this.alive = alive;
		this.rank = rank;
	}
	
	//synthesize
	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	public boolean isAlive() {
		return alive;
	}

	public void setAlive(boolean alive) {
		this.alive = alive;
	}
	
}
