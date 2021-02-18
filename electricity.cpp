// Steven Tsan
// CPSC 240-5 Test 1

#include <iostream>
#include <iomanip>

extern "C" double compute_x86();

int main (int arc, char* argv[])
{
  std::cout << "Welcome to a Electric Resistance Calculator by Steven Tsan." << std::endl;

  double perimeter = 0.00;
  perimeter = compute_x86(); // assembly file does actions and then sends resistance back.
  std::cout << "The Electricity function received the number " << std::setw(4)
            << std::setprecision(5) << std::fixed
            << perimeter << " and has decided to keep it.\n";

  std::cout << "A 0 will be returned to the operating system.\n";
  std::cout << "Have a nice day.\n";
  return 0;
}
