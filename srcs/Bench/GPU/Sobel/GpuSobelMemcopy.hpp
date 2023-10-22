
#ifndef GPU_SOBEL_MEMCOPY_HPP
# define GPU_SOBEL_MEMCOPY_HPP

#include "../../Bench.hpp"


class GpuSobelMemcopy : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuSobelMemcopy(std::string name, int xSize, int ySize);
        ~GpuSobelMemcopy();
};

#endif
