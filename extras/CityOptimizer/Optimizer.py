"""
use some kind of neural network
use algorithm to build city and make choice of where to place a building a trainable parameter
use choice sequence as input vector plus result (#of roads, buildings placed successfully)
make result an objective function/loss function from input vector
use good cities and random choices as data

chat:
I have a python program during which an algorithm chooses some value out of a given list, twice with different lists respectively. that leads to different results. can you help me convert these choices into something I could train with machine learning to minimize the result?
Yes, you can use machine learning to train a model that can make the optimal choice out of the given lists in order to minimize the result.

One approach is to use supervised learning with a labeled dataset. You can create a dataset by running your algorithm on many different lists and recording the input lists and the corresponding results. This dataset can be used to train a machine learning model to predict the optimal choice for any given list.

To do this, you would need to choose a suitable machine learning algorithm, such as a decision tree or a random forest, and train it on your dataset. The algorithm would need to be trained to predict the optimal choice based on the input list.

Once the model is trained, you can use it to make predictions on new lists and choose the optimal value accordingly. This should result in a lower overall result, as the model has been trained to make the best choice for each list.

It is important to note that the quality of the machine learning model will depend on the quality of the labeled dataset used to train it. Therefore, it is crucial to collect a large and diverse dataset that captures the full range of possible input lists and outcomes.




minecraftkuchen@gmail.com
how would a machine learning system know what the goal is? how can I tell it to pursue maximising a certain value?
In order to train a machine learning system to pursue a certain goal, you need to define the goal as the objective function or the loss function that the model will optimize during training.

In your case, the goal is to minimize the result obtained from your algorithm. Therefore, you need to define the objective function or the loss function as a function that measures the distance or the difference between the obtained result and the optimal result.

For example, you can define the objective function as the absolute difference between the obtained result and the optimal result. Then during training, the model will learn to minimize this objective function by adjusting its parameters to make better choices for the input lists.

Once the model is trained, you can use it to make predictions on new lists and choose the optimal value based on the predicted outcome. The model will make predictions that minimize the objective function, which in turn minimizes the result obtained from your algorithm.

It is important to note that the choice of objective function will affect the quality of the trained model. Therefore, it is important to choose an appropriate objective function that aligns with your goal of minimizing the result obtained from your algorithm.




minecraftkuchen@gmail.com
would it be able to outperform the given training data by somehow getting a lower score than every datapoint I provide?
It is possible for a machine learning model to outperform the training data and achieve a lower score than every datapoint you provide, but it depends on several factors.

If the model has been trained on a limited amount of data or the data does not fully capture the complexity of the problem, the model may not be able to generalize well to new, unseen data. In this case, the model may perform worse on new data than on the training data.

On the other hand, if the model has been trained on a large and diverse dataset that captures the full range of possible input lists and outcomes, and the model is complex enough to capture the underlying patterns in the data, then the model may be able to outperform the training data and achieve a lower score than every datapoint you provide.

However, it is important to note that machine learning models are not perfect and may not always make the optimal choices for every input list. Therefore, it is important to evaluate the performance of the model on a separate test dataset to ensure that it generalizes well to new, unseen data.




minecraftkuchen@gmail.com
my algorithm iterates maybe 100 times before it gets a final result. whenever a choice is made for x, it always changes the possible values for the next choice of x. how would I need to treat this? or can I just use a vector of all consecutive choices for x as input into my machine learning model?
If your algorithm iterates 100 times before getting a final result and the choices for x are interdependent, it may be necessary to include the history of all previous choices as input to the machine learning model.

You can represent the history of all previous choices as a sequence or a vector of all consecutive choices for x. Each element in the sequence or vector corresponds to the choice for x at a certain iteration in the algorithm. By including the history of all previous choices as input to the model, you can capture the interdependence of the choices and make better predictions for the optimal choice at each iteration.

To train the machine learning model on this data, you would need to ensure that the input sequence or vector is correctly aligned with the corresponding output result obtained from the algorithm. The output result obtained from the algorithm should correspond to the final result obtained after 100 iterations.

You can then use the labeled dataset to train a machine learning model, such as a recurrent neural network (RNN) or a sequence-to-sequence model, to predict the optimal choice for x at each iteration based on the history of all previous choices.

It is important to note that including the history of all previous choices as input may increase the complexity of the model and the computational resources required to train the model. Therefore, it is important to carefully choose a suitable machine learning algorithm and optimize the training process for the specific problem at hand.




minecraftkuchen@gmail.com
can you explain the third paragraph in more detail? how can I align a vector with an integer result?
Sure, let me explain the third paragraph in more detail.

In order to train a machine learning model to predict the optimal choice of x at each iteration based on the history of all previous choices, you need to align the input sequence or vector with the corresponding output result obtained from the algorithm.

To do this, you can label each input sequence or vector with the corresponding output result obtained from the algorithm after 100 iterations. This output result should be an integer value that reflects the final result obtained after iterating the algorithm 100 times.

For example, suppose that you have an input sequence of choices for x represented as [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]. You can label this input sequence with the corresponding output result obtained from the algorithm after 100 iterations, which might be an integer value of 1234.

In this case, you would create a labeled dataset that contains pairs of input sequences and output results. For example, you might have a dataset with multiple input sequences and their corresponding output results:

[[[1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 1234],
[[2, 4, 6, 8, 10, 12, 14, 16, 18, 20], 5678],
...
]

During training, the machine learning model learns to predict the output result based on the input sequence. By minimizing the difference between the predicted output result and the actual output result obtained from the algorithm, the model learns to make better predictions for the optimal choice of x at each iteration based on the history of all previous choices.

I hope this explanation helps!




minecraftkuchen@gmail.com
yes it totally does. the one thing I'm still unsure about, is that when you say "predict" I think about a classifier, which I don't want to build and I don't know how to implement a custom objective function. I may be confusing it with activation functions
I apologize for any confusion. When I say "predict," I am referring to the machine learning model's ability to output a value that represents the model's best guess for the output result based on the input sequence or vector.

In this case, you would want to train a machine learning model that is capable of performing regression rather than classification. A regression model is a type of machine learning model that is used to predict a continuous numerical output value.

To train a regression model, you would need to define an appropriate loss function that measures the difference between the predicted output value and the actual output value obtained from the algorithm. The loss function is used to guide the training process by telling the model how much error it is making and how it should adjust its parameters to minimize that error.

There are many different loss functions that can be used for regression problems, depending on the specific problem you are trying to solve. Some common loss functions for regression problems include mean squared error (MSE), mean absolute error (MAE), and mean squared logarithmic error (MSLE).

You can choose the appropriate loss function based on your specific problem and goals, and you can implement it in the training process using a machine learning library or framework such as TensorFlow, PyTorch, or scikit-learn.

I hope this clarifies things! Let me know if you have any further questions.




minecraftkuchen@gmail.com
using pytorch, can you quickly show me an example of what I would need to do to make my machine learning system minimize the results?
Sure, here's a simple example of how you could use PyTorch to train a neural network to minimize the results obtained from your algorithm.

First, you would need to create a dataset of input sequences and their corresponding output results, as I described earlier. You could represent each input sequence as a PyTorch tensor, and each output result as a scalar value. Here's an example:

python
Copy code
import torch

# Example dataset
dataset = [
    (torch.tensor([1, 2, 3, 4, 5]), 10),
    (torch.tensor([2, 4, 6, 8, 10]), 20),
    (torch.tensor([3, 6, 9, 12, 15]), 30),
    # ... more data ...
]
Next, you would need to define a PyTorch model that takes an input sequence and outputs a scalar value representing the predicted output result. Here's an example of a simple model that uses a feedforward neural network with a single hidden layer:

python
Copy code
import torch.nn as nn
import torch.nn.functional as F

class MyModel(nn.Module):
    def __init__(self):
        super(MyModel, self).__init__()
        self.fc1 = nn.Linear(5, 10)  # input size: 5 (length of input sequence), output size: 10
        self.fc2 = nn.Linear(10, 1)  # input size: 10, output size: 1

    def forward(self, x):
        x = F.relu(self.fc1(x))
        x = self.fc2(x)
        return x
In this example, the input to the model is a tensor of shape (batch_size, 5), where batch_size is the number of input sequences in each batch. The output of the model is a tensor of shape (batch_size, 1), where each element represents the predicted output result for the corresponding input sequence.

Next, you would need to define a loss function that measures the difference between the predicted output result and the actual output result obtained from your algorithm. For example, you could use mean squared error (MSE) as the loss function:

python
Copy code
criterion = nn.MSELoss()
Finally, you would need to define an optimizer that updates the model's parameters based on the gradients of the loss function. For example, you could use stochastic gradient descent (SGD) as the optimizer:

python
Copy code
optimizer = torch.optim.SGD(model.parameters(), lr=0.01)
Once you have defined the model, loss function, and optimizer, you can train the model on your dataset using PyTorch's built-in training loop. Here's an example:

python
Copy code
# Initialize the model, loss function, and optimizer
model = MyModel()
criterion = nn.MSELoss()
optimizer = torch.optim.SGD(model.parameters(), lr=0.01)

# Train the model
for epoch in range(num_epochs):
    for inputs, targets in dataloader:
        # Forward pass
        outputs = model(inputs)

        # Compute the loss
        loss = criterion(outputs, targets)

        # Backward pass and optimization
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

    # Compute the validation loss after each epoch (optional)
    with torch.no_grad():
        val_loss = 0
        for inputs, targets in val_dataloader:
            outputs = model(inputs)
            val_loss += criterion(outputs, targets)
        val_loss /= len(val_dataloader)

    # Print the training and validation loss
    print(f"Epoch {epoch+1}/{num_epochs}, Train Loss: {loss.item():.4f



minecraftkuchen@gmail.com
it seems that dataloader and val_dataloader were never defined and give me an error
You're right, I apologize for the confusion. The dataloader and val_dataloader objects are used to load the data into batches during training and validation, respectively. Here's an updated example that includes the missing code:

python
Copy code
import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.utils.data import DataLoader, random_split, TensorDataset

# Example dataset
dataset = [
    (torch.tensor([1, 2, 3, 4, 5]), 10),
    (torch.tensor([2, 4, 6, 8, 10]), 20),
    (torch.tensor([3, 6, 9, 12, 15]), 30),
    # ... more data ...
]

# Split the dataset into training and validation sets
train_size = int(0.8 * len(dataset))
val_size = len(dataset) - train_size
train_dataset, val_dataset = random_split(dataset, [train_size, val_size])

# Define the data loaders
batch_size = 32
train_dataloader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
val_dataloader = DataLoader(val_dataset, batch_size=batch_size)

# Define the PyTorch model
class MyModel(nn.Module):
    def __init__(self):
        super(MyModel, self).__init__()
        self.fc1 = nn.Linear(5, 10)  # input size: 5 (length of input sequence), output size: 10
        self.fc2 = nn.Linear(10, 1)  # input size: 10, output size: 1

    def forward(self, x):
        x = F.relu(self.fc1(x))
        x = self.fc2(x)
        return x

# Initialize the model, loss function, and optimizer
model = MyModel()
criterion = nn.MSELoss()
optimizer = torch.optim.SGD(model.parameters(), lr=0.01)

# Train the model
num_epochs = 10
for epoch in range(num_epochs):
    for inputs, targets in train_dataloader:
        # Forward pass
        outputs = model(inputs)

        # Compute the loss
        loss = criterion(outputs, targets)

        # Backward pass and optimization
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

    # Compute the validation loss after each epoch
    with torch.no_grad():
        val_loss = 0
        for inputs, targets in val_dataloader:
            outputs = model(inputs)
            val_loss += criterion(outputs, targets)
        val_loss /= len(val_dataloader)

    # Print the training and validation loss
    print(f"Epoch {epoch+1}/{num_epochs}, Train Loss: {loss.item():.4f}, Val Loss: {val_loss.item():.4f}")
In this example, we define a train_dataset and val_dataset by randomly splitting the original dataset. We then create data loaders for each of these datasets using DataLoader, which allows us to load the data in batches and shuffle the training data.

During training, we iterate over the train_dataloader, computing the loss and gradients for each batch, and updating the model parameters with the optimizer. We also compute the validation loss after each epoch using the val_dataloader.

The final print statement shows the training and validation losses after each epoch. You can monitor these values to ensure that the model is learning and not overfitting to the training data.
"""

#!/usr/bin/env python
# coding: utf-8

# In[1]:


# imports
import numpy as np
import matplotlib.pyplot as plt
import json
import re # regular expression
from heapq import heappush, heappop
import scipy.spatial
import random
from typing import Literal
from operator import itemgetter
from win10toast import ToastNotifier


class Grid: # independent of city data
    def __init__(self, size, rectangles:dict={}):
        self.size = size # (x, y)
        self.rectangles = rectangles # {id: [x, y, length, height, "type"]}
        self.reset_all_cell_values()
        if len(rectangles) > 0:
            self.add_all_to_grid()
        self.coordinates = set()
        self.make_coordinates_set(True)
        self.STREETVALUE = 4
        
    # Initialize the grid with a negative value
    def reset_all_cell_values(self, reset_to:int=-2):
        self.grid = np.array([[reset_to for _ in range(self.size[1])] for _ in range(self.size[0])])

    # general iterator over rectangle
    def rectangle_iterator(self, rectangle, function):
        pass
    
    def make_coordinates_set(self, check_validity:bool=False):
        for i in range(self.size[0]):
            for j in range(self.size[1]):
                if check_validity:
                    if self.get_cell_value(i,j) >= 0:
                        self.coordinates.add((i,j))
                else:
                    self.coordinates.add((i,j))
    
    # Iterate through the dictionary self.rectangles and "draw" them on the grid
    def set_all_cell_values(self):
        for key in self.rectangles:
            x, y, l, h, type = self.rectangles[key]
            for i in range(x, x+l):
                for j in range(y, y+h):
                    self.set_single_cell_value(i,j,type)
    
    # Sets the same value in the grid for a given rectangle...
    def set_cell_values_rectangle(self, rectangle):
        if isinstance(rectangle, Rectangle):
            x, y, l, h, type = self.rectangles[rectangle.id]
            for i in range(x, x+l):
                for j in range(y, y+h):
                    self.set_single_cell_value(i,j,type)
        #...or a list with coordinates and size
        elif isinstance(rectangle, list):
            x, y, l, h, type = rectangle
            for i in range(x, x+l):
                for j in range(y, y+h):
                    self.set_single_cell_value(i,j,type)
        else:
            print("unsupported type")
        
    # "draw" single square        
    def set_single_cell_value(self, x, y, value):
        self.grid[x, y] = value

    # replace values on cells with matching cell_value, default to town_hall + scaling
    def draw_town_hall(self, cell_value:int=10):
        self.set_cell_values_rectangle([x[0:4] + [self.STREETVALUE] for x in self.rectangles.values() if x[4] == cell_value][0])
        
    # retrieve type of certain square
    def get_cell_value(self, x, y):
        return self.grid[x][y]

    # actually draw grid
    def draw(self, alt_grid=0):
        if isinstance(alt_grid,int):
            drawing_grid = self.grid
        else:
            drawing_grid = alt_grid
        plt.figure(figsize=(10,10))
        plt.imshow(drawing_grid)
        plt.colorbar(fraction=0.03,aspect=50,pad=0)
        plt.show
        
    # draw a new diagram with highlighted empty cells and returns their amount, CURRENTLY BREAKS THE GRID
    def highlight_empty(self):
        number_of_empty_cells = 0
        for i in range(self.size[0]):
            for j in range(self.size[1]):
                if self.get_cell_value(j,i) == 0:
                    number_of_empty_cells += 1
                    self.set_single_cell_value(j,i,100+j+i)
        self.draw()
        return number_of_empty_cells
    
    # add rectangle object to dictionary self.rectangles    
    def add_to_grid(self, rectangle):
        # check for overlaps
        x, y, l, h, value = rectangle.x, rectangle.y, rectangle.length, rectangle.height, rectangle.value
        for i in range(x, x+l):
            for j in range(y, y+h):
                if self.get_cell_value(i,j) > 0:
                    print("Error: Overlap")
        self.rectangles[rectangle.id] = [x, y, l, h, value]
        self.set_cell_values_rectangle(rectangle)
    
    # given prior data, replace bad formatting of rectangles in-place
    def add_all_to_grid(self):
        for rectangle in self.rectangles.values():
            self.add_to_grid(rectangle)
        
    # creates new dictionary for buildings in the city without streets
    def remove_streets_and_patches(self):
        self.buildings = {}
        for key in self.rectangles:
            if self.rectangles[key][4] > 1:
                self.buildings[key] = [self.rectangles[key]]
    
    #TODO: placeholder for actual efficiency calculation
    def efficiency(self):
        # number of streets w/ town hall
        return np.sum([1 for x,y in self.coordinates if self.get_cell_value(x,y) == self.STREETVALUE]) - 7*6
        
    # returns true if adjacent cell is a street
    def is_connected(self, rectangle, draw:bool=False):
        y, x, height, width = rectangle[:4] # e.g. [8, 13, 4, 3, 5]
        isConnected = False
        for i in range(height): # checking for streets on vertical edges
            if self.get_cell_value(y+i, x-1) == 1 or self.get_cell_value(y+i, x+width) == 1:
                isConnected = True
                break
            if draw:
                self.set_single_cell_value(y+i, x-1, 99)
                self.set_single_cell_value(y+i, x+width, 99)
         
        if not isConnected:            
            for j in range(width): # checking for streets on horizontal edges
                if self.get_cell_value(y-1, x+j) == 1 or self.get_cell_value(y+height, x+j) == 1:
                    isConnected = True
                    break
                if draw:
                    self.set_single_cell_value(y-1, x+j, 99)
                    self.set_single_cell_value(y+height, x+j, 99)
                    
        return isConnected
    
    # Check if rectangle is too big or overlaps with other rectangles    
    def is_valid(self, x, y, rectangle):
        for i in range(x, x + rectangle[0]):
            for j in range(y, y + rectangle[1]):
                if i >= self.size[0] or j >= self.size[1] or self.get_cell_value(i,j) != 0:
                    return False
        return True
    
    # make list of points of possible top left coordinates for a building
    def valid_coords_list(self, building):
        valid_coords = []
        for (x,y) in self.coordinates:
            if self.is_valid(x, y, building):
                valid_coords.append((x,y))
        # print(building,len(valid_coords))
        return valid_coords
    
    # TODO: select (x,y) from valid_coords based on heuristic, currently first element
    def placement_heuristic(self, coordinates, building):
        if coordinates: #check if valid_coords has an element
            return coordinates[random.randint(0,len(coordinates)-1)]
        else:
            # print("placement heuristic didn't get any valid solutions")
            return (-1,-1)
    
    # make list of points that are (considered) a road
    def roads_list(self, x, y, building):
        roads = []
        for (x,y) in self.coordinates:
            if self.get_cell_value(x,y) == self.STREETVALUE:
                roads.append((x,y))
        # print(len(roads),roads)
        return roads
        
    # make list of points around new building except for outer corners
    def goal_coords_list(self, x, y, building):
        goalCoordinates = []
        borderStatesLeft = [(x,y-1) for x in range(x,x+building[0])]
        borderStatesRight = [(x,y+building[1]) for x in range(x,x+building[0])]
        borderStatesTop = [(x-1,y) for y in range(y,y+building[1])]
        borderStatesBottom = [(x+building[0],y) for y in range(y,y+building[1])]
        borderStates = borderStatesLeft + borderStatesRight + borderStatesTop + borderStatesBottom
        # print(borderStates)
        for i,j in borderStates:
            if 0 <= i <= self.size[0] and 0 <= j <= self.size[1] and self.get_cell_value(i,j) in {0,self.STREETVALUE}: # and not (i == 0 and (j == 0 or j == building[1] + 1) or i == building[0] + 1 and (j == 0 or j == building[1] + 1)):
                goalCoordinates.append((i,j))
                # self.set_single_cell_value(i,j,1)
        # print(goalCoordinates)
        return goalCoordinates
    
    # make list of points with distance from all roads to all goalStates
    def distances_list(self, roads, goalCoordinates):
        distances = []
        for curr_road in roads:
            for goalState in goalCoordinates:
                dist = scipy.spatial.distance.cityblock(curr_road,goalState)
                distances.append((dist,curr_road,goalState))
        # print(len(distances),distances)
        return distances
    
    # make list of points with minimum distance from all roads to all goalStates
    def min_distances_list(self, roads, goalCoordinates):
        distances = self.distances_list(roads, goalCoordinates)
        
        # reduce the distances to just entries with min dist
        if distances: # checks if distances is empty
            min_dist = min(d for d,_,__ in distances)
            min_list = [(_,__) for d,_,__ in distances if d == min_dist]
        else:
            min_list = []
        # print(min_list)
        return min_list
    
    # make list of points with maximum distance from all roads to all goalStates
    def max_distances_list(self, roads, goalCoordinates):
        distances = self.distances_list(roads, goalCoordinates)
        
        # reduce the distances to just entries with max dist
        if distances: # checks if distances is empty
            max_dist = max(d for d,_,__ in distances)
            max_list = [(_,__) for d,_,__ in distances if d == max_dist]
        else:
            max_list = []
        # print(max_list)
        return max_list      
                
    # shortestPathBinaryMatrix        
    def findPath(self, start_point, goalStates):
        if self.grid[start_point] == 1:
            print("stuck at start point")
        shortest_path = self.a_star_graph_search(
            start_point        = start_point, 
            goal_function      = self.get_goal_function(goalStates),
            successor_function = self.get_successor_function(),
            heuristic          = self.get_heuristic()
        )
        if shortest_path is None: 
            # print(f"no path found from {start_point}")
            return -1
        else:
            for step in shortest_path:
                self.grid[step] = self.STREETVALUE
            return (len(shortest_path),shortest_path)

    def a_star_graph_search(
                self,
                start_point,
                goal_function,
                successor_function,
                heuristic
        ):
        visited = set()
        came_from = dict()
        distance = {start_point: 0}
        frontier = PriorityQueue()
        frontier.add(start_point)
        while frontier:
            node = frontier.pop()
            if node in visited:
                continue
            if goal_function(node):
                return self.reconstruct_path(came_from, start_point, node)
            visited.add(node)
            for successor in successor_function(node):
                frontier.add(
                    successor,
                    priority = distance[node] + 1 + heuristic(successor)
                )
                if (successor not in distance
                    or distance[node] + 1 < distance[successor]):
                    distance[successor] = distance[node] + 1
                    came_from[successor] = node
        return None

    def reconstruct_path(self, came_from, start, end):
        """
        >>> came_from = {'b': 'a', 'c': 'a', 'd': 'c', 'e': 'd', 'f': 'd'}
        >>> reconstruct_path(came_from, 'a', 'e')
        ['a', 'c', 'd', 'e']
        """
        reverse_path = [end]
        while end != start:
            end = came_from[end]
            reverse_path.append(end)
        return list(reversed(reverse_path))    

    def get_goal_function(self, goalStates):
        """
        >>> f = get_goal_function([[0, 0], [0, 0]])
        >>> f((0, 0))
        False
        >>> f((0, 1))
        False
        >>> f((1, 1))
        True
        """
        # M = len(grid)
        # N = len(grid[0])
        # def is_bottom_right(cell):
        #     return cell == (M-1, N-1)
        # return is_bottom_right
        
        def is_in_goal_state(cell):
            return cell in goalStates
        return is_in_goal_state      
            
    def get_successor_function(self):
        """
        >>> f = get_successor_function([[0, 0, 0], [0, 1, 0], [1, 0, 0]])
        >>> sorted(f((1, 2)))
        [(0, 1), (0, 2), (2, 1), (2, 2)]
        >>> sorted(f((2, 1)))
        [(1, 0), (1, 2), (2, 2)]
        """
        def get_clear_adjacent_cells(cell):
            i, j = cell
            return (
                (i + a, j + b)
                for a in (-1, 0, 1)
                for b in (-1, 0, 1)
                
                #if a != 0 or b != 0
                if np.abs(a) + np.abs(b) == 1
                
                if 0 <= i + a < len(self.grid)
                if 0 <= j + b < len(self.grid[0])
                if self.grid[i + a][j + b] == 0
            )
        return get_clear_adjacent_cells    
            
    def get_heuristic(self):
            """
            >>> f = get_heuristic([[0, 0], [0, 0]])
            >>> f((0, 0))
            1
            >>> f((0, 1))
            1
            >>> f((1, 1))
            0
            """
            M, N = len(self.grid), len(self.grid[0])
            (a, b) = goal_cell = (M - 1, N - 1)
            def get_clear_path_distance_from_goal(cell):
                (i, j) = cell
                return max(abs(a - i), abs(b - j))
            return get_clear_path_distance_from_goal
    
    # converts self.grid values to 2-3 different values in preparation for A* search
    def binarization(self, needs_connection_val): # very destructive method, overriding most building values
        for (i,j) in self.coordinates:
            if self.grid[i,j] <= 0: pass
            elif self.grid[i,j] == 1: self.grid[i,j] = 0
            elif self.grid[i,j] > 1: self.grid[i,j] = needs_connection_val
            else: print("unhandled cell value")
    
    # TODO WIP, maybe dismantle into more methods or implement NMSLIB, dijkstras A*
    def auto_solve(self, solve_type:Literal["random","brute"], show_results:bool=False, topK:int=1, iterations:int=1):
        
        self.binarization(0)
        self.draw_town_hall()

        # make list with building's sizes, area, max dimension
        # remove town hall
        filtered_buildings = np.array([(b[2],b[3],b[2]*b[3],max(b[2:4])) for b in self.rectangles.values() if b[2] >= 2 and b[3] >= 2 and 4 <= b[4] < 10])
        # print(len(filtered_buildings), filtered_buildings)

        # sort filtered_buildings by total area, then max dimension, and reduce length
        # sorted_indices = np.lexsort((filtered_buildings[:,2],filtered_buildings[:,1]))
        sorted_indices = np.lexsort((filtered_buildings[:,1],filtered_buildings[:,2]))[::-1]
        ordered_buildings = np.array([filtered_buildings[i] for i in sorted_indices])[:,0:2]
        # print(len(ordered_buildings), ordered_buildings)

        resultsArr = []
        
        # not very useful and has one issue: sometimes it places 0 roads and not all buildings
        def random_solve(iterations:int):
            for i in range(iterations):
                buildings_placed_count = 0
                for curr_building in ordered_buildings:
                    # execution for single building    
                    valid_coords = self.valid_coords_list(curr_building) # [(a,b),(c,d),...,(n,m)]
                    (x,y) = self.placement_heuristic(valid_coords,curr_building) # (a,b)
                    roads = self.roads_list(x,y,curr_building) # [(a,b),(c,d),...,(n,m)]
                    goalStates = self.goal_coords_list(x,y,curr_building) # [(a,b),(c,d),...,(n,m)]
                    min_distances = self.min_distances_list(roads,goalStates) # [((a,b), (c,d)), ((e,f), (g,h)),...,((i,j), (k,l))]
                    # check valid states and pick a random road-reachable one
                    if goalStates:
                        failed_states = set()
                        for _ in range(len(min_distances)):
                            rand_list = [randint for randint in range(len(min_distances)) if randint not in failed_states]
                            rand = random.choice(rand_list)
                            if self.findPath(min_distances[rand][0],goalStates) != -1:
                                self.set_cell_values_rectangle([x,y,*curr_building,2])
                                buildings_placed_count += 1
                                break
                    # else:
                    #     print(f"min_distances empty for {curr_building} ({i})")
                # add result to semi-permanent storage
                # move next 2 lines in to get result for each state during construction
                curr_grid = np.copy(self.grid)
                resultsArr.append((i, self.efficiency(), curr_grid, buildings_placed_count))
                for (x_y) in self.coordinates:
                    self.set_single_cell_value(*x_y,0)# type: ignore 
                self.draw_town_hall()
                # print(f"{i}/{iterations}")
                
            if show_results:
                  print_results(resultsArr)
        
        def brute_solve():
            pass

        def print_results(resultsArr):    
            resultsArr.sort(key=itemgetter(1))
            for i in range(topK):
                print(f"roads used: {resultsArr[i][1]}, buildings placed: {resultsArr[i][3]}")
                plt.figure(figsize=(5,5))
                plt.imshow(resultsArr[i][2])
                plt.colorbar(fraction=0.03,aspect=50,pad=0)
                plt.show
            print(" --- ")
            resultsArr.sort(key=itemgetter(3), reverse=True)
            for i in range(topK):
                print(f"roads used: {resultsArr[i][1]}, buildings placed: {resultsArr[i][3]}")
                plt.figure(figsize=(5,5))
                plt.imshow(resultsArr[i][2])
                plt.colorbar(fraction=0.03,aspect=50,pad=0)
                plt.show  
                       
        if solve_type == "random":
            random_solve(iterations)
        elif solve_type == "brute":
            brute_solve()
        else:
            print("unhandled solve type")
        return resultsArr
        
# takes a city map json as input and executes all necessary methods to convert it to useful data
def read_city_json(source_json:str):
    buildingDict = {}
    citymapdata = json.load(open(source_json, encoding="UTF-8")) # dict_keys(['CityMapData', 'CityEntities', 'UnlockedAreas']), len = 770, 1606, 205
    buildingType_keys = np.unique([entity["type"] for entity in citymapdata["CityEntities"].values()])
    """['clan_power_production' 'cultural_goods_production' 'culture'
    'decoration' 'diplomacy' 'friends_tavern' 'goods' 'greatbuilding'
    'hub_main' 'hub_part' 'impediment' 'main_building' 'military' 'off_grid'
    'outpost_ship' 'production' 'random_production' 'residential'
    'static_provider' 'street' 'tower']"""
    buildingType_values = [99,99,4,3,99,99,99,8,99,99,99,10,6,99,99,7,4,5,99,1,2] # 99 => off_grid or not used
    buildingType = dict(zip(buildingType_keys, buildingType_values))
    
    def _read_city_unlocked_areas():
        # reading CityMapData and creating grid with unlocked areas set to value "0"
        for patch in citymapdata["UnlockedAreas"]:
            patch.setdefault("y", 0)
            patch.setdefault("x", 0)
            tempRect = Rectangle(patch["y"], patch["x"], patch["width"], patch["length"], 0)
            buildingDict[tempRect.id] = tempRect
        
    def _read_city_entities():
        # reading CityMapData and creating a dictionary of currently available buildings
        for cityentity in citymapdata["CityEntities"].values():
            cityentity.setdefault("width", 0)
            cityentity.setdefault("length", 0)
        
    def _read_city_map_data():
        # reading CityMapData and adding each building to the grid
        for building in citymapdata["CityMapData"].values():
            building.setdefault("y", 0)
            building.setdefault("x", 0)
            buildingEntity = citymapdata["CityEntities"][building["cityentity_id"]]
            # print(buildingType)
            if re.match("W_MultiAge*", buildingEntity["id"]):
                size = buildingEntity["components"]["AllAge"]["placement"]["size"]
                width, length = size["x"], size["y"]
            else:
                width, length = buildingEntity["width"], buildingEntity["length"]
            
            # TODO: replace constants by grid size  
            if 0 <= building["y"] <= 70 and 0 <= building["x"] <= 70:
                tempRect = Rectangle(building["y"], building["x"], length, width, buildingType[buildingEntity["type"]])
                buildingDict[tempRect.id] = tempRect
            else: pass#print(building)
    
    _read_city_unlocked_areas()
    _read_city_entities()
    _read_city_map_data()
    return buildingDict
                
class Rectangle:
    RECTANGLEID = 1
    
    def __init__(self, x:int=0, y:int=0, length:int=0, height:int=0, value:int=-1):
        self.x, self.y, self.length, self.height, self.value = x,y,length,height,value
        self.id = Rectangle.RECTANGLEID
        Rectangle.RECTANGLEID += 1
        
    def __str__(self) -> str:
        return str((self.id,self.x,self.y,self.length,self.height,self.value))
    
class PriorityQueue:
    
    def __init__(self, iterable=[]):
        self.heap = []
        for value in iterable:
            heappush(self.heap, (0, value))
    
    def add(self, value, priority=0):
        heappush(self.heap, (priority, value))
    
    def pop(self):
        priority, value = heappop(self.heap)
        return value
    
    def __len__(self):
        return len(self.heap)






# if __name__ == "__main__":
# Create a new grid

buildingDict = read_city_json("CityMapData.json")
palaceton = Grid((70,70),buildingDict)
# buildingDict = read_city_json("TestCityData.json")
# palaceton = Grid((20,20),buildingDict)
# palaceton.draw()
palaceton.auto_solve("random", show_results=True, iterations=1)

        
# toaster = ToastNotifier().show_toast("CityOptimizer", "Batch done", sound=False)

