function [layers , options] = NetGenerator(dim,S,show,batch_size,Max_epoch,feat_test)
switch dim 
    case 'the winner' 

 layers = [
            image3dInputLayer([S(1),S(2),S(3)])
            batchNormalizationLayer
%              dropoutLayer ;

            convolution3dLayer([2,2,20],12,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            averagePooling3dLayer([1,1,2],'Stride',2)

%              dropoutLayer

            convolution3dLayer([2,2,10],24,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            averagePooling3dLayer([2,2,1],'Stride',2)

%              dropoutLayer

            convolution3dLayer([2,2,5],48,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            averagePooling3dLayer([1,1,2],'Stride',2)
%             dropoutLayer
            convolution3dLayer([2,2,3],96,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
         

            fullyConnectedLayer(10)
            softmaxLayer

            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer
            ];
    %% main
    case 'CNN2D'
        
 layers = [
            imageInputLayer([S(1),S(2),1])
            batchNormalizationLayer
            convolution2dLayer([2,2],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%           maxPooling2dLayer([2,2],'Stride',2)

            convolution2dLayer([2,2],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%           maxPooling2dLayer([3,3],'Stride',2)

%             convolution2dLayer([3,3],9,'Padding','same')
%             batchNormalizationLayer
%             leakyReluLayer(0.3)
%             maxPooling2dLayer([3,3],'Stride',2)


%                 fullyConnectedLayer(20)
%                     softmaxLayer

            fullyConnectedLayer(10)
            softmaxLayer

            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer];
%% main

        case '3D for real' 

 layers = [

            image3dInputLayer([S(1),S(2),S(3)])
            batchNormalizationLayer
            convolution3dLayer([2,2,10],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)

            convolution3dLayer([2,2,10],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)

            fullyConnectedLayer(10)
            softmaxLayer

            fullyConnectedLayer(2)
            softmaxLayer

            classificationLayer
            ];
 case '3D for real +' 

 layers = [
            image3dInputLayer([S(1),S(2),S(3)])
            
%         dropoutLayer ;
% batchNormalizationLayer
            convolution3dLayer([2,2,S(3)],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%             maxPooling3dLayer([1,1,2],'Stride',2)

%             dropoutLayer

            convolution3dLayer([2,2,S(3)],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%             maxPooling3dLayer([1,1,2],'Stride',1)

%             dropoutLayer
% 
%             convolution3dLayer(5,24,'Padding','same')
%             batchNormalizationLayer
%             leakyReluLayer(0.3)
%             maxPooling3dLayer([5,5,1],'Stride',2)
% 
%             convolution3dLayer(5,48,'Padding','same')
%             batchNormalizationLayer
%             leakyReluLayer(0.3)
%                 fullyConnectedLayer(20)
%                     softmaxLayer
% fullyConnectedLayer(10)
%             softmaxLayer

            fullyConnectedLayer(10)
            softmaxLayer

            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer
            ];
    case '3D for real + err' 

 layers = [
            image3dInputLayer([S(1),S(2),S(3)])
            
%         dropoutLayer ;
            batchNormalizationLayer
            convolution3dLayer([2,2,S(3)],10,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling3dLayer([1,1,2],'Stride',2)

%             dropoutLayer

            convolution3dLayer([2,2,10],20,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling3dLayer([1,1,2],'Stride',2)

%             dropoutLayer
% 
             convolution3dLayer([2,2,2],40,'Padding','same')
             batchNormalizationLayer
             leakyReluLayer(0.3)
             maxPooling3dLayer([1,1,2],'Stride',2)
% 
            convolution3dLayer([2,2,2],80,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%                 fullyConnectedLayer(20)
%                     softmaxLayer
% 

            fullyConnectedLayer(10)
            softmaxLayer

            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer
            ];
   %% main
      case '3D for dynamic'
 
        layers = [
            image3dInputLayer([S(1),S(2),S(3)])
            
%             dropoutLayer ;
batchNormalizationLayer
            convolution3dLayer([2,2,2],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%             maxPooling3dLayer([2,2,1],'Stride',1)
            convolution3dLayer([2,2,2],1,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
%             maxPooling3dLayer([2,2,1],'Stride',2)
%             convolution3dLayer([3,3,1],6,'Padding',[2,2,0])
%              batchNormalizationLayer
%              leakyReluLayer(0.3)
%            maxPooling3dLayer([2,2,1],'Stride',2)
%             convolution3dLayer([3,3,1],9,'Padding',[2,2,0])
%             batchNormalizationLayer
%             leakyReluLayer(0.3)
%            maxPooling3dLayer([2,2,1],'Stride',2)
% 
%            fullyConnectedLayer(10)
%             softmaxLayer
            fullyConnectedLayer(10)
            softmaxLayer
            fullyConnectedLayer(2)
            softmaxLayer
            classificationLayer
            ];
        

       
    case '3dv1'

 layers = [
            image3dInputLayer([S(1),S(2),S(3)])
            batchNormalizationLayer
            dropoutLayer ;

            convolution3dLayer(5,3,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling3dLayer([3,3,3],'Stride',2)

%             dropoutLayer

            convolution3dLayer(5,6,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling3dLayer([3,3,1],'Stride',2)

%             dropoutLayer

            convolution3dLayer(5,9,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling3dLayer([3,3,1],'Stride',2)

            convolution3dLayer(5,12,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            
            %     fullyConnectedLayer(20)
            %         softmaxLayer


%             fullyConnectedLayer(10)
%             softmaxLayer
            dropoutLayer
            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer
            ];
   
    case '2d'
        
 layers = [
            imageInputLayer([S(1),S(2),1])
batchNormalizationLayer
            convolution2dLayer(5,6,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling2dLayer(5,'Stride',1)

            convolution2dLayer(5,9,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)


            maxPooling2dLayer(5,'Stride',1)

            convolution2dLayer(5,12,'Padding','same')
            batchNormalizationLayer
            leakyReluLayer(0.3)


%                 fullyConnectedLayer(20)
%                     softmaxLayer

            fullyConnectedLayer(10)
            softmaxLayer

            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer];
        

  

        
   
  case 'test2'

 layers = [
            image3dInputLayer([S(1),S(2),S(3)])
            batchNormalizationLayer
%             dropoutLayer ;

            convolution3dLayer([5,5,3],1)
            batchNormalizationLayer
            leakyReluLayer(0.3)
            maxPooling3dLayer([3,3,1],'Stride',2)
            convolution3dLayer([3,3,1],3)
            batchNormalizationLayer
            leakyReluLayer(0.3)
               maxPooling3dLayer([3,3,1],'Stride',2)
           convolution3dLayer([3,3,1],6)
            batchNormalizationLayer
            leakyReluLayer(0.3)
               maxPooling3dLayer([3,3,1],'Stride',2)
               convolution3dLayer([3,3,1],9)
            batchNormalizationLayer
            leakyReluLayer(0.3)
              
%                maxPooling3dLayer([3,3,1],'Stride',2)
            fullyConnectedLayer(10)

            softmaxLayer
            fullyConnectedLayer(2)

            softmaxLayer
            classificationLayer
            ];
end

 options = trainingOptions('sgdm', ...
            'InitialLearnRate',0.01, ...
            'LearnRateSchedule','piecewise',...
            'LearnRateDropPeriod',10,...
            'LearnRateDropFactor',0.5,...
            'MaxEpochs',Max_epoch, ...
            'Shuffle','every-epoch', ...
            'ValidationData',feat_test, ...
            'ValidationFrequency',30, ...
            'Verbose',false, ...
            'Plots',show,...
            'ExecutionEnvironment','multi-gpu', ...
            'OutputNetwork','best-validation-loss', ...
            'MiniBatchSize',batch_size);
    
end
