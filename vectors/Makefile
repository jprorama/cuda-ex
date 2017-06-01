# Build file for CUDA examples
#
# based on example 3,4,5 from http://www.cs.colby.edu/maxwell/courses/tutorials/maketutor/
#

CC=nvcc
CFLAGS=

# target-specific variables for debug build
# http://stackoverflow.com/a/1080180
debug: CFLAGS=-DDEBUG

all: vec-add

debug: all

vec-add: vec-add.cu
	$(CC) -o $@ $^ $(CFLAGS)
