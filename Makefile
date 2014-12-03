CC = gcc
F90 = gfortran
F90FLAGS = -g
CFLAGS = -g -fPIC
LDFLAGS = -lgfortran

sigma.so: sigmac.c sigma.F90 constants.f90
	$(CC) -c sigmac.c -o sigmac.o ${CFLAGS}
	$(F90) -c constants.f90 ${F90FLAGS}
	$(F90) -c sigma.F90 ${F90FLAGS}
	$(CC) -shared sigmac.o sigma.o constants.o -o sigma.so $(LDFLAGS) ${CFLAGS}

test: sigmac.c sigma.F90 constants.f90 test.c
	$(CC) -c sigmac.c -o sigmac.o  ${CFLAGS}
	$(F90) -c constants.f90 ${F90FLAGS}
	$(F90) -c sigma.F90 ${F90FLAGS}
	$(CC) test.c sigmac.o sigma.o constants.o -o test $(LDFLAGS) ${CFLAGS}

clean:
	rm *.o *.so *.mod test
