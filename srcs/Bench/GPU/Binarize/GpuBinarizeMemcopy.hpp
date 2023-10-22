
#ifndef GPU_BINARIZE_MEMCOPY_HPP
# define GPU_BINARIZE_MEMCOPY_HPP

#include "../../Bench.hpp"


class GpuBinarizeMemcopy : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuBinarizeMemcopy(std::string name, int xSize, int ySize);
        ~GpuBinarizeMemcopy();
};

#endif
