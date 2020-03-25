%% Return the class for a randorm number in the cumul probabilities.

function r = fu_class(pCumulProbability,pRandNum)
    for i = 1:length(pCumulProbability)
        if(i==1)
            if(pRandNum<=pCumulProbability(i))
                r=1;
            end
        elseif(pRandNum>pCumulProbability(i-1) && pRandNum<=pCumulProbability(i))
            r=i;
        end
    end
end