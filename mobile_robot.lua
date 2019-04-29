function joy_callback(msg)
    print(msg)
    if msg.axes[3] == -1 then
        horizontalVel = horizontalVel - 1;
        print("New Horizontal Velocity:",horizontalVel)
    elseif msg.axes[6] == -1 then 
        horizontalVel = horizontalVel + 1;
        print("New Horizontal Velocity:",horizontalVel)
    elseif msg.axes[2] == 1 then 
        verticalVel = verticalVel + 1;
        print("New Vertical Velocity:",verticalVel)
    elseif msg.axes[2] == -1 then 
        verticalVel = verticalVel - 1;
        print("New Vertical Velocity:",verticalVel)
    elseif msg.buttons[5] == 1 then 
        rotVel = rotVel - 1;
        print("New Rotational Velocity:",rotVel)
    elseif msg.buttons[6] == 1 then 
        rotVel = rotVel + 1;
        print("New Rotational Velocity:",rotVel)
    elseif msg.buttons[2] == 1 then 
        rotVel = 0
        verticalVel = 0
        horizontalVel = 0
        print("New Rotational Velocity:",rotVel)
    end
    
    --Robot Arm Commands
    armVel_z = msg.axes[1] * 5
    print("Z:",armVel_z)
    sim.setJointTargetVelocity(joint_rotation,armVel_z)
    
    armVel_j2 = msg.axes[5] * 5
    print("J2:",armVel_j2)
    sim.setJointTargetVelocity(joint2,armVel_j2)
    
    armVel_j3 = msg.axes[4] * 5
    print("J3:",armVel_j3)
    sim.setJointTargetVelocity(joint3,armVel_j3)
end

function sysCall_init()
    -- Initialize wheels
    wheelJoints={-1,-1,-1,-1} -- front left, rear left, rear right, front right
    wheelJoints[1]=sim.getObjectHandle('OmniWheel45_typeA')
    wheelJoints[2]=sim.getObjectHandle('OmniWheel45_B')
    wheelJoints[3]=sim.getObjectHandle('OmniWheel45_typeA#0')
    wheelJoints[4]=sim.getObjectHandle('OmniWheel45_typeB#0')
    
    --Initialize joints
    joint_rotation = sim.getObjectHandle('j1z')
    joint2 = sim.getObjectHandle('j1x')
    joint3 = sim.getObjectHandle('j2')


    --Initialize variables
    verticalVel = 0
    horizontalVel = 0
    rotVel = 0
    forwBackVelRange={-240*math.pi/180,240*math.pi/180}  -- min and max wheel rotation vel. for backward/forward movement
    leftRightVelRange={-240*math.pi/180,240*math.pi/180} -- min and max wheel rotation vel. for left/right movement
    rotVelRange={-240*math.pi/180,240*math.pi/180}       -- min and max wheel rotation vel. for left/right rotation movement
    armVel_z = 0
    
--Initialize ROS subscriber
    subscriber = simROS.subscribe("/joy","sensor_msgs/Joy","joy_callback")
end

function sysCall_actuation()
    sim.setJointTargetVelocity(wheelJoints[1],-verticalVel-horizontalVel-rotVel)
    sim.setJointTargetVelocity(wheelJoints[2],-verticalVel+horizontalVel-rotVel)
    sim.setJointTargetVelocity(wheelJoints[3],-verticalVel-horizontalVel+rotVel)
    sim.setJointTargetVelocity(wheelJoints[4],-verticalVel+horizontalVel+rotVel)
    --print(sim.getJointTargetVelocity(wheelJoints[1]))
    --print(sim.getJointTargetVelocity(wheelJoints[2]))
    --print(sim.getJointTargetVelocity(wheelJoints[3]))
    --print(sim.getJointTargetVelocity(wheelJoints[4]))
end

function sysCall_sensing()
end

function sysCall_cleanup()
end
