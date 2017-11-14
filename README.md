# brain
a gleeful study of neural network and implementing an _vanilla_ nn

The code perceptron.r is mostly inspired by Andrew Ng's _[deep learning courses][dl]_  
Another good MooC I'd like to take is _[Fast AI][fast]_  
(Rachel's profile is more interesting, as she has done tons of sims and nn)  


Cheers

![perceptron][neuron]


P.S.
Deep Learning Courses - my notes anyway   

### Course 1: Neural Networks and Deep Learning
Similar to hadoop, the cheap commodity hardware make it possible.
The cheaper and faster computing power that take off deep learning, or artificial intelligence.  
Lotsa research ideas dated back to 60s or 70s, it is today, that we could do the calculations in minutes, even on a cell phone
that would take an mainframe days.  
And rather than figuring out the algorithm to make things work, neural network is mostly following neuro science studies and model after human brain, even just a tiny bit, charmingly work well.  
#### Week 1: Introduction to deep learning
#### Week 2: Neural Network Basics
#### Week 3: Shallow neural networks
choice of activation function - identity, sigmoid, cos, tanh  
random initialization of weight parameters  

Majority, or say 95% of the business problems can be solved with _vanilla neural network_.
#### Week 4: Deep Neural Networks
forward and backward propagation  
parameters and Hyperparameter

The important question, that is answered in this course, why go deep? Computes faster to go deeper than wider.   
Similar idea to dimensionality reduction, when go deeper, it requires less parameters/weights on each layer.  
### Course 2: Improving Deep Neural Networks: Hyperparameter tuning, Regularization and Optimization
#### Week 1: Practical aspects of Deep Learning
Bias / Variance trade off  
Regularization  
Normalize inputs  
Vanishing /Exploding gradients
#### Week 2: Optimization algorithms
epoch and mini batches  
learning rate decay  
pony ride / saddle point of the local optima problem  
#### Week 3: Hyperparameter tuning, Batch Normalization and Programming Frameworks
Hyperparameter {learning rate alpha, bias, epoch, }  
batch norm process one mini-batch at a time; watch out for test time
softmax  

and the frameworks backed by giants  
TF    .... google  
CNTK  .... msft  
mxnet .... amazon  
caffe2 ... facebook  

### Course 3: Structuring Machine Learning Projects
#### Week 1: ML Strategy (1)
Discuss of the using single number evaluation metric, be it, misclassification rate (I like to call it mis.), precision, recall or F1 score, pick the one you comfortable with. And then he furthers to satisficing and optimizing metric, also discuss the speed of convergence of the algo. Somehow reminds me the famous netflix kaggle competition, that netflix ends up operalize the second winner's algorithme, as a trade of accuracy and complexity/speed.  

Another good practice is always calculate the lift based on baseline performance, i.e. flip of the coin or human guess.
#### Week 2: ML Strategy (2)
Build first system quickly, then iteration. Keep the try-n-err, hurray for progress and also celebrate failure.  
14:55 .. [celebrate failure][utube] at a ted talk.. that is the RIGHT attitude in this amazing and challenging field... ;)

> if you are applying to your machine learning algorithms to a new application, and if your main goal is to build something that works, as opposed to if your main goal is to invent a new machine learning algorithm which is a different goal, then your main goal is to get something that works really well. I'd encourage you to build something quick and dirty. Use that to do bias/variance analysis, use that to do error analysis and use the results of those analysis to help you prioritize where to go next.

Transfer learning, model reuse is kinda cool. Well, a big business to sell pre-trained Models too.

### Course 4: Convolutional Neural Networks
CNN is here to solve a particular problem, _computer vision_.

#### Week 1: Foundations of Convolutional Neural Networks
Movtivations of CNN:  
1. Parameter sharing
2. Sparsity of connections
3. Equivariance (briefly mentioned, as observation)

#### Week 2: Deep convolutional models: case studies
[inception network][inception]  
paper [Szegedy et al., 2014, _Going Deeper with Convolutions_]  
Transfer Learning to utilize pre-trained models and weights.

#### Week 3: Object detection
#### Week 4: Special applications: Face recognition & Neural style transfer
Neural style transfer,  computer can do art too, not just art, but Picasso art.  
[Gatys et al., 2015. _A neural algorithm of artistic style_]


### Course 5: Sequence Models
Furthermore, RNN is here to solve particular set of problems, _speech recognition, music synthesis, translation, NLP_.  

One more thing I like this course is that the interviews :)

P.P.S
To load the source and _boldly_ go
```
source("https://raw.githubusercontent.com/MikeXL/brain/master/perceptron.r")
make.it.so()
```

[neuron]: https://pbs.twimg.com/media/DOVmnXtUIAAuzeg.jpg:large
[dl]: http://deeplearning.ai "deep learning courses"
[fast]: http://fast.ai
[utube]: https://youtu.be/40riCqvRoMs?t=14m45s "celebrate failure"
[inception]: http://knowyourmeme.com/memes/we-need-to-go-deeper
[fastai_tube]: https://www.youtube.com/playlist?list=PLeRmE3N7ThDC6uD5aSuB6t3HRwzDDw9Sq
