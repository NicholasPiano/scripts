//Variable types

#include <iostream>

using namespace std;

int main() {
  float input_float;
  cout << "Enter a floating point value: ";
  cin >> input_float;
  int input_int = (int)input_float;
  cout << "Value converted to integer: " << input_int << endl;
  float difference = input_float - (float)input_int;
  cout << "Difference between integer and original value: " << difference << endl;
  return 0;
}
