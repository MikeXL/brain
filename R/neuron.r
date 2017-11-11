
#
# now only handles single parameter x
#


perceptron <- function (w, x, b=1.0) {
  activation((w*x + b))
}

activation <- function (s, t=0){
  s>=t    # t is threshold
}

cost <- function() {
  .0
}

update <- function(w, x, alpha=1.0, y, y.hat) {
  w + alpha*(y-y.hat)*x
}


train <- function (x, y, iter=100, learning.rate=1.0, bias=1.0){
  w <- rnorm(length(x))
  
  for(i in 1:iter) {
    y.hat <- perceptron(w, x, bias)
    w <- update(w, x, learning.rate, y, y.hat)
    print(sum(y!=y.hat))
  }
}
