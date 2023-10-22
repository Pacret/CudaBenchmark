#include "GpuBinarizeMemcopy.hpp"

GpuBinarizeMemcopy::GpuBinarizeMemcopy(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuBinarizeMemcopy::~GpuBinarizeMemcopy()  
{
}


double    GpuBinarizeMemcopy::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    
    unsigned char *image8bitsCOPY;
    cudaMallocManaged(&image8bitsCOPY, sizeof(unsigned char) * (xSize * ySize));

    cudaMemcpyAsync(image8bits, image8bitsCOPY, sizeof(unsigned char) * xSize * ySize, cudaMemcpyDefault); 
    
    gpu_binarise8<<<gridSize, blockSize>>>(image8bitsCOPY, xSize, ySize, (unsigned char)BINARIZE_SEUIL, (unsigned char)BINARIZE_SEUIL_BAS, (unsigned char)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    cudaFree(image8bitsCOPY);
    return 0;
}

double    GpuBinarizeMemcopy::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);

    short *image16bitsCOPY;
    cudaMallocManaged(&image16bitsCOPY, sizeof(short) * (xSize * ySize));

    cudaMemcpy(image16bits, image16bitsCOPY, sizeof(short) * xSize * ySize, cudaMemcpyDefault); 

    gpu_binarise16<<<gridSize, blockSize>>>(image16bitsCOPY, xSize, ySize, (short)BINARIZE_SEUIL, (short)BINARIZE_SEUIL_BAS, (short)BINARIZE_SEUIL_HAUT);
    cudaDeviceSynchronize();
    cudaFree(image16bitsCOPY);
    return 0;
}