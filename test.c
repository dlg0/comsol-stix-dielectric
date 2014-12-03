#include <stdio.h>
#include "sigmac.h"

int main ()
{

	char func[] = "extsigma";
	char *funcPtr = func;
    int nArgs = 3; // each function eval has its own set of inputs
    int blockSize = 1; // number of individual function evals
    int i;

    // Allocate some memory like Comsol probably does
    double **inReal=(double **) malloc(nArgs*sizeof(double *));
    for(i=0;i<nArgs;i++)inReal[i]=(double *)malloc(blockSize*sizeof(double *));
    double **inImag=(double **) malloc(nArgs*sizeof(double *));
    for(i=0;i<nArgs;i++)inImag[i]=(double *)malloc(blockSize*sizeof(double *));
 
    double *outReal=(double *) malloc(blockSize*sizeof(double *));
    double *outImag=(double *) malloc(blockSize*sizeof(double *));

  	int stat = 0;

    double wrf = 600e6;
    double n_m3 = 1e19;
    double Z = 1;

    inReal[0][0] = wrf;
    inReal[1][0] = n_m3;
    inReal[2][0] = Z;

    inImag[0][0] = 0;
    inImag[1][0] = 0;
    inImag[2][0] = 0;


	stat = eval (funcPtr, nArgs, 
                    (double **)inReal, (double **)inImag, 
                    blockSize, 
                    (double *)outReal, (double *)outImag);
	return 0;
}
