import java.awt.Color;
import java.util.Comparator;
import java.util.Map;

public class ValueComparator implements Comparator<Color> {
	Map<Color, Integer> base;
	public ValueComparator(Map<Color, Integer> base) {
		this.base = base;
	}

	// Note: this comparator imposes orderings that are inconsistent with equals.    
	public int compare(Color a, Color b) {
		if (base.get(a) >= base.get(b)) {
			return -1;
		} else {
			return 1;
		} // returning 0 would merge keys
	}
}
