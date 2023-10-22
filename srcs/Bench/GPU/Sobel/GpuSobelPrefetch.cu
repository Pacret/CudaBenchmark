#include "GpuSobelPrefetch.hpp"

GpuSobelPrefetch::GpuSobelPrefetch(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuSobelPrefetch::~GpuSobelPrefetch()  
{
}


double    GpuSobelPrefetch::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    int device = -1;
    cudaGetDevice(&device);

    cudaMemPrefetchAsync(image8bits, xSize * ySize * sizeof(unsigned char), device, NULL);
    gpu_sobel8<<<gridSize, blockSize>>>(image8bits, xSize, ySize);
    cudaDeviceSynchronize();
    return 0;
}

double    GpuSobelPrefetch::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    int device = -1;
    cudaGetDevice(&device);
    cudaMemPrefetchAsync(image16bits, xSize * ySize * sizeof(short), device, NULL);
    gpu_sobel16<<<gridSize, blockSize>>>(image16bits, xSize, ySize);
    cudaDeviceSynchronize();
    return 0;
}