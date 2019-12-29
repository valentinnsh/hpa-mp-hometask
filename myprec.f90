!
! Copyright (c) 2019 V.Shishkin
!
! Модуль для динамической точности
!
module my_prec
  implicit none
  integer, parameter :: mp = 8
  real(mp), parameter :: eps = 10e-8
  integer, parameter :: m_size = 10000
end module my_prec
