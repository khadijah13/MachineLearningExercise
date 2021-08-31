function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.3;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%


values = [0.01, 0.03, 0.1, 0.3, 1, 3, 10, 30];
errorPredictions = []
previousPredictionError = 1000;
for cCount= 1:length(values)
  for sCount = 1:length(values)
    
    sigmaIn = values(sCount);
    CIn = values(cCount);
    model= svmTrain(X, y, CIn, @(x1, x2) gaussianKernel(x1, x2, sigmaIn));
    predictions = svmPredict(model, Xval);
    
    predictionError = mean(double(predictions ~= yval));
    
    if(cCount>1||sCount>1)
       if(predictionError<previousPredictionError)
          C = CIn;
          sigma = sigmaIn;
          previousPredictionError= predictionError;
        end
     else
      previousPredictionError = predictionError;
     end
         
    
  %errorPredictions = [errorPredictions; CIn, sigmaIn, predictionError];
      
    end
end

%[minError, minIndex] = min(errorPredictions(:,3));
%C = errorPredictions(minIndex,1);
%sigma = errorPredictions(minIndex,2);



% =========================================================================

end
