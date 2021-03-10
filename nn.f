C disclaimer: not an working copy
C       to illustrate the idea of optimizing nn with particle swarm
C
C23456789
        function fx(x)
          double precision  x
          fx = 20+(x**2-10*cos(2*3.14*x))
        end function
        function fxy(x, y)
          double precision x, y
          fxy = (x+2*y-7)**2 + (2*x+y-5)**2
        end function 
C particle swarm optimization
C motivation was to build neural net capability for R
C  as well trying out new mechanism
C    v[] = v[] + c1 * rand() * (pbest[] - present[]) + c2 * rand() * (gbest[] - present[])    (a)
C    present[] = persent[] + v[]                                                              (b)
C
C FOR each particle
C    Initialize particle
C END
C
C DO
C    FOR each particle
C        Calculate fitness value
C        If the fitness value is better than the best fitness value (pBest) in history
C            set current value as the new pBest
C    END
C
C    Choose the particle with the best fitness value of all the particles as the gBest
C    FOR each particle
C        Calculate particle velocity according equation (a)
C        Update particle position according equation (b)
C    END
C While maximum iterations or minimum error criteria is not attained
        program pso
        parameter (iter=10, w=2.6, c1=.8, c2=.8, npar=12, nd=2)
        double precision par(npar, nd), pbest(npar, nd)
        double precision r1(nd), r2(nd), gbest(nd)
        do 99 i=1, iter
C initialize weights
          call random_number(par)
          call random_number(pbest)
          call random_number(gbest)
C update invdividual best
          do 69 j=1, npar
            fitpar = nn(par(j, ))
            fitbst = nn(pbest(j, ))
            if (fitpar .lt. fitbst) then
              pbest(j, ) = par(j, )
            end if
69        continue
C update global best
          gbfit = fxy(gbest(1), gbest(2))
          pbfit  = fxy(pbest(kk, 1), pbest(kk, 2)) 
          if ( pbfit  .lt. gbfit) then 
            gbest  = pbest(kk, :)
          end if 
C update particles
          do 77 j=1, npar
            call random_number(r1)
            call random_number(r2)
            par(j, ) = w*par(j, ) + 
     +               c1*r1*(pbest(j, ) - par(j, )) + 
     +               c2*r2*(gbest - par(j, ))

         gbest = minval(pbest, npar)     
99      continue       
         print *, gbest
         print *, fx(gbest)
         end C 
C compute nn
C      subroutine nn(x, y, n, m, k, newdata, output)
       subroutine nn(w)
C reshape w into w1,2, ...
C
C  two hidden layers network for now, code can be changed to accomondate more complex
C  network topology a.ka. architecture, structure
C   input (n*m) -> h1 (12+1) -> h2 (7+1) -> output (n*k)
         parameter (nh1=12, nh2=7, iter=100, c1=2, c2=2)
         nparticle = m*(nh1+1) + (nh1+1)*(nh2+1) + (nh2+1)*k
         double precision particle(nparticle)
         dim(m,      nh1+1)    :: w1, pbest1, gbest1
         dim(nh1+1,  nh2+1)    :: w2, pbest2, gbest2
         dim(nh2+1, k)         :: w3, pbest3, gbest3
         dim(n, k)             :: output, yhat

         call pso(particle, fit)
       end subroutine nn
C compute the network
       subroutine fit(x, particle, y, yhat)
         w1 = reshape(particle(1:m*(nh1+1)), (/m, nh1+1/))
         w2 = reshape(particle((1+m*(nh1+1)):(m*(nh1+1)+(nh1+1)*(nh2+1))), (/nh+1, nh2+1/))
         w3 = reshape(particle(:), (/nh2+1, k/))
         yhat = x*w1*w2*w3
         mean((y-yhat)**2)
       end subroutine fit
