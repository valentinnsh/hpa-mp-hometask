!
! Copyright (c) 2019 V.Shishkin
!


module minmaxfinder
  use my_prec
  implicit none
contains

  function max_min_row_el(A) result(res)
    real(mp), intent(in) :: A(m_size,m_size)
    real(mp), dimension(size(A, dim = 1)):: mins
    real(mp) :: res
    integer :: i,j

    j = 0
    do i = 1, m_size
       !print *, A(i, :)
       mins(i) = minval(A(i,1:m_size))
     !  do j = 1, m_size

      ! end do

    end do

    res = maxval(mins)

  end function max_min_row_el


end module minmaxfinder
