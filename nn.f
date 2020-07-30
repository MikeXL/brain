C particle swarm optimization 
C motivation was to build neural net capability for R
C  as well trying out new mechanism 
C    v[] = v[] + c1 * rand() * (pbest[] - present[]) + c2 * rand() * (gbest[] - present[])    (a)
C    present[] = persent[] + v[]                                                              (b)
C 
C For each particle
C    Initialize particle
C END
C
CDo
C    For each particle
C        Calculate fitness value
C        If the fitness value is better than the best fitness value (pBest) in history
C            set current value as the new pBest
C    End
C
C    Choose the particle with the best fitness value of all the particles as the gBest
C    For each particle
C        Calculate particle velocity according equation (a)
C        Update particle position according equation (b)
C    End
C While maximum iterations or minimum error criteria is not attained
C23456789
      
      subroutine nn(x, y, n, m, k, newdata, output)
C
C  two hidden layers network for now, code can be changed to accomondate more complex
C  network topology a.ka. architecture, structure
C   input (n*m) -> h1 (12+1) -> h2 (7+1) -> output (n*k)
        parameter (nh1=12, nh2=7, iter=100, c1=2, c2=2)
        dim(m,     nh+1)    :: w1, pbest1, gbest1, v1, p1
        dim(nh+1,  nh+1)    :: w2, pbest2, gbest2, v2, p2
        dim(nh2+1, k)       :: w3, pbest3, gbest3, v3, p3
C initialize weights
        call random_number(w1)
        call random_number(w2)
        call random_number(w3)
C training loop a.k.a epoch, iteration
        do 69 i=1, iter
            
            do 60 j=1, size(w1)
              call fit(x, w1, w2, w3, mse)
              if mse < pbest then pbest = mse
 60         continue
 

 69     continue
C show me the trained network (weights)
        print *, w1, w2, w3
C prediction ? 
C  output = f(f(f(newdata * w1) * w2) * w3)
       end subroutine nn
