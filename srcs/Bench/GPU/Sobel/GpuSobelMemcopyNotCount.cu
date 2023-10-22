#include "GpuSobelMemcopyNotCount.hpp"

GpuSobelMemcopyNotCount::GpuSobelMemcopyNotCount(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

GpuSobelMemcopyNotCount::~GpuSobelMemcopyNotCount()  
{
}


double    GpuSobelMemcopyNotCount::process8bits()
{
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);
    

    auto before = system_clock::now();
    unsigned char *image8bitsCOPY;
    
    cudaMallocManaged(&image8bitsCOPY, sizeof(unsigned char) * (xSize * ySize));
    cudaMemcpy(image8bits, image8bitsCOPY, sizeof(unsigned char) * xSize * ySize, cudaMemcpyDefault); 
    millisec t = std::chrono::system_clock::now() - before;

    double ret = t.count();
    gpu_sobel8<<<gridSize, blockSize>>>(image8bitsCOPY, xSize, ySize);
    cudaDeviceSynchronize();
    cudaFree(image8bitsCOPY);
    return ret;
}

double    GpuSobelMemcopyNotCount::process16bits()
{    
    dim3 blockSize(16, 16);
    dim3 gridSize((xSize + blockSize.x - 1) / blockSize.x, (ySize + blockSize.y - 1) / blockSize.y);

    auto before = system_clock::now();
    short *image16bitsCOPY;
    cudaMallocManaged(&image16bitsCOPY, sizeof(short) * (xSize * ySize));
    cudaMemcpy(image16bits, image16bitsCOPY, sizeof(short) * xSize * ySize, cudaMemcpyDefault); 
    millisec t = std::chrono::system_clock::now() - before;
    double ret = t.count();

    gpu_sobel16<<<gridSize, blockSize>>>(image16bitsCOPY, xSize, ySize);

    cudaDeviceSynchronize();
    cudaFree(image16bitsCOPY);
    return ret;
}