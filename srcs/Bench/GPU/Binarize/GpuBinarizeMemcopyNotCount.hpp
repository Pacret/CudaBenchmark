
#ifndef GPU_BINARIZE_MEMCOPYNOTCOUNT_HPP
# define GPU_BINARIZE_MEMCOPYNOTCOUNT_HPP

#include "../../Bench.hpp"


class GpuBinarizeMemcopyNotCount : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuBinarizeMemcopyNotCount(std::string name, int xSize, int ySize);
        ~GpuBinarizeMemcopyNotCount();
};

#endif
