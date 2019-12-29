!
! Copyright (c) 2019 V.Shishkin
!


module minmaxfinder
  use my_prec
  use omp_lib
  implicit none
contains

  function max_min_row_el(A) result(res)
    real(mp), intent(in) :: A(m_size,m_size)
    real(mp), dimension(size(A, dim = 1)):: mins
    real(mp) :: res
    integer :: i, j

    call omp_set_num_threads(threads_number)

    !$omp parallel shared(mins, A) default(private)
    !$omp do schedule(dynamic)

    do i = 1, m_size
       mins(i) = minval(A(i,1:m_size))
    end do

    !$omp end do
    !$omp end parallel

    res = maxval(mins)

  end function max_min_row_el


end module minmaxfinder
