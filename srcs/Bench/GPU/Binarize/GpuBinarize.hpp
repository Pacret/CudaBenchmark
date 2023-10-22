
#ifndef GPU_BINARIZE_HPP
# define GPU_BINARIZE_HPP

#include "../../Bench.hpp"

class GpuBinarize : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuBinarize(std::string name, int xSize, int ySize);
        ~GpuBinarize();
};

#endif
