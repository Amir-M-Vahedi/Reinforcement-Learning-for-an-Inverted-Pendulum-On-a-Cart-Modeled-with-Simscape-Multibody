# Reinforcement Learning for an Inverted Pendulum On a Cart Modeled with Simscape Multibody
This project has been done in order to create a platform for Reinforcement Learning of an Inverted Pendulum On a Cart.
The dynamic model of the inverted pendulum was created in Simscape Multibody environment.
Each parts were modeled in SOLIDWORKS and then imported to the Simscape by using the links between SOLIDWORKS and MATLAB. The model is shown in continue.

<p align="center">
<img width="881" alt="Screenshot 2022-10-07 105709" src="https://user-images.githubusercontent.com/115154998/194497009-68b96c71-b1fa-41ac-88ff-a8d14d41112d.png">
</p>
The Training.m file load essential parameters and variables. It can be modified in order to improve the results. It worth to mention that the given agent is not trained.
The RL_InvPend_D2.slx simulink file contains the agent, reward function and simscape multibody blocks that can be modified.
I'm going to enhance the model parameters and change the Initialization in a way that user has a an easy access to every parameters.
