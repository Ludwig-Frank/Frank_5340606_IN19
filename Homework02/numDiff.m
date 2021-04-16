function diff = numDiff(func,x,method)
switch method
    case'Forward'
        h = 1e-8;
        diff = (func(x+h)-func(x))/h; 
    case'Backward'
        h = 1e-8;
        diff = (func(x)-func(x-h))/h;
    case'Zentral'
        h = 1e-10;
        diff = (func(x+h)-func(x-h))/(2*h);
end