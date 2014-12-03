#include <stdio.h>
#include "sigmac.h"

int main ()
{

	char func[] = "extsigma";
	char *funcPtr = func;
    int nArgs = 3;
    int blockSize = 1;
    double inReal[3][1];
    double inImag[3][1];
    double outReal[3][1];
    double outImag[3][1];

  	int stat = 0;

	stat = eval (funcPtr, nArgs, 
					inReal, inImag, blockSize, 
					outReal, outImag);
	return 0;
}
