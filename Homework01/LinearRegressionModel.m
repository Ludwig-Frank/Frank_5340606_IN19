classdef LinearRegressionModel < matlab.mixin.SetGet
    %LINEARREGRESSIONMODEL 
    % Class representing an implementation of linear regression model
    
    properties (Access = public)
        optimizer
        trainingData
        theta
        thetaOptimum
    end
    
    methods (Access = public)
        function obj = LinearRegressionModel(varargin)
            %LINEARREGRESSIONMODEL Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            for k = 1:length(varargin)
                if strcmp(varargin{k},'Data')
                    obj.trainingData = varargin{k+1};
                elseif strcmp(varargin{k},'Optimizer')
                    obj.optimizer = varargin{k+1};
       
                end
            end
        end
        
        function J = costFunction(obj)
            m = obj.trainingData.numOfSamples;
            J = (sum((obj.hypothesis()-obj.trainingData.commandVar).^2)/(2*m));
            % ========= YOUR CODE HERE =========
            % compute the costs
            % therefore use the hypothesis function as well
            % this calculation can be done by one line of code
            % returns the cost value J
            
            
        end
        
        function hValue = hypothesis(obj)
            X = [ones(obj.trainingData.numOfSamples,1) obj.trainingData.feature];
            hValue = X * obj.theta;
            % ========= YOUR CODE HERE =========
            % compute the hypothesis values for each sample
            % therefore compute the matrix multiplication with X
            % this calculation can be done by one line of code
            
        end
        
        function h = showOptimumInContour(obj)
            h = figure('Name','Optimum');
            theta0_vals = linspace(50, 150, 100);
            theta1_vals = linspace(0, 2, 100);
            costMat = ones(100,100);
            for k= 1:100
                for l = 1:100
                    obj.setTheta(theta0_vals(l),theta1_vals(k));
                    costMat(k,l)=obj.costFunction();
                end
            end
            contour(theta0_vals,theta1_vals,costMat);
            hold on;
            plot(obj.thetaOptimum(1),obj.thetaOptimum(2),'rx','lineWidth',2,'MarkerSize',10);
            hold off;
            
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the contour command
            % add x and y label
            % add the optimum theta value to the plot (red X, MarkerSize: 10, LineWidth: 2)
            
        end
        
        function h = showCostFunctionArea(obj)
            h = figure('Name','Cost Function Area');
            theta0_vals = linspace(50, 150, 100); 
            theta1_vals = linspace(0, 2, 100);
            costMat = ones(100,100);
            for k= 1:100 % hard coded limits 
                for l = 1:100
                    obj.setTheta(theta0_vals(l),theta1_vals(k));
                    costMat(k,l)=obj.costFunction();
                end
            end
            surf(theta0_vals,theta1_vals,costMat);
            % ========= YOUR CODE HERE =========
            % compute the costs for each theta_vals tuple
            % plot the costs with the surf command
            % add x and y label
            
            % label??!
        end
        
        function h = showTrainingData(obj)
           h = figure('Name','Linear Regression Model');
           plot(obj.trainingData.feature,obj.trainingData.commandVar,'rx')
           grid on;
           xlabel(obj.trainingData.featureName + " in Kelvin");
           ylabel(obj.trainingData.commandVarName + " in Kelvin");
           legend('Training Data')
        end
        
        function h = showModel(obj)
           h = obj.showTrainingData();
           
           % ========= YOUR CODE HERE =========
           % add the final trained model plot to the figure ('b-')
           % update the legend
           hold on;
           plot(obj.trainingData.feature,obj.theta(1)+obj.theta(2)*obj.trainingData.feature,'b-')
           hold off;
        end
        
        function setTheta(obj,theta0,theta1)
            obj.theta = [theta0;theta1];
        end
        
        function setThetaOptimum(obj,theta0,theta1)
            obj.thetaOptimum = [theta0;theta1];
        end
    end
    
    methods (Access = private)
        
        function initializeTheta(obj)
            obj.setTheta(0,0);
        end
   
    end
end
