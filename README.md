Working through CUDA Examples

http://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html

Note: writing C code with CUDA requires using the nvcc compiler wrapper and 
[labeling files that contains CUDA C extensions with the .cu suffix](http://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc/#supported-input-file-suffixes).
Without this suffix nvcc treats the file as ordinary .c, passes the build
to the C compiler and throws warnings on the C extensions.

Builing CUDA code is simple:

nvcc program.cu

There are no special directives needed in the code.  The nvcc wrapper takes care
of the managing the build steps.  See the [CUDA Compiler Driver](http://docs.nvidia.com/cuda/cuda-compiler-driver-nvcc) 
for details.

== Vectors ==

The vec-add program takes a vector size argument as input. Initializes two vectors with random values,
adds the elements and returns the result.  The DEBUG directive allows inspection of resutls for verifying
operations and inspecting results.  It's only meaninful for arrays with a hand full of elements.

The nvprof and cuda-memcheck wrappers provide useful stats about the operation of the code 
and it's resource utilization.