%Writen by A.L. Jacobson in Auto-threshold peak detection in physiological signals
%Uses cluster means to determine threshold for peak detections
%input: x is signal; e is  termination condition
%output: c1 is cluster mean one; c2 is cluster mean 2

function [c1, c2]=twoclass(x,e)
c1=x(1); lastc1 = c1;
c2 = x(2); lastc2 = c2;
while 1
    class1=[];
    class2 =[];
    for i=1:length(x)
        if(abs(c1-x(i)) <abs(c2-x(i)))
            class1= [class1 x(i)];
        else
            class2 = [class2 x(i)];
        end
    end
    c2= mean(class2);
    c1= mean(class1);
    if(abs(lastc2-c2) <e) & (abs(lastc1-c1) < e)
        return;
    end
    lastc2 = c2;
    lastc1 = c1;
end
        
    

    