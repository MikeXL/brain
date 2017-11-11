
#
# Prepare data 
#
x1 <- head(iris$Sepal.Length, 100)
x2 <- head(iris$Sepal.Width, 100)
x  <- matrix(cbind(x1, x2), nrow=100, ncol = 2)
y  <- append(rep(1, 50), rep(0, 50))


n.iter = 10000                                                # number of iterations
n.obs = nrow(x)                                               # number of samples / observations
n.parm = ncol(x)                                              # number of parameters / input / features
b <- 0                                                        # bias
alpha <- 1                                                    # learning rate
y.hat <- rep(0, n.obs)                                        # predications y.hat, baseline
w <- rnorm(2)                                                 # initialize weight
for(i in 1:n.iter) {
  for(j in 1:n.obs){
    y.hat[j] = (tanh(w[1]*x[j, 1] + w[2]*x[j, 2] + b) >=0)    # tanh activation
    eta <- y[j] - y.hat[j]                                    # error
    w[1] = w[1] + alpha * eta * x[j,1]                        # update w1
    w[2] = w[2] + alpha * eta * x[j,2]                        # update w2
    
  }
}

w                                                             # final weights
sum(y.hat != y)/n.obs                                         # misclassification rate