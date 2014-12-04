import java.io.*;
import java.util.*;

public class LifeRule {
    private ArrayList<Integer> S, B;

    public LifeRule (String s) {

	S = new ArrayList<Integer>();
	B = new ArrayList<Integer>();

	String ruleString[] = s.split("/");
	
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
    public boolean verdict(int cell, int n) { //based only on number of neighbors
	boolean change = false;
	if (cell==1) {
	    if (S.contains(n)) {
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