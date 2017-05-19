
function [retList parList] = twoTargetScan(control_stim, set_stim)

if control_stim.grabParams ==1
    
    parList{1,1} = 'target1Set'; % (0) velocity + endpoint (1) velocity + direction + duration (2) duration + endpoint
    parList{1,2} = 0;
    parList{2,1} = 'target2Set'; % (0) velocity + endpoint (1) velocity + direction + duration (2) duration + endpoint
    parList{2,2} = 0;
    
    parList{3,1} = 'target1SizeX';
    parList{3,2} = 5;
    parList{4,1} = 'target1SizeY';
    parList{4,2} = 5;
    
    parList{5,1} = 'target2SizeX';
    parList{5,2} = 10;
    parList{6,1} = 'target2SizeY';
    parList{6,2} = 10;
    
    parList{7,1} = 'target1Start';
    parList{7,2} = 1;
    parList{8,1} = 'target2Start';
    parList{8,2} = 1.5;
    
    parList{9,1} = 'target1OrigX';
    parList{9,2} = 10;
    parList{10,1} = 'target1OrigY';
    parList{10,2} = 10;
    
    parList{11,1} = 'target2OrigX';
    parList{11,2} = 10;
    parList{12,1} = 'target2OrigY';
    parList{12,2} = 30;
    
    parList{13,1} = 'target1EndX';
    parList{13,2} = 50;
    parList{14,1} = 'target1EndY';
    parList{14,2} = 10;
    
    parList{15,1} = 'target2EndX';
    parList{15,2} = 50;
    parList{16,1} = 'target2EndY';
    parList{16,2} = 30;
    
    parList{17,1} = 'target1Velocity'; %Pixels per second
    parList{17,2} = 200;
    
    parList{18,1} = 'target2Velocity'; %Pixels per second
    parList{18,2} = 200;
    
    parList{19,1} = 'target1Duration';
    parList{19,2} = 5;
    
    parList{20,1} = 'target2Duration';
    parList{20,2} = 5;
    
    parList{21,1} = 'target1Direction';
    parList{21,2} = 0;
    
    parList{22,1} = 'target2Direction';
    parList{22,2} = 0;
    
    parList{23,1} = 'target1Orient';
    parList{23,2} = 0;
    
    parList{24,1} = 'target2Orient';
    parList{24,2} = 0;
    
    parList{25,1} = 'target1ColR';
    parList{25,2} = 0;
    parList{26,1} = 'target1ColG';
    parList{26,2} = 0;
    parList{27,1} = 'target1ColB';
    parList{27,2} = 0;
    
    parList{28,1} = 'target2ColR';
    parList{28,2} = 0;
    parList{29,1} = 'target2ColG';
    parList{29,2} = 0;
    parList{30,1} = 'target2ColB';
    parList{30,2} = 0;
    
    parList{31,1} = 'backColR';
    parList{31,2} = 255;
    parList{32,1} = 'backColG';
    parList{32,2} = 255;
    parList{33,1} = 'backColB';
    parList{33,2} = 255;
    
    retList.durationType = 1;
    retList.stimCode = 'TTSCAN';
    
elseif control_stim.grabParams == 2
    parList = {control_stim.parameters{:,1}; control_stim.parameters{:,control_stim.parSequenceNum+1}}';
    
    tempDur = 0;
    
    t1Vel = parList{17,2};
    t1Start = parList{7,2};
    t1OrigX = parList{9,2};
    t1OrigY = parList{10,2};
    t1EndX = parList{13,2};
    t1EndY = parList{14,2};
    t1Duration = parList{19,2};
    t1Setvar = parList{1,2};
    
    t2Vel = parList{18,2};
    t2Start = parList{8,2};
    t2OrigX = parList{11,2};
    t2OrigY = parList{12,2};
    t2EndX = parList{15,2};
    t2EndY = parList{16,2};
    t2Duration = parList{20,2};
    t2Setvar = parList{2,2};
    
    
    if t1Setvar == 0
        target1Distance = sqrt((t1EndX-t1OrigX)^2 + (t1EndY-t1OrigY)^2);
        tempDur1  = control_stim.preStim + control_stim.postStim + t1Start+(target1Distance / t1Vel);
    elseif t1Setvar ==1 || t1Setvar == 2
        tempDur1  = control_stim.preStim + control_stim.postStim + t1Start + t1Duration;
    else
        tempDur1  = 0; %maybe add error warning opportunity
    end
    
    if t2Setvar == 0
        target2Distance = sqrt((t2EndX-t2OrigX)^2 + (t2EndY-t2OrigY)^2);
        tempDur2  = control_stim.preStim + control_stim.postStim + t2Start+(target2Distance / t2Vel);
    elseif t2Setvar ==1 || t2Setvar == 2
        tempDur2  = control_stim.preStim + control_stim.postStim + t2Start + t2Duration;
    else
        tempDur2  = 0; %maybe add error warning opportunity
    end
    
    retList.trialDuration = max(tempDur1, tempDur2);
    
elseif control_stim.grabParams == 3
    HideCursor
    retList.callTime = GetSecs;
    % duration = control_stim.trialDuration;
    parList = {control_stim.parameters{:,1}; control_stim.parameters{:,control_stim.parSequenceNum+1}}';
    win = set_stim.winNum; % gets Screen windows number
    ifi=Screen('GetFlipInterval', win);
    
    t1Setvar =parList{1,2};
    t1Start = parList{7,2};
    t1SizeX = parList{3,2};
    t1SizeY = parList{4,2};
    t1ColR = parList{25,2};
    t1ColG = parList{26,2};
    t1ColB = parList{27,2};
    t1Vel = parList{17,2};
    t1Dir =parList{21,2};
    t1Orient = parList{23,2};
    t1OrigX = parList{9,2};
    t1OrigY = parList{10,2};
    t1EndX = parList{13,2};
    t1EndY = parList{14,2};
    t1Duration = parList{19,2};
    
    
    t2Setvar =parList{2,2};
    t2Start = parList{8,2};
    t2SizeX = parList{5,2};
    t2SizeY = parList{6,2};
    t2ColR = parList{28,2};
    t2ColG = parList{29,2};
    t2ColB = parList{30,2};
    t2Vel = parList{18,2};
    t2Dir =parList{22,2};
    t2Orient = parList{24,2};
    t2OrigX = parList{11,2};
    t2OrigY = parList{12,2};
    t2EndX = parList{15,2};
    t2EndY = parList{16,2};
    t2Duration = parList{20,2};
    
    bColR = parList{31,2};
    bColG = parList{32,2};
    bColB = parList{33,2};
    
    priorityLevel=MaxPriority(win);
    Priority(priorityLevel);
    
    Screen('FillRect',win, [bColR bColG bColB]);
    Screen('Flip', win);
  
    if t1Setvar == 0 || t1Setvar == 2 % velocity + endpoint OR duation + endpoint
        
        t1Dir_offset = atan2((t1EndY - t1OrigY),(t1EndX - t1OrigX));
       
        t1Dir = t1Dir_offset;
     
        if t1Setvar == 2 %duration + endpoint
            target1Distance = sqrt((t1EndX-t1OrigX)^2 + (t1EndY-t1OrigY)^2);
            t1Vel = target1Distance / t1Duration;
        end;
    else % velocity + duration + direction
        t1Dir = -(pi/180)*t1Dir;
    end
    
     if t2Setvar == 0 || t2Setvar == 2 % velocity + endpoint OR duation + endpoint
        
        t2Dir_offset = atan2((t2EndY - t2OrigY),(t2EndX - t2OrigX));
        
        t2Dir = t2Dir_offset;
     
        if t2Setvar == 2 %duration + endpoint
            target2Distance = sqrt((t2EndX-t2OrigX)^2 + (t2EndY-t2OrigY)^2);
            t2Vel = target2Distance / t2Duration;
        end;
    else % velocity + duration + direction
        t2Dir = -(pi/180)*t2Dir;
    end
   
    
    x1 = t1OrigX; % initial x position
    y1 = t1OrigY; % initial y position
    
    x2 = t2OrigX; % initial x position
    y2 = t2OrigY; % initial y position
    
    imageMatrix1(1,1,1) = t1ColR;
    imageMatrix1(1,1,2) = t1ColG;
    imageMatrix1(1,1,3) = t1ColB;
    imageMatrix2(1,1,1) = t2ColR;
    imageMatrix2(1,1,2) = t2ColG;
    imageMatrix2(1,1,3) = t2ColB;
    
    T1Index=Screen('MakeTexture', win, imageMatrix1);
    T2Index=Screen('MakeTexture', win, imageMatrix2);
    target1Rect = [0,0,t1SizeX, t1SizeY];
    target1RectXY = CenterRectOnPointd(target1Rect,x1,y1);
    
    target2Rect = [0,0,t2SizeX, t2SizeY];
    target2RectXY = CenterRectOnPointd(target2Rect,x2,y2);
    
    
    Screen('FillRect', win, 255, set_stim.trigRect);
    
    tm1 = Screen('Flip', win);
    
    tm2 = WaitSecs('UntilTime', tm1 + control_stim.preStim - (0.5*ifi));
    cn = 1;
    tc(1) = tm2;
    while (tc(cn) < tm1 + control_stim.trialDuration  - control_stim.postStim)
        if (tc(cn) >= tm2 + t1Start - (0.5*ifi)) &&  (tc(cn) <= tm2 + t1Start + t1Duration - (0.5*ifi))
            Screen('DrawTexture', win, T1Index, [], target1RectXY, t1Orient);
        end
        if (tc(cn) >= tm2 + t2Start - (0.5*ifi)) &&  (tc(cn) <= tm2 + t2Start + t2Duration - (0.5*ifi))
            Screen('DrawTexture', win, T2Index, [], target2RectXY, t2Orient);
        end
        cn = cn+1;
        tc(cn) = Screen('Flip', win);
        
        x1=t1OrigX + (t1Vel * cos(t1Dir)) * (tc(cn)  - (tm1 + control_stim.preStim + t1Start) + ifi); % compute new position
        y1=t1OrigY + (t1Vel * sin(t1Dir)) * (tc(cn)  - (tm1 + control_stim.preStim + t1Start) + ifi);
        
        x2=t2OrigX + (t2Vel * cos(t2Dir)) * (tc(cn)  - (tm1 + control_stim.preStim + t2Start) + ifi); % compute new position
        y2=t2OrigY + (t2Vel * sin(t2Dir)) * (tc(cn)  - (tm1 + control_stim.preStim + t2Start) + ifi);
        
        target1RectXY = CenterRectOnPointd(target1Rect,x1,y1);
        target2RectXY = CenterRectOnPointd(target2Rect,x2,y2);
    
    end
    cn = cn+1;
    Screen('FillRect',win, [bColR bColG bColB])
    t3= Screen('Flip', win);
    WaitSecs('UntilTime', tm1 + control_stim.trialDuration);
    Screen('FillRect', win, 0, set_stim.trigRect);
    Screen('Flip', win);
    ShowCursor
end







