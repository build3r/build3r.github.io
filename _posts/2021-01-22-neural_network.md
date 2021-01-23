---
layout: single
title:  "Neural Networks From Ground Up"
date:   2021-01-22 19:45:46 +0530

---
Saw and amazing [video](https://www.youtube.com/watch?v=aircAruvnKk) by 3Blue1Brown. Where he introduces neural neyworks not as a black box but each neuron as a function which maps the input to the output.

### 1 - Intro
Previously researchers used to sigmoid function as an activation function which apparently gave poor performance nowadays most researchers use RELU.

The transformation in simple form is written by
a<sup>(1)</sup> = RELU(**W***a<sup>(0)</sup> + **B**)
where:
W = Weight Matrix
B = Bias matrix

### 2 - CostFunction and Back Propagation
Here we learn about the cost function which calculates how well an algorithm is doing. And use it to give feedaback to our network.

### 3 - Working of Back Propagation
In the second video we learn about the structure of neural and network and how it is intialised. Also how the cosr function is use to nudge the weighta and biases to reac he local minima using the negative gradient descent (equivalent to slope on an 2D plane). In practice we use Schotastic Gradient Descent (SGD)

### 4 - Back Propagation Calaculus
Here we devel deep into the math of calculating the SGD using calculus. I might need to re-learn calculus to completely comphrend this.
The final formula for single neuron:
<img src="/assets/images/single_neuron_formula.png" alt="single" style="zoom:50%;" />

Formula for 'n' neurons:

![image-20210122135726399](/assets/images/n_neuron_formula.png)


Source:
[Youtube Link](https://www.youtube.com/watch?v=aircAruvnKk)
