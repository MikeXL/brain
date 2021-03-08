C disclaimer: not an working copy
C       to illustrate the idea of optimizing nn with particle swarm
C
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
C23456789
      subroutine pso(par, f)
C particle swarm parameters 
C       w     inertia 
C       c1    cognitive velocity factor
C       c2    social velocity 
        parameter (iter=100, w=.5, c1=1, c2=2)
C number of particles 
        npar = size(par)
C individual best 
        double precision pbest(npar)
C global best 
        double precision gbest 
C loop thru iterations 
        do 99 i=1, iter
C initialize weights
          call random_number(par)
C calculate individual pBest and social global gBest 
          do 69 j=1, npar 
            call fit(par, fitnss)          
            if fitnss .lt. pbest then 
              pbest = fitnss
            end if 
69        continue
C update global best 
          if pbest .lt. gbest then 
            gbest = pbest 
          end if 
C update particles 
          do 77 j=1, npar 
            call random_number(randp)
            call random_number(randg)
            par(j) = w*par(j) + c1*randp*(pbest(j) - par(j)) + c2*randp*(gbest-par(j))
77        continue 
99      continue
      end subroutine pso
C 
C compute nn
      subroutine nn(x, y, n, m, k, newdata, output)
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
