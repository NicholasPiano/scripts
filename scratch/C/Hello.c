#include <iostream>
using namespace std;

#define PI 3.1415926535897
#define NL '\n'

int main () {
  int a=5;
  int b(2);
  int result;

  a += 3;
  result = a - b;

  cout << result << endl; //print result
  
  return 0; //return success
}
