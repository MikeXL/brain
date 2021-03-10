C disclaimer: not an working copy
C       to illustrate the idea of optimizing nn with particle swarm
C
C23456789
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
        PRORAM PSO
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
         END PROGRAM  
C compute nn
C more work to be done here 
       FUNCTION NN(w)
C reshape w into w1,2, ...
C
C  two hidden layers network for now, code can be changed to accomondate more complex
C  network topology a.ka. architecture, structure
C       4 - 3 - 1
C   
         parameter (ni=4, nh=3, no = 1)
         double precision w1(4, 3), w2(3, 1), b1(1, 3), b2
C load in x iris 
C load in y iris species 
         x = ...
         y = ... 
         p = tanh(matmul(x, w1) + transpose(spread(b1, 3, 4)))
         p = tanh(matmul(p, w2) + b2)
C mse loss
         nn = sum((y-p)**2))/nobs
         
       end function nn
