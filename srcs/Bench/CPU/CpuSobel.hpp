
#ifndef CPU_SOBEL_HPP
# define CPU_SOBEL_HPP

#include "../Bench.hpp"

class CpuSobel : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        CpuSobel(std::string name, int xSize, int ySize);
        ~CpuSobel();
};

#endif
