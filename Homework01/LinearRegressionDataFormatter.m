classdef LinearRegressionDataFormatter < matlab.mixin.SetGet
    %DATAPRERPERATOR Class to model the training data for lineare
    %regression model object
   
    properties (Access = public)
        feature
        featureName
        commandVar
        commandVarName
        numOfSamples
    end
    
    properties (Access = private)
        data
    end
    
    methods (Access = public)
        function obj = LinearRegressionDataFormatter(varargin)
            %DATAPRERPERATOR Construct an instance of this class
            
            % ========= YOUR CODE HERE =========
            % perform the varargin
            
            for k = 1:length(varargin)
                if strcmp(varargin{k},'Data')
                    obj.data = importdata(varargin{k+1});
                elseif strcmp(varargin{k},'Feature')
                    obj.featureName = varargin{k+1};
                elseif strcmp(varargin{k},'CommandVar')
                    obj.commandVarName = varargin{k+1};
                end
            end
            
            obj.mapFeature();
            obj.mapCommandVar();
            obj.mapNumOfSamples();
        end
    end
    
    methods (Access = private)
        function mapFeature(obj)
            obj.feature = obj.data.(obj.featureName);
        end
        
        function mapCommandVar(obj)
            obj.commandVar = obj.data.(obj.commandVarName);
        end
        
        function mapNumOfSamples(obj)
           obj.numOfSamples = length(obj.feature); 
        end
    end
end