
train_data = importdata('trainingData.txt',' ');

classes = train_data(:, 1);
features = train_data(:, 2:6);

prob_class_one = sum(classes)/size(classes,1);
prob_class_zero = (size(classes,1) -sum(classes))/size(classes,1);

prob_A1 = [0 0; 0 0];
prob_A1(1,1) = conditional_prob(0, 0, 1);%p(A1=0 | 0)
prob_A1(1,2) = conditional_prob(1, 0, 1);%p(A1=1 | 0)
prob_A1(2,1) = conditional_prob(0, 1, 1);%p(A1=0 | 1)
prob_A1(2,2) = conditional_prob(1, 1, 1);%p(A1=1 | 1)

prob_A2 = [0 0; 0 0];
prob_A2(1,1) = conditional_prob(0, 0, 2);
prob_A2(1,2) = conditional_prob(1, 0, 2);
prob_A2(2,1) = conditional_prob(0, 1, 2);
prob_A2(2,2) = conditional_prob(1, 1, 2);

prob_A3 = [0 0; 0 0];
prob_A3(1,1) = conditional_prob(0, 0, 3);
prob_A3(1,2) = conditional_prob(1, 0, 3);
prob_A3(2,1) = conditional_prob(0, 1, 3);
prob_A3(2,2) = conditional_prob(1, 1, 3);

prob_A4 = [0 0; 0 0];
prob_A4(1,1) = conditional_prob(0, 0, 4);
prob_A4(1,2) = conditional_prob(1, 0, 4);
prob_A4(2,1) = conditional_prob(0, 1, 4);
prob_A4(2,2) = conditional_prob(1, 1, 4);

prob_A5 = [0 0; 0 0];
prob_A5(1,1) = conditional_prob(0, 0, 5);
prob_A5(1,2) = conditional_prob(1, 0, 5);
prob_A5(2,1) = conditional_prob(0, 1, 5);
prob_A5(2,2) = conditional_prob(1, 1, 5);

%test

test_data = importdata('testingData.txt',' ');

test_classes = test_data(:, 1);
test_features = test_data(:, 2:6);

num_of_faults=0;

for i=1:size(test_data,1)
    %calculate prob for class equals one
    prob1 = prob_A1(1+1, test_features(i,1)+1);
    prob1 = prob1 * prob_A2(1+1, test_features(i,2)+1);
    prob1 = prob1 * prob_A3(1+1, test_features(i,3)+1);
    prob1 = prob1 * prob_A4(1+1, test_features(i,4)+1);
    prob1 = prob1 * prob_A5(1+1, test_features(i,5)+1);
    final_prob1 = prob1 * prob_class_one ;
    
    %calculate prob for class equals zero
    prob0 = prob_A1(0+1, test_features(i,1)+1);
    prob0 = prob0 * prob_A2(0+1, test_features(i,2)+1);
    prob0 = prob0 * prob_A3(0+1, test_features(i,3)+1);
    prob0 = prob0 * prob_A4(0+1, test_features(i,4)+1);
    prob0 = prob0 * prob_A5(0+1, test_features(i,5)+1);
    final_prob0 = prob0 * prob_class_zero ;
    
    %find the class
    class = 1;
    if(final_prob0 > final_prob1)
        class = 0;
    elseif(final_prob0 < final_prob1)
        class = 1;
    else
        class = 1;
    end
    
    %check the class
    if(class ~= test_classes(i))
        num_of_faults = num_of_faults + 1;
    end
end

error_percentage = (num_of_faults / size(test_data,1))*100


