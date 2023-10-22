#include "GpuSobel.hpp"

GpuSobel::GpuSobel(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuSobel::~GpuSobel()  
{
}

double    GpuSobel::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    gpu_sobel8<<<gridSize, blockSize>>>(image8bits, xSize, ySize);
    cudaDeviceSynchronize();
    return 0;
}


double    GpuSobel::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    gpu_sobel16<<<gridSize, blockSize>>>(image16bits, xSize, ySize);
    cudaDeviceSynchronize();
    return 0;
}


