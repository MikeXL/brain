
                                                                # the idea of nn is quite simple and straightforward
                                                                # taking the input, excite neurons and produce adenosine
                                                                # then it comes down to reduce noises (optimization) 
                                                                # and the speed (optimization again for network converge)
                                                                # most of the business problems does not require CNN or RNN
                                                                # rather solved by single or double hidden layer
                                                                # vanilla neural network
                                                              
make.it.so <- function(){
                                                                #
                                                                # Prepare data for model 
                                                                #            species ~ Sepal.Length + Sepal.Width
                                                                #
  x1 <- head(iris$Sepal.Length, 100)                            # iris sepal length
  x2 <- head(iris$Sepal.Width, 100)                             # iris sepal width
  x  <- matrix(cbind(x1, x2), nrow=100, ncol = 2)                
  y  <- append(rep(1, 50), rep(-1, 50))                         # setosa = 1, versicolor = -1, discard virginica
  
  
                                                                #
                                                                # vannila neural network 
                                                                #        2 inputs
                                                                #        3 layers (input, hidden, output)
                                                                #        1 perceptron
                                                                #        1 output with 2 levels
                                                                #
  n.iter <- 1000                                               # number of iterations
  epoch  <- 1                                                   # mini batch
                                                                #   epoch recommendation 2^(6~9) = 64, 128, 256, 512
                                                                #   RoT: can fit into CPU/GPU memory
  n.obs  <- nrow(x)                                             # number of samples / observations
  n.parm <- ncol(x)                                             # number of parameters / input / features
  b      <- 0                                                   # bias
  alpha  <- 0.1                                                 # learning rate
  y.hat  <- rep(0, n.obs)                                       # predications y.hat, baseline
  w      <- rnorm(2) * .01                                      # initialize weight, start small
                                                                # large w would end up at the flat side of tanh
                                                                # slow down the gradient descent, slow to converge for whole nn
  scores <- matrix(nrow=100000, ncol=8)
  colnames(scores) <- c("iter", "w1", "w2", "x1", "x2", "b", "y", "y.hat")

  for(i in 1:n.iter) {
    for(j in 1:n.obs){
      y.hat[j] = sign(tanh(w[1]*x[j, 1] + w[2]*x[j, 2] + b))    # tanh activation
      eta <- y[j] - y.hat[j]                                    # error
      w[1] = w[1] + alpha * eta * x[j,1]                        # update w1, stochastic gradient descent
      w[2] = w[2] + alpha * eta * x[j,2]                        # update w2
      b    = b    + alpha * eta * b                             # update bias
      # alpha = alpha /(1+decay_rate * epoch)                   # learning rate decay, might be last thing to try for tuning
                                                                #    alpha = power(.95, epoch) * alpha
                                                                #    alpha = k / sqrt(epoch)   * alpha
                                                                #    manual decay
                                                                # feels like monte carlo simulation all over again, um
      scores[(i-1)*n.obs+j,1] <- i
      scores[(i-1)*n.obs+j,2] <- w[1]
      scores[(i-1)*n.obs+j,3] <- w[2]
      scores[(i-1)*n.obs+j,4] <- x[j,1]
      scores[(i-1)*n.obs+j,5] <- x[j,2]
      scores[(i-1)*n.obs+j,6] <- b
      scores[(i-1)*n.obs+j,7] <- y[j]
      scores[(i-1)*n.obs+j,8] <- y.hat[j]
    }
                                                                # loss L(...) = -(y.hat*log(y) + (1-y)*log(1-y.hat))
                                                                #          dL = -(y/y.hat) + (1-y)/(1-y.hat)
                                                                # and cost function J(...) here ?
                                                                # early stop to avoid overfitting
                                                                # batch norm ?
                                                                # reduce cov shift through layers
                                                                # test time considerations of mu, sigma for normalization
                                                                # estimate using exponentially weighted average
                                                                # across mini batches
  }
                                                                # show 'n tell
  w                                                             # weights       
  b                                                             # bias
  sum(y.hat != y)/n.obs                                         # misclassification rate
  table(y, y.hat)                                               # confusion matrix
  par(mfrow=c(3,1))
  plot(w1 ~ iter, data=scores)
  plot(w2 ~ iter, data=scores)
  df <- data.frame(scores)
  df %>% group_by(iter) %>% summarise(mis=sum(y!=y.hat)/n.obs) %>% plot(mis~iter, type="l")
  
                                                                # now 
                                                                # how to store the model for future prediction ?
  
                                                                # dropouts in deep network
}


