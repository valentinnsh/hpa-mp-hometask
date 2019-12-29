!
! Copyright (c) 2019 V.Shishkin
!


program  tester
  use my_prec
  use minmaxfinder
  use matrixvectormult
  implicit none

  integer :: i
  real(mp) :: start, finish, val
  real(mp) :: matrix(m_size,m_size)
  real(mp), allocatable, dimension(:,:) :: A
  real(mp), allocatable, dimension(:) :: B, res, res2
  character(1) :: taskname
  ! получаем номер задания которое будем тестировать

  i = 0
  print *, row, col
  allocate(A(row,col));  allocate(B(col)); allocate(res(row)); allocate(res2(row))
  A = 0; B = 0; res = 0
  !taskname = '1'
  call getarg(1,taskname)
  select case(taskname)
  case('1')
     call random_number(matrix)
     call cpu_time(start)
     val = max_min_row_el(matrix)
     call cpu_time(finish)
     print *, "Max Min in rows = ", val
     print *, "Calculated in ", finish-start, " sec"
  case('3')
     call RANDOM_NUMBER(A)
     call RANDOM_NUMBER(B)

     call cpu_time(start)
     res = mult_div_by_rows(A,B)
     call cpu_time(finish)
     print *, "div by rows Calculated in ", finish-start, " sec"

     call cpu_time(start)
     res2 = mult_div_by_cols(A,B)
     call cpu_time(finish)
     print *, "div by cols Calculated in ", finish-start, " sec"

     res2 = matmul(A,B)
     print *, norm2(res2-res)
  end select


end program
