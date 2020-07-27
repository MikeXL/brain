C stupidly simple neural net
C dont bother much
C R has nnet for single hidden layer
C Outdated RSNNS for multiple layers
C or neuralnet though slow
C last front is pytorch, that calling thru python not ideal
C possible to utilize libTorch ?? this may look like better project than start from scratch
C R could only call subroutine and double precision
C input parameters
C training matrix x
C training label y
C prediction newdata
C prediction yhat for output
C23456789
      subroutine nn(x, y, n, m, k, newdata, yhat)
C two hidden layers
C for now network structure is statitically specified inside code
C     input n x m matrix, n obs, m features
C     h1  12 neurons
C     h2   7 neurons
C     output k class
C     learning rate alpha = .01
C     momentum ? 
        parameter (nh1=12, nh2=7, nepoch=100, alpha=.01)
C +1 for bias
        double precision w1(m, nh1+1), w2(nh1+1, nh2+1), w3(nh2+1, k), output(n, k), dy(n, k)
        double precision layer1(n, nh1+1), layer2(n, nh2+1)
        double precision dw1(4,13), dw2(13, 8), dw3(8, 3)
C initialize weights 
        call random_number(w1)
        call random_number(w2)
        call random_number(w3)
C training loop
        do 69 i=1, nepoch
C forward pass
            layer1 = tanh(matmul(x, w1))
            layer2 = tanh(matmul(layer1, w2))
            output = tanh(matmul(layer2, w3))
C error 
C mse (y-y.hat)**2*.5
C derivative form dy = y-y.hat
            dy = y-output
            print *, dy
C backprop 
C tanh derivative is 1-a*a, not ideal, hardcoded
            dw3 = matmu(dy, transpose(w3)) * (1-layer2**2)
            dw2 = 
            dw1 = 
C update weights and bias     
            w3 = w3 + dw3*alpha
            w2 = w2 + dw2*alpha
            w1 = w1 + dw1*alpha
            print *, i
            print *, w3
 69     continue
C softmax ?
C prediction / score the newdata
      end subroutine nn
