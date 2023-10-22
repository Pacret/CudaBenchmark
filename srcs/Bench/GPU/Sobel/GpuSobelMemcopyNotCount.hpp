
#ifndef GPU_SOBEL_MEMCOPYNOTCOUNT_HPP
# define GPU_SOBEL_MEMCOPYNOTCOUNT_HPP

#include "../../Bench.hpp"


class GpuSobelMemcopyNotCount : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuSobelMemcopyNotCount(std::string name, int xSize, int ySize);
        ~GpuSobelMemcopyNotCount();
};

#endif
