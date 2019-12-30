!
! Copyright (c) 2019 V.Shishkin
!
! Модуль для динамической точности
!
module my_prec
  implicit none
  integer, parameter :: mp = 4
  real(mp), parameter :: eps = 10e-8
  integer, parameter :: m_size =1000
  integer, parameter :: row = 4000
  integer, parameter :: col = 4000
  integer, parameter :: threads_number = 1
end module my_prec
