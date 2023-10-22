
#ifndef CPU_BINARIZE_HPP
# define CPU_BINARIZE_HPP

#include "../Bench.hpp"

class CpuBinarize : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        CpuBinarize(std::string name, int xSize, int ySize);
        ~CpuBinarize();
};

#endif
