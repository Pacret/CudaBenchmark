
#ifndef BENCH_HPP
# define BENCH_HPP

#include "../includes.hpp"

class Bench
{
	protected:
        void randomizeImage();
        bool verifyImageValues();
        virtual double process8bits() = 0;
        virtual double process16bits() = 0;

	public:
		Bench(std::string name, int xSize, int ySize);
        virtual ~Bench();
        void benchmark();
        std::string name;
        int         xSize;
        int         ySize;
        double      duration8bits;
        double      duration16bits;
        unsigned char *image8bits;
        short *image16bits;
        std::vector<double> times8bits;
        std::vector<double> times16bits;
};

#endif
