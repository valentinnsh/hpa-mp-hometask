!
! Copyright (c) 2019 V.Shishkin
!


program  tester
  use my_prec
  use minmaxfinder
  use matrixvectormult
  use strfinder
  use mymatmul
  use omp_lib
  implicit none

  integer :: i
  real(mp) :: start, finish, val
  real(mp), allocatable, dimension(:,:) :: matrix
  real(mp), allocatable, dimension(:,:) :: A, mulres, matrixA, matrixB
  real(mp), allocatable, dimension(:) :: B, res, res2
  character(1) :: taskname
  character(100) :: mystr
  ! получаем номер задания которое будем тестировать

  i = 0

  print *, row, col
  !taskname = '1'
  call getarg(1,taskname)
  select case(taskname)
  case('1')
     ! Поиск максимума среди минимумов в строках матрицы
     allocate(matrix(m_size,m_size));
     call random_number(matrix)
     call cpu_time(start)
     val = max_min_row_el(matrix)
     call cpu_time(finish)
     print *, "Max Min in rows = ", val
     print *, "Calculated in ", finish-start, " sec"

  case('2')
     print *, 'go'
     allocate(mulres(row,row)); allocate(matrixA(row,col)); allocate(matrixB(col,row));
     call RANDOM_NUMBER(matrixA)
     call RANDOM_NUMBER(matrixB)

     call cpu_time(start)
     call mat_mul(matrixA, matrixB, mulres)
     !write(*,*) norm2(res - matmul(matrix,matrix))/m_size**2
     call cpu_time(finish)
     print *, "Calculated in ", finish-start, " sec"
  case('3')
     ! Умножение матрицы на вектор
     allocate(A(row,col));  allocate(B(col)); allocate(res(row)); allocate(res2(row))
     call RANDOM_NUMBER(A)
     call RANDOM_NUMBER(B)
     print *, 'srt'
     call cpu_time(start)
     res = mult_div_by_rows(A,B)
     call cpu_time(finish)
     print *, "div by rows Calculated in ", finish-start, " sec"

     call cpu_time(start)
     res2 = mult_div_by_cols(A,B)
     call cpu_time(finish)
     print *, "div by cols Calculated in ", finish-start, " sec"

     call cpu_time(start)
     res2 = mult_by_blocks(A,B)
     call cpu_time(finish)
     print *, "div by blocks Calculated in ", finish-start, " sec"

     print *, 'norm(dib dy row - div by col) = ', norm2(res2-res)/row, 'if -> zero calculation is aqqurate'


  case('4')
     print *, 'In progress. Will appear very soon, I promice!'
  case('5')
     ! Поиск подстроки в файле с использованием параллельных директив

     mystr = "math"
     call cpu_time(start)
     call find_in_file(trim(mystr))
     call cpu_time(finish)
     print *, trim(mystr), " found in ", finish-start, " sec"

  end select


end program
