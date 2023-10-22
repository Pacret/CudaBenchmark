
#ifndef CPU_EROSION_HPP
# define CPU_EROSION_HPP

#include "../Bench.hpp"

class CpuErosion : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        CpuErosion(std::string name, int xSize, int ySize);
        ~CpuErosion();
};

#endif
