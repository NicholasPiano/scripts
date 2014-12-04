import java.util.*;

public class LifeRuleSet {
	private LifeRuleSetIterator L;
	private LifeRule lifeRule[];
	private LifeRule preDefLifeRules[] = new LifeRule[]{new LifeRule("23/3"), new LifeRule("34/34"), new LifeRule("45678/5678"), new LifeRule("12345678/45"), new LifeRule("2/1")};
	private LifeRule rankLifeRules[] = new LifeRule[]{new LifeRule("23/3"), new LifeRule("37/23"), new LifeRule("2345/2"), new LifeRule("23/2")};
	private int gen=0;
	
	public LifeRuleSet (String lifeRuleStrings[], String iteratorString) {
		this.lifeRule = new LifeRule[lifeRuleStrings.length];
		for (int i=0; i<lifeRuleStrings.length; i++) {
			lifeRule[i] = new LifeRule(lifeRuleStrings[i]);
		}
		//System.out.println(iteratorString + " LRS");
		this.L = new LifeRuleSetIterator(iteratorString);
	}
	public LifeRuleSet (int ruleArray[], String iteratorString) { //use predefs
		this.lifeRule = new LifeRule[ruleArray.length];
		for (int i=0; i<ruleArray.length; i++) {
			lifeRule[i] = this.preDefLifeRules[ruleArray[i]];
		}
		//System.out.println(iteratorString + " LRS");
		this.L = new LifeRuleSetIterator(iteratorString);
	}
	public LifeRuleSet (String lifeRuleString) {
		//takes in a single string to define rule
		this.lifeRule = new LifeRule[]{new LifeRule(lifeRuleString)};
	}
	public LifeRuleSet (int lifeRuleInt) {
		//takes in a single string to define rule
		this.lifeRule = new LifeRule[]{preDefLifeRules[lifeRuleInt]};
	}
	//operators
	public LifeRule query (int gen) { //returns rule that should be applied
		//return lifeRule[L.query(gen)];
		return lifeRule[gen];
	}
	public boolean verdict (boolean alive, int n, int gen) {
		return query(gen).verdict(alive, n);
	}
	public void setL(LifeRuleSetIterator L) {
		this.L = L;
	}
	
	//factory
	public LifeRuleSet () {
		this.lifeRule = this.rankLifeRules;
	}
}

class LifeRule {
	private ArrayList<Integer> S, B;

	public LifeRule (String s) {

		S = new ArrayList<Integer>();
		B = new ArrayList<Integer>();

		String ruleString[] = s.split("/");
		
		//System.out.println(ruleString[0] + "a a" + ruleString[1] + "a");

		int sv = Integer.parseInt(ruleString[0].trim());
		int bn = Integer.parseInt(ruleString[1].trim());

		while (sv>0) {
			S.add((int)(sv%10));
			sv = (int)(sv/10.0);
		}
		while (bn>0) {
			B.add((int)(bn%10));
			bn = (int)(bn/10.0);
		}
	}
	public boolean verdict (boolean alive, int n) { //based only on number of neighbors
		boolean change = false;
		if (alive) {
			if (!S.contains(n)) {
				change = true;
			}
		} else {
			if (B.contains(n)) {
				change = true;
			}
		}
		return change;
	}
	public boolean verdict(int n[]) { //based on relative positions of neighbors
		return true;
	}
}

class LifeRuleSetIterator {
	private int ruleSet[], waypoints[], generation;
	
	public LifeRuleSetIterator (String iteratorString) {
		//parse string into rule iterator and return array
		//format: 1-1000:2-1000:3-500:
		//iteratorString = "0-10:1-1000";
		//System.out.println(iteratorString + " LRSI");
		String s[] = iteratorString.split(":");
		this.ruleSet = new int[s.length];
		this.waypoints = new int[s.length];
		for (int i=0; i<s.length; i++) {
			String rule[] = s[i].split("-");
			ruleSet[i] = Integer.parseInt(rule[0].trim());
			waypoints[i] = Integer.parseInt(rule[1].trim());
			generation += waypoints[i];
			//System.out.println(generation + " LRSI");
		}
		//System.out.println(generation);
	}
	public int query (int gen) {
		//System.out.println(generation);
		int mod = gen % generation;
		int k=0, sum = waypoints[k];
		while (sum < mod) {
			sum += waypoints[k++];
		}
		return ruleSet[k];
	}
}