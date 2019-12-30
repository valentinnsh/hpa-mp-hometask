!
! Copyright (c) 2019 V.Shishkin
!


module  matrixvectormult
  use my_prec
  use omp_lib
implicit none
contains
  function mult_div_by_rows(A,B) result(res)
    real(mp), dimension(:,:) :: A
    real(mp), dimension(:) :: B
    real(mp), allocatable, dimension(:) :: res

    integer :: i,j

    allocate(res(row))

    call omp_set_num_threads(threads_number)

    !$omp parallel shared(A,B) default(private) reduction(+: res)

    !$omp do schedule(guided)
    do i = 1, row
       res(i) = dot_product(A(i,:), B)
    end do
    !$omp end do
    !$omp end parallel

  end function mult_div_by_rows

  function mult_div_by_cols(A,B) result(res)
    real(mp), dimension(:,:) :: A
    real(mp), dimension(:) :: B
    real(mp), allocatable, dimension(:) :: res

    integer :: i,j

    allocate(res(row))
    call omp_set_num_threads(threads_number)

    res = 0
    !$omp parallel shared(A,B) default(private)  reduction(+: res)
    !$omp do schedule(auto)
    do j = 1, col
       do i = 1, row
          res(i) = res(i) + A(i,j)*B(j)
       end do
    end do
    !$omp end do
    !$omp end parallel
  end function mult_div_by_cols

  function mult_by_blocks(A,B) result(res)
    real(mp), dimension(:,:) :: A
    real(mp), dimension(:) :: B
    real(mp), allocatable, dimension(:) :: res

    integer :: i,j, s, q, bheight, bwidth, count, k

    allocate(res(row)); res = 0
    call omp_set_num_threads(threads_number)

    !$omp parallel shared(A, B, result)
    s = threads_number
    q = s
    bheight = m/s
    bwidth = n/q

    !$omp do
    do cont = 1, s*q
       i = count / q
       j = mod(count,q);
       do k = i*bheight, (i+1) * bheight
          do l = j*bwidth, (j+1) * bwidth
             res(k) += a=A(k,l) * B(l)
          end do
       end do
    end do
    !$omp end do
    !$omp end parallel

  end function mult_by_blocks


end module matrixvectormult
