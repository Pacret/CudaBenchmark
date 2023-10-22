NAME		= benchmark

SRCS		= srcs/main.cu \
			 srcs/Algo.cu \
		  	 srcs/Bench/Bench.cu \
			 srcs/Bench/CPU/CpuBinarize.cu \
			 srcs/Bench/CPU/CpuSobel.cu \
			 srcs/Bench/CPU/CpuErosion.cu \
			 srcs/Bench/GPU/Binarize/GpuBinarize.cu \
			 srcs/Bench/GPU/Binarize/GpuBinarizeCopy.cu \
			 srcs/Bench/GPU/Binarize/GpuBinarizePrefetch.cu \
			 srcs/Bench/GPU/Binarize/GpuBinarizeMemcopy.cu \
			 srcs/Bench/GPU/Binarize/GpuBinarizeMemcopyNotCount.cu \
			 srcs/Bench/GPU/Sobel/GpuSobelMemcopy.cu \
			 srcs/Bench/GPU/Sobel/GpuSobelPrefetch.cu \
			 srcs/Bench/GPU/Sobel/GpuSobelMemcopyNotCount.cu \
			 srcs/Bench/GPU/Sobel/GpuSobel.cu




CXX		= nvcc

CXXFLAGS	= --std c++17 -O3

RM		= rm -rf

$(NAME):
	 $(CXX) $(CXXFLAGS) $(SRCS) -o $(NAME) -run

all: $(NAME)

clean:
	$(RM) $(NAME)

re: clean all

.PHONY:	all clean re