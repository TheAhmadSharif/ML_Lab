#include <iostream>
#include <random>

int main() {
    // Seed the random number generator
    std::random_device rd;
    std::mt19937 gen(rd());

   


    //Generate a random integer between a and b (e.g. 1 and 10)
    int int_a = 1;
    int int_b = 10;
    std::uniform_int_distribution<> int_dist_a_b(int_a, int_b);
    int random_int_a_b = int_dist_a_b(gen);
    std::cout << "Random integer between " << int_a << " and " << int_b << ": " << random_int_a_b << std::endl;

    return 0;
}