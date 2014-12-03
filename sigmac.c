#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
 
#ifdef _MSC_VER
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif
 
static const char *error = NULL;
 
EXPORT int init(const char *str) {
  return 1;
}
 
EXPORT const char * getLastError() {
  return error;
}
 
EXPORT int eval(const char *func,
                              int nArgs,
                              const double **inReal,
                              const double **inImag,
                              int blockSize,
                              double *outReal,
                              double *outImag) {
  int i, j;
 
  if (strcmp("extsinc", func) == 0) {
    if (nArgs != 1) {
      error = "one argument expected";
      return 0;
    }
    for (i = 0; i < blockSize; i++) {
      double x = inReal[0][i];
      outReal[i] = (x == 0) ? 1 : sin(x) / x;
    }
    return 1;
  }
  else if (strcmp("extsigma", func) == 0) {

    if (nArgs != 6) {
      error = "Six arguments expected: wrf, n_m3, Z, amu, bMag, nuOmg";
      return 0;
    }

    FILE *ofp;
    char outputFilename[] = "sigma.log";
    ofp = fopen(outputFilename,"w");
    fprintf(ofp,"%s\n","TESTING");
    double test = 4.0;
    fprintf(ofp,"%s %f\n","Test double:", test);
           
    double _Complex sigma_stix[3][3];

    for (i = 0; i < blockSize; i++) {

      double wrf = inReal[0][i];
      double n_m3 = inReal[1][i];
      double Z = inReal[2][i];
      double amu = inReal[3][i];
      double bMag = inReal[4][i];
      double nuOmg = inReal[5][i];
    
      fprintf(ofp,"%s %f\n","wrf: ", wrf);
      fprintf(ofp,"%s %f\n","n_m3: ", n_m3);
      fprintf(ofp,"%s %f\n","Z: ", Z);
      fprintf(ofp,"%s %f\n","amu: ", amu);
      fprintf(ofp,"%s %f\n","bMag: ", bMag);
      fprintf(ofp,"%s %f\n","nuOmg: ", nuOmg);

      sigma_cold(wrf, n_m3, Z, amu, bMag, nuOmg, sigma_stix);

    }

    fprintf(ofp,"\n");
    fclose(ofp);

    return 1;
  }
  else {
    error = "Unknown function :)";
    return 0;
  }
}
