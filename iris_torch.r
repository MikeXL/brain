
library(reticulate)
use_python('/MSSQL14/PYTHON_SERVICES')

torch = import("torch")
nn    = import("torch.nn")


# define model
m = nn$Sequential( nn$Linear(4L, 6L), 
                  nn$ReLU(),
                  nn$Linear(6L, 3L),
                  nn$Softmax()
                 )


x = torch$from_numpy(as.matrix(iris[, 1:4]))$float()
x$size()


y = torch$from_numpy(matrix(as.integer(iris[,5])-1, nrow=150, ncol=1))$long()
# by default, it creates 2d, squeeze into 1d target 
# or else cross entropy loss would complain
y = torch$squeeze(y, 1L)
y$size()

# start training 
m$train()
optim <- torch$optim$Adam(m$parameters(), lr=.001)
for( e in 1:1000)
{
    optim$zero_grad()
    yhat = m(x)
    # print(yhat)
    #l = nn$MSELoss()(yhat, y$float())
    l = nn$CrossEntropyLoss()(yhat, y)
    
    #print(l)
    l$backward()
    optim$step()
}

# evaluate the fitted value
# in future should do validation during the training 
m$eval()
pred <- m(x)
pred_class <- torch$max(pred$data, 1L)
# confusion matrix
table(pred_class[[2]]$numpy(), y$numpy())
