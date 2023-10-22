#include "CpuBinarize.hpp"

CpuBinarize::CpuBinarize(std::string name, int xSize, int ySize) : Bench(name, xSize, ySize)
{
}

CpuBinarize::~CpuBinarize()  
{
}

void cpu_binarise8(
    unsigned char* image,
    int xSize,
    int ySize,
    unsigned char seuil,
    unsigned char valbas,
    unsigned char valhaut)
{
    long x, y;
    unsigned char* lpLine = NULL;
    unsigned char* lpPix = NULL;


    lpLine = image;
    for (y = 0; y < ySize; y++) {
        lpPix = lpLine;
        for (x = 0; x < xSize; x++) {
            if ((unsigned char)*lpPix <= seuil)
                *lpPix = valbas;
            else
                *lpPix = valhaut;
            lpPix = lpPix + 1;
        }
        lpLine = lpLine + xSize;
    }
}

double    CpuBinarize::process8bits()
{
    cpu_binarise8(image8bits, xSize, ySize, (unsigned char)BINARIZE_SEUIL, (unsigned char)BINARIZE_SEUIL_BAS, (unsigned char)BINARIZE_SEUIL_HAUT);
    return 0;
}


void cpu_binarise16(
    short* image,
    int xSize,
    int ySize,
    short seuil,
    short valbas,
    short valhaut)
{
    long x, y;
    short * lpLine = NULL;
    short * lpPix = NULL;


    lpLine = image;
    for (y = 0; y < ySize; y++) {
        lpPix = lpLine;
        for (x = 0; x < xSize; x++) {
            if ((short)*lpPix <= seuil)
                *lpPix = valbas;
            else
                *lpPix = valhaut;
            lpPix = lpPix + 1;
        }
        lpLine = lpLine + xSize;
    }
}

double    CpuBinarize::process16bits()
{
    cpu_binarise16(image16bits, xSize, ySize, (short)BINARIZE_SEUIL, (short)BINARIZE_SEUIL_BAS, (short)BINARIZE_SEUIL_HAUT);
    return 0;
}


