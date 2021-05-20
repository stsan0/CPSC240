// Steven Tsan
// stsan@csu.fullerton.edu
// Section 5

#include <stdio.h>

double control();

int main()
{
  double result_code = -999;
  printf( "This is 240-5 programming final by Steven Tsan \n" );
  result_code = control();
  printf( "The main has received this number %1.6lf and will keep it.\n", result_code );
  printf( "A 0 will now be returned to the operating system. \n" );
  printf( "Have a great next semester.  Bye! \n" );
  return 0;
}    //End of main
