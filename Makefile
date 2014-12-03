CC = gcc
F90 = gfortran
F90FLAGS = 
CFLAGS = -lgfortran -g 

sigma.so: sigmac.c sigma.F90 constants.f90
	$(CC) -c sigmac.c -o sigmac.o 
	$(F90) -c constants.f90 
	$(F90) -c sigma.F90
	$(CC) -shared sigmac.o sigma.o constants.o -o sigma.so $(CFLAGS)

test: sigmac.c sigma.F90 constants.f90 test.c
	$(CC) -c sigmac.c -o sigmac.o 
	$(F90) -c constants.f90 
	$(F90) -c sigma.F90
	$(CC) test.c sigmac.o sigma.o constants.o -o test $(CFLAGS)

clean:
	rm *.o *.so *.mod test
