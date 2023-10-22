#include <stdio.h>

__global__ void gpu_binarise_copy8(unsigned char* imagecpu, unsigned char* imagegpu, int xSize, int ySize, unsigned char seuil, unsigned char valbas, unsigned char valhaut) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < xSize && y < ySize) {
        int idx = y * xSize + x;
        unsigned char pixel = imagecpu[idx];
        imagegpu[idx] = (pixel <= seuil) ? valbas : valhaut;
    }
}

__global__ void gpu_binarise_copy16(short* imagecpu, short *imagegpu, int xSize, int ySize, short seuil, short valbas, short valhaut) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < xSize && y < ySize) {
        int idx = y * xSize + x;
        short pixel = imagecpu[idx];
        imagegpu[idx] = (pixel <= seuil) ? valbas : valhaut;
    }
}
 


__global__ void gpu_binarise8(unsigned char* image, int xSize, int ySize, unsigned char seuil, unsigned char valbas, unsigned char valhaut) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < xSize && y < ySize) {
        int idx = y * xSize + x;
        unsigned char pixel = image[idx];
        image[idx] = (pixel <= seuil) ? valbas : valhaut;
    }
}

__global__ void gpu_binarise16(short* image, int xSize, int ySize, short seuil, short valbas, short valhaut) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

    if (x < xSize && y < ySize) {
        int idx = y * xSize + x;
        short pixel = image[idx];
        image[idx] = (pixel <= seuil) ? valbas : valhaut;
    }
}


__global__ void gpu_sobel8(unsigned char* image, int xSize, int ySize) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

	long mgrisH = 0;
	long mgrisV = 0;
	long mgris = 0;

    if (x > 0 && x < xSize - 1 && y > 0 && y < ySize - 1) {
        int idx = y * xSize + x;
        mgrisH = (unsigned char)*(image + ((y+1)*ySize) + (x-1))
				+ (2*(unsigned char)*(image + ((y+1)*ySize) + x))
				+ (unsigned char)*(image + ((y+1)*ySize) + (x+1))
                - (unsigned char)*(image + ((y-1)*ySize) + (x-1))
				- (2*(unsigned char)*(image + ((y-1)*ySize) + x))
				- (unsigned char)*(image + ((y-1)*ySize) + (x+1));
        mgrisV = (unsigned char)*(image + ((y-1)*ySize) + (x+1))
                - (unsigned char)*(image + ((y-1)*ySize) + (x-1))
                + (2*(unsigned char)*(image + (y*ySize) + (x+1)))
                - (2*(unsigned char)*(image + (y*ySize) + (x-1)))
				+ (unsigned char)*(image + ((y+1)*ySize) + (x+1))
				- (unsigned char)*(image + ((y+1)*ySize) + (x-1));
        mgris = abs(mgrisH) + abs(mgrisV);
        if(mgris>100)
            image[idx] = (unsigned char)100;
		else
            image[idx] = (unsigned char)(mgris);
    }
}

__global__ void gpu_sobel16(short* image, int xSize, int ySize) {
    int x = blockIdx.x * blockDim.x + threadIdx.x;
    int y = blockIdx.y * blockDim.y + threadIdx.y;

	long mgrisH = 0;
	long mgrisV = 0;
	long mgris = 0;

    if (x > 0 && x < xSize - 1 && y > 0 && y < ySize - 1) {
        int idx = y * xSize + x;
        mgrisH = (short)*(image + ((y+1)*ySize) + (x-1))
				+ (2*(short)*(image + ((y+1)*ySize) + x))
				+ (short)*(image + ((y+1)*ySize) + (x+1))
                - (short)*(image + ((y-1)*ySize) + (x-1))
				- (2*(short)*(image + ((y-1)*ySize) + x))
				- (short)*(image + ((y-1)*ySize) + (x+1));
        mgrisV = (short)*(image + ((y-1)*ySize) + (x+1))
                - (short)*(image + ((y-1)*ySize) + (x-1))
                + (2*(short)*(image + (y*ySize) + (x+1)))
                - (2*(short)*(image + (y*ySize) + (x-1)))
				+ (short)*(image + ((y+1)*ySize) + (x+1))
				- (short)*(image + ((y+1)*ySize) + (x-1));
        mgris = abs(mgrisH) + abs(mgrisV);
        if(mgris>100)
            image[idx] = (short)100;
		else
            image[idx] = (short)(mgris);
    }
}
