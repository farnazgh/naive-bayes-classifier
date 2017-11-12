function prob = conditional_prob(Ai,C, i) %p(Ai | C)
i = i+1;
train_data = importdata('trainingData.txt',' ');

numc =0;
numAi =0;
for j=1:size(train_data,1)
   if(train_data(j,1)==C) 
       numc = numc+1;
       if(train_data(j,i)==Ai)
           numAi = numAi+1;
       end
   end
end

prob = numAi / numc;