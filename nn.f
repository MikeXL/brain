C stupidly simple neural net
C motivation was to build neural net capability for R
C
C Notation, please refer to Andrew Ng. deep learning mooc
C or here https://cs230.stanford.edu/files/Notation.pdf
C
C MJ LOG 20200727.135071 [[[ Perhaps libTorch ? ]]]
C 
C23456789
      subroutine nn(x, y, n, m, k, newdata, output)
C learning rate alpha 
C  momentum beta, reserved for future
C  pick word iter than epoch, ya know why ?
C  ahem, implicitly "God is real"
C  two hidden layers network for now, code can be changed to accomondate more complex
C  network topology a.ka. architecture, structure
C   input (n*m) -> h1 (12+1) -> h2 (7+1) -> output (n*k)
        parameter (nh1=12, nh2=7, iter=100, alpha=.01, beta=.9)
        dim(m,     nh+1)    :: w1, dw1
        dim(nh+1,  nh+1)    :: w2, dw2
        dim(nh2+1, k)       :: w3, dw3
        dim(n,     nh1+1)   :: z1, a1, dz1
        dim(n,     nh2+1)   :: z2, a2, dz2
        dim(n,     k)       :: z3, a3, dz3
C initialize weights
        call random_number(w1)
        call random_number(w2)
        call random_number(w3)
C training loop a.k.a epoch, iteration
        do 69 i=1, iter
C forward pass
            z1 = matmul(x, w1)
            a1 = tanh(matmul(x, w1))
            z2 = matmul(a1, w2)
            a2 = tanh(matmul(a1, w2))
            z3 = matmul(a2, w3)
C softmax ?
            a3 = exp(matmul(a2, w3))
C L = mse 
C backprop
            dz3 = (y - a3)
            dz2 = matmul(dz3, transpose(w3))
            dz1 = matmul(dz2, transpose(w2))
C tanh'(a) = 1-tanh(a)**2          
            dw3 = matmul((1-transpose(a2)**2), dz3)
            dw2 = matmul((1-transpose(a1)**2), dz2)
            dw1 = matmul((1-transpose(x)**2), dz1)
            
            w3 = w3 + alpha * dw3
            w2 = w2 + alpha * dw2
            w1 = w1 + alpha * dw1
 69     continue
        print *, w1, w2, w3
C prediction ? 
C  output = f(f(f(newdata * w1) * w2) * w3)
       end subroutine nn
