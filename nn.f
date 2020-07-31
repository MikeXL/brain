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
C initialize weights
        do 99 i=1, iter 
        call random_number(particle)
C pbest
        do 69 j=1, nparticle
            w1 = reshape(particle(1:m*(nh1+1)), (/m, nh1+1/))
            w2 = reshape(particle((1+m*(nh1+1)):(m*(nh1+1)+(nh1+1)*(nh2+1))), (/nh+1, nh2+1/))
            w3 = reshape(particle(:), (/nh2+1, k/))
            call fit(x, w1, w2, w3, yhat)
            mse = sum((y-yhat)**2) / size(y)
            if mse .lt. pbest then 
              pbest = mse
              pbest1 = w1
              pbest2 = w2
              pbest3 = w3
            end if
 69     continue
C gbest
        if pbest .lt. gbest then 
          gbest = pbest
          gbest1 = pbest1
          gbest2 = pbest2
          gbest3 = pbest3
        end if 
C update weights 
        do 71 j=1, nparticle
          w1 = w1 + c1*rand()*(pbest1-w1) + c2*rand()*(gbest1-w1)
          w2 = w1 + c1*rand()*(pbest2-w2) + c2*rand()*(gbest2-w2)
          w3 = w1 + c1*rand()*(pbest3-w3) + c2*rand()*(gbest3-w3)
  71    continue
  99    continue 
C show me the trained network (weights)
C        print *, gbest1, gbest2, gbest3
C prediction ? 
C        call fit(newdata, gbest1, gbest2, gbest3, output) 
       end subroutine nn
C fit the network
       subroutine fit(x, w1, w2, w3, yhat)
         yhat = x*w1*w2*w3
       end subroutine fit
