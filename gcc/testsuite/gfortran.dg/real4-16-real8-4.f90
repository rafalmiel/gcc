! { dg-do run }
! { dg-additional-options "-w -freal-4-real-16 -freal-8-real-4" }
! { dg-require-effective-target fortran_real_16 }
!
! PR fortran/99355
!

program test
  real :: r1
  real*4:: r2
  real(4) :: r3
  real(selected_real_kind(p=6)) :: r4

  double precision :: d1
  real*8 :: d2
  real(8) :: d3
  real(kind(1.d0)) :: d4 ! << this is ambiguous: kind=8 → 4 → 16 or 8 → 4; thus,excluded below
  real(selected_real_kind(p=15)) :: d5

  !print '(tr3,a10,10(tr1,i2))', 'single', kind(r1), kind(r2), kind(r3), kind(r4)
  !print '(tr3,a10,10(tr1,i2))', 'double', kind(d1), kind(d2), kind(d3), kind(d4), kind(d5)
  if (any ([kind(1.0), kind(r1), kind(r2), kind(r3), kind(r4)] /= 16)) stop 1
  if (any ([kind(1.d0), kind(d1), kind(d2), kind(d3), kind(d5)] /= 4)) stop 2
end program test
