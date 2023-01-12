_Exercise assignment for the course [Unsupervised and Reinforcement Learning (AAI-URL)](https://inf-git.fh-rosenheim.de/aai-url/hsro-aai-url-github-io) in the [Bachelor of AAI](https://www.th-rosenheim.de/en/technology/computer-science-mathematics/applied-artificial-intelligence-bachelors-degree) at [Rosenheim University of Applied Sciences](http://www.th-rosenheim.de)_

# Assigment 04 - Python, and more

> As usual: The solution is available in branch "musterloesung"!

## Task 1: Python katas (as usual!)

### a) Transpose a List of Lists  (3 ways!)

Let's write some code that transposes a list of lists, sometimes called a 2-dimensional array. By transposing a list of lists, we are essentially turning the rows of a matrix into its columns, and its columns into the rows.

**Rule**: Do not use numpy!!!

```python
original = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]
transposed = [
    [1, 4, 7], 
    [2, 5, 8], 
    [3, 6, 9]
]
```

1) Transpose using for-loop(s)

2) Use a list comprehension to transpose it

3) Use the zip-function to transpose a list of lists

### b) Execution time comparisons for-loop vs comprehensions

Let's use a simple scenario for a loop operation - we have a list of numbers, and we want to remove the odd ones. One important thing to keep in mind is that we can't remove items from a list as we iterate over it. Instead, we have to create a new one containing only the even numbers:

Given list:

```python
MILLION_NUMBERS = list(range(1_000_000))
```

Can you write the code using a for-loop and comprehensions?

Do this on comandline! Name your file `filter.py` and both methods `for_loop` and `list_comprehension`. Execute it with

for-loop:

```bash
python -m timeit -s "from filter import for_loop" "for_loop()"
```

comprehension-loop

```bash
python -m timeit -s "from filter_list import list_comprehension" "list_comprehension()"
```

Any idea to make it even faster?


## Task 2: Calculate the variance-covariance matrix

Consider the following matrix:

```python
X=[[4.0, 2.0, 0.60],
   [4.2, 2.1, 0.59],
   [3.9, 2.0, 0.58],
   [4.3, 2.1, 0.62],
   [4.1, 2.2, 0.63]]
```

The set of 5 observations, measuring 3 variables, can be described by its mean vector and variance-covariance matrix. 

The three variables, from left to right are the length, width, and height of a certain object, for example. 
Each row vector Xi is another observation of the three variables (or components).

## Task 3: Correlation

Given is the following random dataset:

```python
# generate related variables
from numpy.random import randn
from numpy.random import seed

# seed random number generator
seed(1)

# prepare correlated data
data1 = 20 * randn(1000) + 100
data2 = data1 + (10 * randn(1000) + 50)
```

### a)

What are the mean and stdv of data1 and data2? Use numpy!


### b)

Plot the data as a scatter plot!

### c)

Calculate the covariance between data1 and data2. Use numpy.cov!

### d)

The Pearson correlation coefficient (named Karl Pearson) can be used to summarize the strength of the linear relationship between two data samples.

Pearson’s correlation coefficient is calculated as the covariance of the two variables divided by the product of the standard deviation of each data sample. It is the normalization of the covariance between the two variables to give an interpretable score.

```
Pearson's correlation coefficient = covariance(X, Y) / (stdv(X) * stdv(Y))
```
What can we extract from the value?
