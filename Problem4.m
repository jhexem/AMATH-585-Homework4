f = @g;
tol = 10e-12

a = 0;
b = 1;

q = 1/2;
h0 = 1;

trueSol = integral(f, 0, 1)

[prevA, fevals] = A(a, b, 1, f);
j = 1;

while (abs(trueSol - prevA(end)) > tol)
    [Ak0, fevals] = A(a, b, (q^j) * h0, f);
    nextA = [Ak0 zeros(1, j)];
    for k = 1:j
        nextA(k+1) = nextA(k) + ((nextA(k) - prevA(k)) / (4^k - 1));
    end
    prevA = nextA;
    j = j + 1;
end

fevals %counts total number of distinct function evaluations
intf = nextA(end)

chebf = chebfun('cos(x^2)', [0, 1]), chebintf = sum(chebf)

function y = g(x)
    y = cos(x.^2);
end

function [approx, fcount] = A(a, b, h, f)
    x = a:h:b;
    fx = f(x);
    fx(1) = fx(1) / 2;
    fx(end) = fx(end) / 2;
    approx = sum(fx) * h;
    fcount = length(fx);
end