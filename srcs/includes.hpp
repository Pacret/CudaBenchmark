#ifndef INCLUDES_HPP
# define INCLUDES_HPP

#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <cstdlib>
#include <random>
#include <chrono>
#include <iostream>
#include <vector>
#include <string.h>
#include <algorithm>

#include <time.h>

#define N_BENCHMARK 20


#define BINARIZE_SEUIL 50
#define BINARIZE_SEUIL_BAS 0
#define BINARIZE_SEUIL_HAUT 255
#define SOBEL_GREY_VALUE 100
#define TAILLE_NOYAU_MAX 10

using millisec = std::chrono::duration<double, std::milli>;
using sec = std::chrono::duration<double>;
using namespace std::chrono;

__global__ void gpu_binarise8(unsigned char* image, int xSize, int ySize, unsigned char seuil, unsigned char valbas, unsigned char valhaut);
__global__ void gpu_binarise16(short* image, int xSize, int ySize, short seuil, short valbas, short valhaut);
__global__ void gpu_binarise_copy8(unsigned char *imagecpu, unsigned char *imagegpu, int xSize, int ySize, unsigned char seuil, unsigned char valbas, unsigned char valhaut); 
__global__ void gpu_binarise_copy16(short* imagecpu, short *imagegpu, int xSize, int ySize, short seuil, short valbas, short valhaut); 
__global__ void gpu_sobel8(unsigned char* image, int xSize, int ySize);
__global__ void gpu_sobel16(short* image, int xSize, int ySize);

#endif