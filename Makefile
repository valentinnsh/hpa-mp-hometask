files=$(filter-out $(test), $(wildcard *.f90))
obj=$(patsubst %.f90, %.o, $(files))
#files=$(wildcard *.f90)
#obj=$(patsubst %.f90, %.o, $(files))
#flags = -c -Wall -fopenmp -fbounds-check
res: result

#result: tester
#	./tester
#tester: $(obj)
#	gfortran $^ -o $@
# %.o: %.f90
# 	gfortran $(flags) $< -o $@
result: main
	./main
main: $(obj)
	gfortran $^  -o  $@
%.o %.mod: %.f90
	gfortran -c $<
tester.o: minmaxfinder.mod my_prec.mod
minmaxfinder.o: my_prec.mod
clean:
	rm -f *.o main
#run1:
#	./main
