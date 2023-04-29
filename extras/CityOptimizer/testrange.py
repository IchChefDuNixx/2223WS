# %%
import itertools
import time

# %%

x = 2000

t = time.time()

listy = []
for i in range(x):
    for j in range(x):
        listy.append((i,j))
        
print(f"{time.time()-t}")

t = time.time()

pos = set(itertools.product(range(x), range(x)))


print(f"{time.time()-t}")

