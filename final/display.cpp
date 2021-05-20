// Steven Tsan
// stsan@csu.fullerton.edu
// Section 5

#include <stdio.h>

extern "C" void display( double array[], long size );

void display( double array[], long size )
{
  for( long i = 0; i < size; ++i )
  {
    printf( "%1.9lf\n", array[i] );
  }
}
