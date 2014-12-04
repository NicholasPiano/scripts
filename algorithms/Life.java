import java.io.*;
import java.lang.Math;
import java.util.*;

public class Life {
	private int a;
	private int b;
	private int c;
	public Life (int a, int b, int c) {
		this.a = a;
		this.b = b;
		this.c = c;
	}
	public int add (int a, int b, int c) {
		return a + b + c;
	}
	public int subtract (int a, int b, int c) {
		return a - b - c;
	}
	public int multiply (int a, int b, int c) {
		return a*b*c;
	}
}