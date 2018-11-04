import torch
import torch.nn as nn

import numpy as np

x = torch.from_numpy(wine.data).float()                          ## features
y = torch.from_numpy(wine.target).long()                         ## target

model = nn.Sequential(                                           ## define model topology
  nn.Linear(13,24),
  nn.ReLU(),
  nn.Linear(24,12),
  nn.ReLU(),
  nn.Linear(12,3),
  nn.Softmax(1)
)

def weight_reset(m):                                            ## reset model weights prior training
    if isinstance(m, nn.Conv2d) or isinstance(m, nn.Linear):
        m.reset_parameters()

def score(model, x, y):                                         ## simple scoring technique .. misclassification 
  model.eval()
  out=model(x)
  _, pred = torch.max(out, 1)
  print "Misclassified %s/%s" % 
         ((y.size(0) - (pred.data==y.data).sum(0)), y.size(0))


EPOCH = 500
lr = .1                                                         ## learning rate
lf = nn.CrossEntropyLoss()                                      ## loss function

def fit_lbfgs(model, optim, Floss, epoch):                      ## train L-BFGS
  losses = []
  for _ in range(epoch):
    def closure():
      optim.zero_grad()
      yhat = model(x)
      loss = Floss(yhat, y)
      losses.append(loss.item())
      loss.backward()
      return loss
    optim.step(closure)
    ## might need this code at somepoint to plug in for validation
    ## with torch.no_grad():
    ##  pred = model(x))
    ##  l = lf(pred, y)
  return losses


def fit(model, optim, Floss, epoch):                            ## train Adam, SGD, RMSprop
  losses = []
  for _ in range(epoch):
    optim.zero_grad()
    yhat = model(x)
    loss = Floss(yhat, y)
    losses.append(loss.item())
    loss.backward()
    optim.step()
    ## might need this code at somepoint to plug in for validation
    ## with torch.no_grad():
    ##  pred = model(x))
    ##  l = lf(pred, y)
  return losses


## a little experiment on different learning rate and optimizers
##    learning rate 1 0.1 0.01 0.001
##    optimizers: L-BFGS, Adam, SGD, RMSprop
##
for lr in [1, .1, .01, .001]:
  optim_lbfgs   = torch.optim.LBFGS(model.parameters(),   lr=lr)
  optim_adam    = torch.optim.Adam(model.parameters(),    lr=lr)
  optim_sgd     = torch.optim.SGD(model.parameters(),     lr=lr)
  optim_rmsprop = torch.optim.RMSprop(model.parameters(), lr=lr)

  idx = int(np.log10(lr*1000))

  model.apply(weight_reset)
  model.train()
  loss_lbfgs[idx] = fit_lbfgs(model, optim_lbfgs, lf, EPOCH)
  score(model, x, y)

  model.apply(weight_reset)
  model.train()
  loss_adam[idx] = fit(model, optim_adam, lf, EPOCH)
  score(model, x, y)

  model.apply(weight_reset)
  model.train()
  loss_sgd[idx] = fit(model, optim_sgd, lf, EPOCH)
  score(model, x, y)

  model.apply(weight_reset)
  model.train()
  loss_rmsprop[idx] = fit(model, optim_rmsprop, lf, EPOCH)
  score(model, x, y)

