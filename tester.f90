!
! Copyright (c) 2019 V.Shishkin
!


program  tester
  use my_prec
  use minmaxfinder
  !use omp_lib
  implicit none

  integer :: i
  real(mp) :: start, finish, val
  real(mp) :: matrix(m_size,m_size)
  character(1) :: taskname
  ! получаем номер задания которое будем тестировать

  i = 0
  taskname = '1'
  !call getarg(1,taskname)
  select case(taskname)
  case('1')
     matrix = 1
     matrix(5,:) = 2
     !print *, matrix
     call cpu_time(start)
     val = max_min_row_el(matrix)
     call cpu_time(finish)
     print *, "Max Min in rows = ", val
     print *, "Calculated in ", finish-start, " sec"
  end select


end program
