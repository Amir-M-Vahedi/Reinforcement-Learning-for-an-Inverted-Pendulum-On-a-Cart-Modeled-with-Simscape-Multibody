# Reinforcement Learning for an Inverted Pendulum On a Cart Modeled with Simscape Multibody
## Overview
This project focuses on developing a platform for reinforcement learning (RL) to control an inverted pendulum mounted on a cart, a classic problem in control theory demonstrating the application of RL in dynamic system stabilization. The dynamic model is crafted in the Simscape Multibody environment, with components modeled in SOLIDWORKS and imported into Simscape via integration with MATLAB.
<p align="center">
<img width="881" alt="Screenshot 2022-10-07 105709" src="https://user-images.githubusercontent.com/115154998/194497009-68b96c71-b1fa-41ac-88ff-a8d14d41112d.png">
</p>

## Project Components
- **Dynamic Model**: A detailed Simscape Multibody simulation of the inverted pendulum system, with parts designed in SOLIDWORKS and integrated into MATLAB.
- **Training Script (`Training.m`)**: A MATLAB script to load essential parameters and variables for RL training. The script is designed to be flexible, allowing modifications to enhance RL training outcomes.
- **Reinforcement Learning Model (`RL_InvPend_D2.slx`)**: A Simulink model containing the RL agent, the reward function, and the Simscape Multibody blocks. This model is pivotal for running simulations and training the RL agent.

## Objective
The primary goal is to create an accessible and modifiable RL training environment for the inverted pendulum system, allowing for iterative improvements and experimentation with different control strategies.

## Getting Started
1. **Environment Setup**: Ensure MATLAB, Simulink, Simscape Multibody, and the Reinforcement Learning Toolbox are installed.
2. **Model Importation**: Open the Simscape Multibody model. Ensure the SOLIDWORKS to MATLAB linkage is properly configured to import the physical components.
3. **Parameter Initialization**: Use the `Training.m` file to load and modify the system parameters for the RL agent's training process.
4. **Simulation and Training**: Run the `RL_InvPend_D2.slx` Simulink file to start the simulation. Observe the RL agent's performance and make adjustments to the model parameters as necessary for optimization.

## Future Enhancements
- **Model Parameters**: Ongoing enhancements to model parameters and initialization scripts to simplify user access and allow for more straightforward modifications.
- **Agent Training**: Continuous improvement of the RL training script to achieve better control results and system stability.

