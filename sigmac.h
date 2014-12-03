#ifdef _MSC_VER
#define EXPORT __declspec(dllexport)
#else
#define EXPORT
#endif
 
EXPORT int eval(const char *func,
                              int nArgs,
                              const double **inReal,
                              const double **inImag,
                              int blockSize,
                              double *outReal,
                              double *outImag)
