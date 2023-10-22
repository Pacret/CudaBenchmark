#include "GpuBinarizePrefetch.hpp"

GpuBinarizePrefetch::GpuBinarizePrefetch(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuBinarizePrefetch::~GpuBinarizePrefetch()  
{
}


double    GpuBinarizePrefetch::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    int device = -1;
    cudaGetDevice(&device);

    cudaMemPrefetchAsync(image8bits, xSize * ySize * sizeof(unsigned char), device, NULL);
    gpu_binarise8<<<gridSize, blockSize>>>(image8bits, xSize, ySize, (unsigned char)BINARIZE_SEUIL, (unsigned char)BINARIZE_SEUIL_BAS, (unsigned char)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    return 0;
}

double    GpuBinarizePrefetch::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    int device = -1;
    cudaGetDevice(&device);
    cudaMemPrefetchAsync(image16bits, xSize * ySize * sizeof(short), device, NULL);
    gpu_binarise16<<<gridSize, blockSize>>>(image16bits, xSize, ySize, (short)BINARIZE_SEUIL, (short)BINARIZE_SEUIL_BAS, (short)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    return 0;
}