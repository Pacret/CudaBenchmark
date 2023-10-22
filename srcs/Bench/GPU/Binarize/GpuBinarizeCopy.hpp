
#ifndef GPU_BINARIZE_COPY_HPP
# define GPU_BINARIZE_COPY_HPP

#include "../../Bench.hpp"

class GpuBinarizeCopy : public Bench
{
    protected:
        double process8bits();
        double process16bits();
    public:
        GpuBinarizeCopy(std::string name, int xSize, int ySize);
        ~GpuBinarizeCopy();
};

#endif
