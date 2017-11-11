# brain
a gleeful study of neural network and implementing an _vanilla_ nn

_inspired by Andrew Ng's [deep learning courses][dl]_  
_another good MooC I'd like to take [Fast AI][fast]_  

Cheers

![perceptron][neuron]


P.S.
Deep Learning Courses - my notes anyway   

### Course 1: Neural Networks and Deep Learning
#### Week 1: Introduction to deep learning
#### Week 2: Neural Network Basics
#### Week 3: Shallow neural networks
choice of activation function - identity, sigmoid, cos, tanh  
random initialization of weight parameters

#### Week 4: Deep Neural Networks
forward and backward propagation  
parameters and Hyperparameter

### Course 2: Improving Deep Neural Networks: Hyperparameter tuning, Regularization and Optimization
#### Week 1: Practical aspects of Deep Learning
Regularization  
Normalize inputs
Vanishing /Exploding gradients
#### Week 2: Optimization algorithms
#### Week 3: Hyperparameter tuning, Batch Normalization and Programming Frameworks

### Course 3: Structuring Machine Learning Projects
#### Week 1: ML Strategy (1)
Discuss of the using single number evaluation metric, be it, misclassification rate (I like to call it mis.), precision, recall or F1 score, pick the one you comfortable with. And then he furthers to satisficing and optimizing metric, also discuss the speed of convergence of the algo. Somehow reminds me the famous netflix kaggle competition, that netflix ends up operalize the second winner's algorithme, as a trade of accuracy and complexity/speed.  

Another good practice is always calculate the lift based on baseline performance, i.e. flip of the coin or human guess.
#### Week 2: ML Strategy (2)
Build first system quickly, then iteration. Keep the try-n-err, hurray for progress and also celebrate failure.  
14:55 .. [celebrate failure][utube] at a ted talk.. that is the RIGHT attitude in this amazing and challenging field... ;)

> if you are applying to your machine learning algorithms to a new application, and if your main goal is to build something that works, as opposed to if your main goal is to invent a new machine learning algorithm which is a different goal, then your main goal is to get something that works really well. I'd encourage you to build something quick and dirty. Use that to do bias/variance analysis, use that to do error analysis and use the results of those analysis to help you prioritize where to go next.

### Course 4: Convolutional Neural Networks
#### Week 1: Foundations of Convolutional Neural Networks
#### Week 2: Deep convolutional models: case studies
#### Week 3: Object detection
#### Week 4: Special applications: Face recognition & Neural style transfer

### Course 5: Sequence Models


[neuron]: https://pbs.twimg.com/media/DOVmnXtUIAAuzeg.jpg:large
[dl]: http://deeplearning.ai "deep learning courses"
[fast]: http://fast.ai
[utube]: https://youtu.be/40riCqvRoMs?t=14m45s "celebrate failure"
