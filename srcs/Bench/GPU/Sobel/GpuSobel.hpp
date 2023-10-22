
#ifndef GPU_SOBEL_HPP
# define GPU_SOBEL_HPP

#include "../../Bench.hpp"

class GpuSobel : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuSobel(std::string name, int xSize, int ySize);
        ~GpuSobel();
};

#endif
