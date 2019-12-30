files=$(filter-out $(test), $(wildcard *.f90))
obj=$(patsubst %.f90, %.o, $(files))
n = 1000000
#files=$(wildcard *.f90)
#obj=$(patsubst %.f90, %.o, $(files))
#flags = -c -Wall -fopenmp -fbounds-check

#result: tester
#	./tester
#tester: $(obj)
#	gfortran $^ -o $@
# %.o: %.f90
# 	gfortran $(flags) $< -o $@
result: clean run2
main: $(obj)
	gfortran -fopenmp $^  -o  $@
%.o %.mod: %.f90
	gfortran -fopenmp -c $<
tester.o: my_prec.mod mymatmul.mod minmaxfinder.mod matrixvectormult.mod
minmaxfinder.o: my_prec.mod
matrixvectormult.o: my_prec.mod
mymatmul.o: my_prec.mod
clean:
	rm -f *.o *.mod main
run1: main
	./main 1
run2: main
	./main 2
run3: main
	./main 3
run5: main
	./main 5
