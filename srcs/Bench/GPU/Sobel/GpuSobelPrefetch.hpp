
#ifndef GPU_SOBEL_PREFETCH_HPP
# define GPU_SOBEL_PREFETCH_HPP

#include "../../Bench.hpp"


class GpuSobelPrefetch : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuSobelPrefetch(std::string name, int xSize, int ySize);
        ~GpuSobelPrefetch();
};

#endif
