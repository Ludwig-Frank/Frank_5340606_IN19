function [xZero, abortFlag, iters] = myNewton(varargin)
% description?
for i=1:nargin
   if strcmp(varargin{i},'function')
       func = varargin{i+1};
   elseif strcmp(varargin{i}, 'Derivative')
       dfunc = varargin{i+1};
   elseif strcmp(varargin{i}, 'startvalue')
       x0 = varargin{i+1};
   elseif strcmp(varargin{i}, 'maxIter')
       maxIter = varargin{i+1};
   elseif strcmp(varargin{i}, 'feps')
       feps = varargin{i+1};
   elseif strcmp(varargin{i}, 'xeps')
       xeps = varargin{i+1};
   elseif strcmp(varargin{i}, 'LivePlot')
       LivePlot = varargin{i+1};
   end
end
%% Check for necessary Parameters
if ~exist('func','var')
    error('No valid function');
elseif ~exist('dfunc','var')
    method = questdlg('Which Method of differtentiation is your desire?',...
        'Differentiation type','Forward','Backward','Zentral','Zentral');
end
if ~exist('x0','var')
    x0 = 0 ;
    disp(['Using default startvalue x = ',num2str(x0)]);
end
if ~exist('maxIter','var')
    maxIter =50 ;
    disp(['Using default maximum Iterations: maxIter =  ',num2str(maxIter)]);
end
if ~exist('feps','var')
    feps =1e-6 ;
    disp(['Using default feps: feps =  ',num2str(feps)]);
end
if ~exist('xeps','var')
    xeps =1e-6 ;
    disp(['Using default maximum xeps: xeps =  ',num2str(xeps)]);
end
if ~exist('LivePlot','var')
    LivePlot ='off' ;
    disp(['Using default LivePlot: LivePlot =  ','off']);
end



%% start of algorithm
if strcmp(LivePlot,'on')
    h = figure('Name','Newton Visualisation');
    ax1 = subplot(2,1,1);
    plot(ax1, 0,x0,'bo');
    ylabel('xValue')
    hold on;
    grid on;
    xlim auto;
    ylim auto;
    ax2 = subplot(2,1,2);
    semilogy(ax2,0,func(x0),'rx');
    ylabel('FunctionValue')
    hold on;
    grid on;
    xlim auto;
    ylim auto;
end

xOld = x0;
abortFlag = 'maxIter';
for i=1:maxIter
    f = func(xOld);
    if f<feps
        abortFlag = 'feps';
        break;
    end
    if ~exist('dfunc','var') % dont use extra flag: this is more meaningful
        df = numDiff(func,xOld,method);
    else 
        df= dfunc(xOld);
    end
    if df == 0
        abortFlag = 'df = 0';
        break;
    end
    xNew = xOld-(f/df);
    if abs(xNew-xOld)<xeps
        abortFlag = 'xeps';
        break;
    end
    xOld = xNew; 
    if strcmp(LivePlot,'on')
        plot(ax1,i,xNew,'bo');
        semilogy(ax2,i,func(xNew),'rx');
        pause(0.05)
    end
end
iters = i;
xZero = xNew;
end