import numpy as np
import matplotlib.pyplot as plt
state = 2
iteration = 100
burnin = 0
memory = np.zeros(iteration-burnin)
P = np.array(((0,0.5,0,0.5),
             (0.5,0,0.5,0),
             (0,1/3,1/3,1/3),
             (0.5,0,0.5,0)))
A = np.array(((.9,.1,0,0,0),
              (.5,0,.5,0,0),
              (0,1/10,0,9/20,9/20),
              (0,0,.5,0,.5),
              (0,0,.5,.5,0)))
dimension = np.size(P[:,0])
incidence = np.zeros(dimension)
occurence = np.zeros(dimension)

for i in range(iteration):
    if i >= burnin:
        memory[i-burnin] = state
    state = (np.random.choice(dimension,1,p=P[state-1,:]))[0] + 1
    
for i in range(dimension):
    incidence[i] = len(memory[memory==(i+1)])
    
occurence = incidence / (iteration-burnin)

plt.bar(np.arange(dimension), occurence, align='center', alpha=0.5)
plt.xticks(np.arange(dimension), np.arange(dimension)+1)
plt.ylabel('Relative Auftrittshäufigkeit')
plt.title('Auftrittshäufigkeit der Zustände')
plt.show()
    