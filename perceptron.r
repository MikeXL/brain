
                                                                # the idea of nn is quite simple and straightforward
                                                                # taking the input, excite neurons and produce adenosine
                                                                # then it comes down to reduce noises (optimization) 
                                                                # and the speed (optimization again for network converge)
                                                                # most of the business problems does not require CNN or RNN
                                                                # rather solved by single or double hidden layer of
                                                                # vanilla neural networks
                                                            
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
                                                                # vannila it is
                                                                #        2 inputs
                                                                #        3 layers (input, hidden, output)
                                                                #        1 perceptron
                                                                #        1 output with 2 levels
                                                                #
  n.iter <- 1000                                                  # number of iterations
  epoch  <- 1                                                   # mini batch, no used here
                                                                #   epoch recommendation 2^(6~9) = 64, 128, 256, 512
                                                                #   RoT: can fit into CPU/GPU memory
  n.obs  <- nrow(x)                                             # number of samples / observations
  n.parm <- ncol(x)                                             # number of parameters / input / features
  b      <- 0.01                                                   # bias, not really used here, or could try out .01
                                                                #       mind bias is per neuron, 
                                                                #       and can be initialized the same way as weights

  alpha  <- 0.1                                                 # learning rate
  y.hat  <- rep(0, n.obs)                                       # predications y.hat, baseline
  prob   <- rep(0, n.obs)                                       #   probability
  w      <- rnorm(2) * .01                                      # initialize weight, start small
  # w    <- w/sum(w^2)                                          # normalize the initialization, overkill for this ?
                                                                # large w would end up at the flat side of tanh
                                                                # slow down the gradient descent, slow to converge for whole nn
  
  fav    <- matrix(nrow=n.iter, ncol=5)                         # record the error / cost / objective for 
                                                                #     picking the best iteration or early stopping
  colnames(fav) <- c("mae",                                     # mean absolution error
                     "mse",                                     # mean squared error
                     "log.loss",                                # log loss
                     "dl",
                     "mis"                                      # misclassification
                     )

  for(i in 1:n.iter) {
    for(j in 1:n.obs){
      p <- tanh(w[1]*x[j, 1] + w[2]*x[j, 2] + b)
      prob[j] <- ifelse(p>0, p, 1+p)
      prob[j] <- pmin(pmax(prob[j], 1e-15), 1-1e-15)
      y.hat[j] = sign(p)    # tanh activation
      
                                                                # other activation function like identity linear, cos, sigmoid
                                                                # softmax for multi-class target
                                                                # doubting the function of sign, as it would miss the value 0
                                                                # perhaps better be explicit on >=0 than using sign
      eta  <- y[j] - y.hat[j]                                   # error
      ll   <- -(y * log(y.hat) + (1-y) * log(1-y.hat))          # log loss
      w[1] <- w[1] + alpha * eta * x[j,1]                       # update w1, stochastic gradient descent
      w[2] <- w[2] + alpha * eta * x[j,2]                       # update w2
      b    <- b    + alpha * eta * b                            # update bias
      # alpha = alpha /(1+decay_rate * epoch)                   # learning rate decay, might be last thing to try for tuning
                                                                #    alpha = power(.95, epoch) * alpha
                                                                #    alpha = k / sqrt(epoch)   * alpha
                                                                #    manual decay
                                                                # feels like monte carlo simulation all over again, um
      
    }
    fav[i, 1] <- mean(abs(y-y.hat))                                                            # loss L(...) = -(y.hat*log(y) + (1-y)*log(1-y.hat))
    fav[i, 2] <- mean((y-y.hat)^2)                                                            #          dL = -(y/y.hat) + (1-y)/(1-y.hat)
    
    fav[i, 3] <-  - (sum(y * log(prob) + (1 - y) * log(1 - prob))) / length(y)                                                           # and cost function J(...) here ?
    fav[i, 4] <- -mean(y/prob + (1-y)/(1-prob))
    fav[i, 5] <- mean(y!=y.hat)
                                                                # early stop to avoid overfitting
                                                                # but how ?
                                                                #  monitoring the converge trend of w ?
                                                                #  cross validation to compare training error and validation error ?
    
                                                                # batch norm ?
                                                                # reduce cov shift through layers
    
                                                                # test time considerations of mu, sigma for normalization
                                                                # estimate using exponentially weighted average
                                                                # across mini batches
    
  }
                                                                # show 'n tell
  print(w)                                                      # weights       
  print(b)                                                      # bias
  print(sum(y.hat != y)/n.obs)                                  # misclassification rate
  print(table(y, y.hat))                                        # confusion matrix
  print(fav)
  par(mfrow=c(2,2))
  plot(fav[,1], ylab="MAE")
  plot(fav[,2], ylab="MSE")
  plot(fav[,3], ylab="Log Loss")
  plot(fav[,4], ylab="misclassifcation rate")
                                                                # and now 
                                                                # how to store the model for future prediction ?
                                                                # pretty much doing the high school math for prediction 
                                                                #     pred = sign(tanh(w1 * x1 + w2 * x2 + b))
  
                                                                # dropouts in deep network
}


