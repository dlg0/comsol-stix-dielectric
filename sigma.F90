module sigma

use, intrinsic :: iso_c_binding, only: c_double, c_double_complex

contains

    subroutine sigma_cold  ( omgRF, n_m3, Z, amu, bMag, nuOmg, sigma_stix ) bind(C,name="sigma_cold")
    !subroutine sigma_cold  ( omgRF, n_m3, Z, amu, bMag, nuOmg ) bind(C,name="sigma_cold")

        use constants 

        ! This routine calculates sigma_cold in the Stix frame
        ! (alp,bet,prl)
        ! ----------------------------------------------------

        implicit none

        real(kind=c_double), intent(in), value :: omgrf, n_m3, Z, amu, bmag, nuOmg
        complex(kind=c_double_complex), intent(inout) :: sigma_stix(3,3)

        complex(kind=DBL) :: omgrfc
        complex :: sig1, sig2, sig3
        complex :: zieps0

        complex :: K1_swan,K2_swan,K3_swan
        real(kind=DBL) :: e_swan
        complex :: sigma_swan(3,3),epsilon_swan(3,3)
        integer :: IdentMat(3,3)
        real(kind=dbl) :: m, omgc, omgp2 

        integer :: fStat
        character(len=80) :: logFileName = 'sigmaFortran.log'
        
        write(*,*), 'omgrf: ', omgrf
        write(*,*), 'n_m3: ', n_m3
        write(*,*), 'Z: ', Z
        write(*,*), 'sigma_stix[0][0]: ', sigma_stix(1,1)

        open(1,file=logFileName,status='replace',iostat=fStat)
        write(1,'(5(f12.6,4x))'), omgrf, Z, amu, bmag, n_m3 
        close(1)

        !m = mi * amu
        !omgc = q * bMag / m
        !omgp2  = n_m3 * q**2 / ( eps0 * m )
 
        !zieps0 = zi * eps0
        !omgRFc = omgRF * (1.0 + zi * nuOmg)

        !sig1 = zieps0 * omgRFc * omgP2 / (omgRFc**2 - omgC**2) ! Stix_S
        !sig2 = eps0 * omgC   * omgP2 / (omgC**2 - omgRFc**2) ! Stix_D
        !sig3 = zieps0 * omgp2 / omgRFc ! Stix_P

        !sigma_stix(1,1) = sig1 
        !sigma_stix(1,2) = sig2 
        !sigma_stix(1,3) = 0 

        !sigma_stix(2,1) = -sig2 
        !sigma_stix(2,2) = sig1 
        !sigma_stix(2,3) = 0 

        !sigma_stix(3,1) = 0
        !sigma_stix(3,2) = 0 
        !sigma_stix(3,3) = sig3


        !! Swanson version

        !e_swan = sign(1d0,omgc) ! this is q/|q|
        !K1_swan = 1d0 - omgP2 / (omgRFc**2-omgC**2)
        !K2_swan = e_swan*omgC*omgP2/(omgRFc*(omgRFc**2-omgC**2))/zi
        !K3_swan = 1d0-omgP2/omgRFc**2

        !Epsilon_swan = (0,0)
        !Epsilon_swan(1,1) = +K1_swan
        !Epsilon_swan(1,2) = +K2_swan
        !Epsilon_swan(2,1) = -K2_swan
        !Epsilon_swan(2,2) = +K1_swan
        !Epsilon_swan(3,3) = +K3_swan

        !IdentMat = 0
        !IdentMat(1,1) = 1
        !IdentMat(2,2) = 1
        !IdentMat(3,3) = 1

        !SigmaCold_swan = -(EpsilonCold_swan-IdentMat)*omgrfc*eps0*zi
        !SigmaCold_stix = SigmaCold_swan
        !SigmaCold_stix = EpsilonCold_swan

!        write(*,*) '1,1  ', SigmaCold_stix(1,1), SigmaCold_swan(1,1)
!        write(*,*) '2,2  ', SigmaCold_stix(2,2), SigmaCold_swan(2,2)
!        write(*,*) '3,3  ', SigmaCold_stix(3,3), SigmaCold_swan(3,3)
!
        return

    end subroutine sigma_cold

end module sigma
