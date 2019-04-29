# Humanoids Final Project

My final project for the 16-264 Humanoids for Mr. Atkeson's class


## V-REP 
mobile_robot.lua : The Lua script that runs on the simulation model

humanoids_robot.ttt : A scene that contains the model for the robot Mr. Atkeson made

## ROS Package
mobile_arm : The ROS Package (would go in /src) that contains the launch file that launches the game pad node and publishes the gampe pad data to the lua script (simulation model)


## How to Run
Install: V-REP, ROS, ROS /joy

Step 1: Make ROS package 


Step 2: Add mobile_robot to /src


Step 3: Go to workspace folder and catkin_make


Step 4: source <ws_folder>/devel/setup.bash


Step 5: roslaunch mobile_robot base.launch


Step 6: Launch VREP (verify in the launch terminal that it ROSInterface was successful)


Step 7: In V-REP open humanoids_robot.ttt


Step 8: Copy contents of mobile_robot.lua and paste it to the HumanoidsRobot child non-threaded script


Step 9: Run simulation


