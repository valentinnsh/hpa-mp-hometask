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
    integer :: i, n
    open(10, file = 'data.dat')

    read(10,'(2x,I6)') n

    !$omp parallel shared(str) default(private)
    !$omp do schedule(dynamic)
    do i = 1,n
       read(10,'(A)') tmp_s
       tmp_s = trim(tmp_s)
       if(index(tmp_s, str) .ne. 0)then
          print *, str, ' is found at index: ', index(tmp_s, str), ' at the line n = ', i
       end if
    end do
    !$omp end do
    !$omp end parallel
    if (i .eq. n) then
       print *, "cant find ", str
    end if

  end subroutine find_in_file


end module strfinder
