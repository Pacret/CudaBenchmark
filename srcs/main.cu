#include "includes.hpp"
#include "Bench/CPU/CpuBinarize.hpp"
#include "Bench/CPU/CpuSobel.hpp"
#include "Bench/CPU/CpuErosion.hpp"
#include "Bench/GPU/Binarize/GpuBinarize.hpp"
#include "Bench/GPU/Binarize/GpuBinarizeCopy.hpp"
#include "Bench/GPU/Binarize/GpuBinarizePrefetch.hpp"
#include "Bench/GPU/Binarize/GpuBinarizeMemcopy.hpp"
#include "Bench/GPU/Binarize/GpuBinarizeMemcopyNotCount.hpp"
#include "Bench/GPU/Sobel/GpuSobel.hpp"
#include "Bench/GPU/Sobel/GpuSobelPrefetch.hpp"
#include "Bench/GPU/Sobel/GpuSobelMemcopy.hpp"
#include "Bench/GPU/Sobel/GpuSobelMemcopyNotCount.hpp"


void        displayConsole(std::vector<Bench *> benchs)
{
    for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
        (*it)->benchmark();

    std::sort(benchs.begin(), benchs.end(), [](Bench *r1, Bench *r2) -> bool {
                                          return r1->duration8bits > r2->duration8bits; });
   for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
    {
        int max = min((int)(*it)->times8bits.size(), 10);
        std::cout << (*it)->times8bits[0] << std::endl;
        std::cout << (*it)->name << " (" << (*it)->xSize << ", " << (*it)->ySize << ") : " << std::endl;
        std::cout << "      8 bits : " << (*it)->duration8bits << " ms      (";
        for (int i = 0; i < max; i++)
        {
            std::cout << (*it)->times8bits[i];
            if (i != max - 1)
                std::cout << ", ";
        }
        std::cout << ")" << std::endl;
        std::cout << "     16 bits : " << (*it)->duration16bits << " ms     (";
        for (int i = 0; i < max; i++)
        {
            std::cout << (*it)->times16bits[i];
            if (i != max - 1)
                std::cout << ", ";
        }
        std::cout << ")" << std::endl;
    }
}

void        displayCsv(std::vector<Bench *> benchs, int c)
{
    for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
        (*it)->benchmark();

    int i = 0;
    std::vector<std::string> lines;
    for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
    {

        if (i < c)
        {
            lines.push_back((*it)->name + " 8 bits, " + std::to_string((*it)->duration8bits) + ", ");
        }
        else
            lines[i % c] += std::to_string((*it)->duration8bits) + ", ";
        i++;
    }
    for (auto it = lines.crbegin(); it != lines.crend(); ++it)
    {
        std::cout << *(it) << std::endl;
    }
    i = 0;
    lines.clear();
    for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
    {
        if (i < c)
        {
            lines.push_back((*it)->name + " 16 bits, " + std::to_string((*it)->duration16bits) + ", ");
        }
        else
        {
            lines[i % c] += std::to_string((*it)->duration16bits) + ", ";
        }
        i++;
    }
    for (auto it = lines.crbegin(); it != lines.crend(); ++it)
    {
        std::cout << *(it) << std::endl;
    }
}

int main()
{
    std::cout << "Start benchmark" << std::endl;
    // int xSize = 2048;
    // int ySize = 32;

    std::vector<Bench *> benchs;

    for (int i = 64; i <= 4096; i+=64)
    {
        std::cout << i << " x " << i << " = " << i*i << ", ";
        benchs.push_back(new GpuBinarizeMemcopyNotCount("GPU Binarize memcopy not count", i, i));
        benchs.push_back(new GpuBinarizePrefetch("GPU Binarize prefetch", i, i));
        benchs.push_back(new GpuBinarize("GPU Binarize", i, i));
        benchs.push_back(new CpuBinarize("CPU Binarize", i, i));
        benchs.push_back(new GpuSobel("GPU Sobel", i, i));
        benchs.push_back(new GpuSobelPrefetch("GPU Sobel prefetch", i, i));
        benchs.push_back(new GpuSobelMemcopy("GPU Sobel memcopy ", i, i));
        benchs.push_back(new GpuSobelMemcopyNotCount("GPU Sobel memcopy not count", i, i));
        benchs.push_back(new CpuSobel("CPU Sobel", i, i));
    }
    std::cout << std::endl;


    // for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
    // {
    //     int imageSize = (*(it))->xSize * (*(it))->ySize;
    //     auto before = system_clock::now();
    //     for (int i = 0; i < imageSize; i++)
    //     {
    //         (*(it))->image8bits[i] = rand() % 256;
    //     }
    //     millisec t = std::chrono::system_clock::now() - before;
    //     std::cout << "acces to value " << (*it)->name << " after calcul take : " << t.count() << " ms" << std::endl;
    // }


    // benchs.push_back(new CpuErosion("CPU Erosion", xSize, ySize));

    displayCsv(benchs, 9);
    //displayConsole(benchs);

    for (auto it = benchs.crbegin(); it != benchs.crend(); ++it)
        delete *it;
    return 0;
}