module mymatmul
  use my_prec
  use omp_lib
contains
  subroutine mat_mul(matrix_A, matrix_B, matrix_C)
    integer i, j, k
    real(mp),  dimension(:, :) :: matrix_A, matrix_B, matrix_C
    call omp_set_num_threads(threads_number)

    matrix_C = 0
    !$omp parallel private(i,j) default(shared)
    !$omp do schedule(static)

    do i = 1, row
       do j = 1, row
          matrix_C(i,j) = dot_product(matrix_A(i, :), matrix_B(:, j))
       end do
    end do

    !$omp end do
    !$omp end parallel

  end subroutine mat_mul

end module mymatmul
