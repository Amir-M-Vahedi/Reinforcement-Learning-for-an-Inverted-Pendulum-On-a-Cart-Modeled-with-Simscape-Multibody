%% Initialize
clc;clear;
InvPend_DataFile
load('initialAgent.mat')
Ts = 0.01; % Agent sample time
Tf = 5;    % Simulation end time

%% Training 
mdl = 'RL_InvPend';
open_system(mdl)
% Create Environment Interface
% Create the observation specification.
numObs = 4;
obsInfo = rlNumericSpec([numObs 1]);
obsInfo.Name = 'observations';
% Create the action specification.
numAct = 1;
actInfo = rlNumericSpec([numAct 1],'LowerLimit',-12,'UpperLimit',12);
actInfo.Name = 'Force';
% Create the environment interface for the walking robot model.
blk = [mdl,'/RL Agent'];
env = rlSimulinkEnv(mdl,blk,obsInfo,actInfo);
env.ResetFcn = @(in) localResetFcn(in);
rng(0);
% [criticNetwork,actorNetwork] = createNetworks(numObs,numAct);
% View the critic network configuration.
% figure
% plot(criticNetwork)
criticOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-2,... 
                                        'GradientThreshold',1,'L2RegularizationFactor',2e-4,'UseDevice',"gpu");
actorOptions = rlRepresentationOptions('Optimizer','adam','LearnRate',1e-3,...
                                       'GradientThreshold',1,'L2RegularizationFactor',1e-5,'UseDevice',"gpu");
critic = rlRepresentation(criticNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'action'},criticOptions);
actor  = rlRepresentation(actorNetwork,obsInfo,actInfo,'Observation',{'observation'},'Action',{'ActorTanh1'},actorOptions);
agentOptions = rlDDPGAgentOptions;
agentOptions.SampleTime = Ts;
agentOptions.DiscountFactor = 0.99;
agentOptions.MiniBatchSize = 250;
agentOptions.ExperienceBufferLength = 1e6;
agentOptions.TargetSmoothFactor = 1e-3;
agentOptions.NoiseOptions.MeanAttractionConstant = 1;
agentOptions.NoiseOptions.Variance = 0.1;
agent = rlDDPGAgent(actor,critic,agentOptions);
maxEpisodes = 10000;
maxSteps = floor(Tf/Ts);
trainOpts = rlTrainingOptions(...
    'MaxEpisodes',maxEpisodes,...
    'MaxStepsPerEpisode',maxSteps,...
    'ScoreAveragingWindowLength',250,...
    'Verbose',false,...
    'Plots','training-progress',...
    'StopTrainingCriteria','AverageReward',...
    'StopTrainingValue',100,...
    'SaveAgentCriteria','EpisodeReward',...
    'SaveAgentValue',150);
opt = rlRepresentationOptions('UseDevice',"gpu");
% trainOpts.UseParallel = true;
% trainOpts.ParallelizationOptions.Mode = 'async';
% trainOpts.ParallelizationOptions.StepsUntilDataIsSent = 32;
% trainOpts.ParallelizationOptions.DataToSendFromWorkers = 'Experiences';
doTraining = true;
if doTraining    
    % Train the agent.
    trainingStats = train(agent,env,trainOpts);
else
    % Load pretrained agent for the example.
%     load('rlWalkingBipedRobotDDPG.mat','agent')
end

simOptions = rlSimulationOptions('MaxSteps',maxSteps);
experience = sim(env,agent,simOptions);
save("initialAgent.mat","agent")

function in = localResetFcn(in)
h = randi([-180,180]);
blk = 'RL_InvPend/Subsystem/Pendulum and Cart System/Integrator2';
in = setBlockParameter(in,blk,'InitialCondition',num2str(h));

end


                                   
                                   