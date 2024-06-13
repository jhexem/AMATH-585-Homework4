x = (pi / 6) * ones(1, 16);
fx = sin(x);

h = 10 * ones(1, 16);
powers = -(1:16);

h = h.^powers;

xmh = x - h;
xph = x + h;

fxmh = sin(xmh);
fxph = sin(xph);

approxf2x = (fxph - 2 * fx + fxmh) ./ (h.^2);
truef2x = -sin(x);

error = abs(truef2x - approxf2x);

T = table(h.', approxf2x.', error.', 'VariableNames', {'h', 'finite difference', 'error'})