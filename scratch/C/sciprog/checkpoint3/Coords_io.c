//File input and output

#include <iostream>
#include <fstream>
#include <string>

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
  //print to file
  ofstream file;
  string filename;
  string filetype (".txt");
  cout << "Enter a filename to store the sphere values: ";
  do {
    cin >> filename;
    cout << "Please specify a .txt file: ";
  } while (filename.compare(-4,4,filetype,-4,4) != 0);
  file.open (filename);
  
  return 0;
}
