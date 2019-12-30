!
! Copyright (c) 2019 V.Shishkin
!

! lapki
!           _,'|             _.-''``-...___..--';)
!         /_ \'.      __..-' ,      ,--...--'''
!        <\    .`--'''       `     /'
!         `-';'               ;   ; ;
!   __...--''     ___...--_..'  .;.'
!  (,__....----'''       (,..--''


module strfinder
  use my_prec
  use omp_lib
  implicit none
contains
  subroutine find_in_file(str)
    character(len = *) :: str
    character(len = 100) :: tmp_s
    integer :: i, n, line_count
    open(10, file = 'data.dat')

    read(10,'(2x,I6)') n

    line_count = 1
    !$omp parallel shared(str,n, line_count) default(private)
    !$omp do schedule(auto)
    do i = 1, n

       !$omp critical
       read(10,'(A)') tmp_s
       line_count = line_count + 1
       tmp_s = trim(tmp_s)
       if(index(tmp_s, str) .ne. 0)then
          print *, str, ' is found at index: ', index(tmp_s, str), ' at the line n = ', line_count
       end if
       !$omp end critical

    end do
    !$omp end do
    !$omp end parallel

  end subroutine find_in_file


end module strfinder
