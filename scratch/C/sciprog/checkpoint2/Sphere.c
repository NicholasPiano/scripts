//Sphere values program

#include <math.h>
#include <iostream>

#define PI 3.1415926535897
using namespace std;

int main() {
  float radius;
  cout << "Enter a value for the radius of the Sphere: ";
  cin >> radius;
  cout << endl;
  float surface_area, volume;
  surface_area = 4*PI*pow(radius, 2);
  volume = 4*PI*pow(radius, 3)/3;
  cout << "The Surface Area is: " << surface_area << endl;
  cout << "The Volume is: " << volume << endl;
}
