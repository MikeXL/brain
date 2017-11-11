
#
# Prepare data 
#
x1 <- head(iris$Sepal.Length, 100)                            # iris sepal length
x2 <- head(iris$Sepal.Width, 100)                             # iris sepal width
x  <- matrix(cbind(x1, x2), nrow=100, ncol = 2)                
y  <- append(rep(1, 50), rep(-1, 50))                         # setosa = 1, versicolor = -1


n.iter <- 10000                                               # number of iterations
n.obs  <- nrow(x)                                             # number of samples / observations
n.parm <- ncol(x)                                             # number of parameters / input / features
b      <- 0                                                   # bias
alpha <- 1                                                    # learning rate
y.hat <- rep(0, n.obs)                                        # predications y.hat, baseline
w <- rnorm(2)                                                 # initialize weight

for(i in 1:n.iter) {
  for(j in 1:n.obs){
    y.hat[j] = sign(tanh(w[1]*x[j, 1] + w[2]*x[j, 2] + b))    # tanh activation
    eta <- y[j] - y.hat[j]                                    # error
    w[1] = w[1] + alpha * eta * x[j,1]                        # update w1, stochastic gradient descent
    w[2] = w[2] + alpha * eta * x[j,2]                        # update w2
                                                              # feels like monte carlo simulation all over again, um
  }
}

w                                                             # final weights
sum(y.hat != y)/n.obs                                         # misclassification rate
table(y, y.hat)                                               # confusion matrix