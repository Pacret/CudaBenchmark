#include "Bench.hpp"

Bench::Bench(std::string name, int xSize, int ySize) : name(name), xSize(xSize), ySize(ySize)
{
    cudaMallocManaged(&image8bits, sizeof(unsigned char) * (xSize * ySize));
    cudaMallocManaged(&image16bits, sizeof(short) * (xSize * ySize));
}


Bench::~Bench()
{
    cudaFree(image8bits);
    cudaFree(image16bits);
}

void    Bench::randomizeImage()
{
    int imageSize = xSize * ySize;
    srand(time(NULL));
    for (int i = 0; i < imageSize; i++)
    {
        image8bits[i] = rand() % 256;
        image16bits[i] = rand() % 65536;
    }
}

bool    Bench::verifyImageValues()
{
    // for (size_t y = 0; y < ySize; y++)
    // {
    //     for (size_t x = 0; x < xSize; x++)
    //     {
    //         int index = y * xSize + x;
    //         if ((image8bits[index] != BINARIZE_SEUIL_BAS && image8bits[index] != BINARIZE_SEUIL_HAUT)
    //         || (image16bits[index] != BINARIZE_SEUIL_BAS && image16bits[index] != BINARIZE_SEUIL_HAUT))
    //         {

    //             if (x > 0 && x < xSize - 2 && y > 0 && y < ySize - 2)
    //             {
    //                 std::cout << "pas bon a " << x << ", " << y << std::endl;
    //                 if (image8bits[index] != SOBEL_GREY_VALUE || image16bits[index] != SOBEL_GREY_VALUE)
    //                     return false;
    //             }
    //         }

    //     }
    // }
    return true;
}

void    Bench::benchmark()
{
    for (int i = 0; i < N_BENCHMARK; i++)
    {
        randomizeImage();

        auto before8bits = system_clock::now();
        double toSubstract = process8bits(); 

        millisec t8bits = std::chrono::system_clock::now() - before8bits;
        double c = (t8bits.count()) - toSubstract;
        times8bits.push_back(c);
        duration8bits += c;

        auto before16bits = system_clock::now();
        toSubstract = process16bits();

        millisec t16bits = std::chrono::system_clock::now() - before16bits;
        c = (t16bits.count()) - toSubstract;
        times16bits.push_back(c);
        duration16bits += c;

    }
    bool noError = verifyImageValues();
    if (!noError)
        std::cout << name <<  " datas not correct" << std::endl;
    duration8bits -= times8bits[0];
    duration8bits /= (N_BENCHMARK - 1);

    duration16bits -= times16bits[0];
    duration16bits /= (N_BENCHMARK - 1);
}