#include "GpuBinarizeCopy.hpp"

GpuBinarizeCopy::GpuBinarizeCopy(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuBinarizeCopy::~GpuBinarizeCopy()  
{
}

double    GpuBinarizeCopy::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    unsigned char *image8bitsCOPY;
    cudaMallocManaged(&image8bitsCOPY, sizeof(unsigned char) * (xSize * ySize));

    gpu_binarise_copy8<<<gridSize, blockSize>>>(image8bits, image8bitsCOPY, xSize, ySize, (unsigned char)BINARIZE_SEUIL, (unsigned char)BINARIZE_SEUIL_BAS, (unsigned char)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    cudaFree(image8bitsCOPY);
    return 0;
}


double    GpuBinarizeCopy::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    short *image16bitsCOPY;
    cudaMallocManaged(&image16bitsCOPY, sizeof(short) * (xSize * ySize));

    gpu_binarise_copy16<<<gridSize, blockSize>>>(image16bits, image16bitsCOPY, xSize, ySize, (short)BINARIZE_SEUIL, (short)BINARIZE_SEUIL_BAS, (short)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    cudaFree(image16bitsCOPY);
    return 0;
}


