#include "GpuBinarize.hpp"

GpuBinarize::GpuBinarize(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuBinarize::~GpuBinarize()  
{
}

double    GpuBinarize::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    gpu_binarise8<<<gridSize, blockSize>>>(image8bits, xSize, ySize, (unsigned char)BINARIZE_SEUIL, (unsigned char)BINARIZE_SEUIL_BAS, (unsigned char)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    return 0;
}


double    GpuBinarize::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    gpu_binarise16<<<gridSize, blockSize>>>(image16bits, xSize, ySize, (short)BINARIZE_SEUIL, (short)BINARIZE_SEUIL_BAS, (short)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    return 0;
}


