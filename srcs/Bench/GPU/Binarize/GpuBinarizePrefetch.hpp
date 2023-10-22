
#ifndef GPU_BINARIZE_PREFETCH_HPP
# define GPU_BINARIZE_PREFETCH_HPP

#include "../../Bench.hpp"


class GpuBinarizePrefetch : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuBinarizePrefetch(std::string name, int xSize, int ySize);
        ~GpuBinarizePrefetch();
};

#endif
