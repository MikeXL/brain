x <- as.matrix(unname(head(iris[,1:4], 100)), nrow=100, ncol=4)   
x <- scale(x)                                                     
y <- as.matrix(append(rep(1, 50), rep(0, 50)), nrow=100, ncol=1)

# nn 4 - 3 - 1
#  activation tanh 
# 
#   X       Hidden    Output    Y
# 100x4     4x3       3x1     100x1
# +----+   +----+    +----+   +----+
# |    |   |    |    |    |   |    |       
# |  X |   |  H |    |  O |   | Y  |   
# |    |   |    |    |    |   |    |   
# +----+   +----+    +----+   +----+
#           bbb        b
# 
#  x        w1, b1    w2, b2     y
#

compute.nn = function(w) {
  w1 = matrix(w[1:12], nrow=4, ncol = 3)
  w2 = matrix(w[13:15], nrow=3, ncol = 1)
  
  b1 = matrix(w[16:18], nrow = 1, ncol = 3)
  b2 = w[19]
  
  p = x %*% w1 
  p = sweep(p, 2, b1, "+")
  p = tanh(p)
  
  p = tanh(p %*% w2 + b2)
  
  p
}

fit.mse = function(w) {
  
  mean((y - compute.nn(w))^2)
  
  # mean(abs(y-p))
}

pso = function(fitness, niter=1000, npar=12, nd=1, w=1+1/(2*log(2)), c1=.5+log(2), c2=.5+log(2)){
# number of iterations
#    niter = 1000
# number of particles
#    npar = 12
# number of dimensions, nn training parameters 
#    nd = 19
# initialize 
    par   = matrix(rnorm(npar*nd), nrow=npar, ncol=nd)
    pbest = matrix(rnorm(npar*nd), nrow=npar, ncol=nd)
    gbest = matrix(rnorm(nd))

# hyperparameter: inertia, coginitve, social factor
#    w  = 1+1/(2*log(2))
#    c1 = .5 + log(2)
#    c2 = .5 + log(2)
#     lr = .8

# main loop 
    for(i in 1:niter){
        for(j in 1:npar){
# update individual best (or personal best)
            fit.par   = fitness(par[j, ])
            fit.pbest = fitness(pbest[j, ])
            if(!is.na(fit.par) & fit.pbest > fit.par) { pbest[j, ] = par[j, ] }
        }
      
# update particles by velocity (vectorized)
        r1 = matrix(runif(npar*nd), nrow=npar, ncol=nd)
        r2 = matrix(runif(npar*nd), nrow=npar, ncol=nd)

        # v <- w*p + c1*r1*(pbest - p) + c2*r2*(gbest - p)
        # v <- w*p + c1*r1*(pbest - p) - c2*r2*(p - gbest)
        # p <- p + v
        # p = (1+w)*p + ... 
        par = w*par + c1*r1*(pbest - par) - c2*r2*(sweep(par, 2, gbest, "-"))

# update global best 
        gbest.1 = pbest[which.min(apply(pbest, 1, function(x) fit.mse(x))), ]
        if(fit.mse(gbest.1) < fit.mse(gbest)){
            gbest = gbest.1
        }
    }

#    print(par)
#    print(gbest)
#    print(compute.nn(gbest))
  gbest
}


pso(fit.mse, nd=19)
