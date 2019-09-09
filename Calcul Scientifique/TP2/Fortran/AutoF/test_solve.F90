   ! TODO
! Implement sub-programs

  ! Algorithme de resolution sans report
 subroutine left_looking_solve(L,x,b,n)
  
   implicit none
   integer :: j, i, n
   double precision, intent(in), dimension(n,n) :: L
   double precision, intent(in), dimension(n) :: b
   double precision, intent(inout), dimension(n) :: x
  
  
   x = b
   if (n.ne.0) then
	     do j = 1, n
		    do i = 1, j-1
			   x(j) = x(j) - L(j,i)*x(i)
		    end do
		 if (L(j,j) /=0) then
		    x(j) = x(j)/L(j,j)
		 else
			goto 100 !diagonale de la matrice non nulle
		 end if
	     end do
   else
	  goto 200 
   end if
  
  200 write(*,*) "Matrice de taille nulle"
  100 write(*,*) "Diagonale de la matrice nulle"
  
 end subroutine left_looking_solve
 
 !-----------------------------------------------------------------

  ! Algorithme de resolution avec report
 subroutine right_looking_solve(L,x,b,n)
 
  implicit none
  integer :: j, i, n
  double precision, intent(in), dimension(n,n) :: L
  double precision, intent(in), dimension(n) :: b
  double precision, intent(inout), dimension(n) :: x
  
  
  x = b
  if (n.ne.0) then
	    do j = 1, n
		   if (L(j,j) /=0) then
		       x(j) = x(j)/L(j,j)
		   else
			   goto 100 !diagonale de la matrice non nulle
		   end if
		   do i = j+1, n 
			   x(i) = x(i) - L(i,j)*x(j)
		   end do
	    end do
  else
	 goto 200
  end if
  
  200 write(*,*) "Matrice de taille nulle"
  100 write(*,*) "Diagonale de la matrice nulle"
 end subroutine right_looking_solve
 
 
 
!-----------------------------------------------------------------


  
  !Fonction du calcul de l'erreur inverse
 double precision function backward_error(L,x,b,n)
  implicit none
  integer :: n
  double precision, intent(in), dimension(n,n) :: L
  double precision, intent(in), dimension(n) :: x, b
  integer :: i
  
  real, dimension(n) :: R
  real :: norm_b, norm_r
  
  R = matmul(L,x)
  R = R - b
  norm_r = 0
  norm_b = dot_product(b,b)
  do i = 1, n
	 norm_r = norm_r + R(i)*R(i)
  end do
  backward_error = norm_r/norm_b
  return
 end function backward_error
  

!-----------------------------------------------------------------



program test_solve

  implicit none

  integer :: i, j, ierr, n
  double precision, dimension (:,:), allocatable :: L
  double precision, dimension (:), allocatable :: x, b
  real :: start1, start2, finish1, finish2
  double precision :: backward_error

  write(*,*) 'n?'
  read(*,*) n

  ! Initialization: L is lower triangular
  write(*,*) 'Initialization...'
  write(*,*)
  
  allocate(L(n,n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate L(n,n) with n=',n
    goto 999
  end if

  allocate(x(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate x(n) with n=',n
    goto 999
  end if

  allocate(b(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate b(n) with n=',n
    goto 999
  end if

  L = 0.D0
  do i = 1, n  
    L(i,i) = n + 1.D0
    do j = 1, i-1
      L(i,j) = 1.D0
    end do
  end do
  b = 1.D0

  ! Left-looking triangular solve of Lx=b
  write(*,*) 'Solving with a left-looking method...'
  

  ! TODO : call left_looking_solve
  call cpu_time(start1)
  call left_looking_solve(L,x,b,n)
  print*, "L'erreur pour la methode sans report est : ", backward_error(L,x,b,n) 
  call cpu_time(finish1)
  
  print*, 'Le temps passe pour la procedure sans report est :', finish1-start1, 'secondes'
  
  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'

  ! TODO : call right_looking_solve
  call cpu_time(start2)
  call left_looking_solve(L,x,b,n)
  
  print*, "L'erreur pour la methode sans report est : ", backward_error(L,x,b,n) 
  call cpu_time(finish2)
  
  ! Affichage du temps passé à l'execution
  print*, 'Le temps passe pour la procedure avec report est :', finish2-start2, 'secondes' 
  

  deallocate (L,x,b)
  
999 if(allocated(L)) deallocate(L)
    if(allocated(x)) deallocate(x)
    if(allocated(b)) deallocate(b)


end program test_solve

! L'execution du programme pour differentes valeurs de n monte que l'algorithme sans report s'execute 
! plus vite que celui avec report. Celà s'explique par le fait que Fortran manipule les matrices par colonnes:
! c'est-à-dire que il est plus facile de parcourir une colonne de matrices qui se fait par incrementation 
! de l'adresse que de parcourir une ligne de matrices.


	
  
