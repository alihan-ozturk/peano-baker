clc;
clear;

syms t;
n = 3; % n adet yaklaşım

function integral_A = calculateIntegral(A, x, xmin, xmax)
    [rows, cols] = size(A);
    
    integral_A = sym(zeros(rows, cols));
    
    for i = 1:rows
        for j = 1:cols
            integral_A(i, j) = int(A(i, j), x, xmin, xmax);
        end
    end
end

function new_A = substituteVariable(A, oldVar, newVar)
    [rows, cols] = size(A);
    
    new_A = sym(zeros(rows, cols));
    
    for i = 1:rows
        for j = 1:cols
            new_A(i, j) = subs(A(i, j), oldVar, newVar);
        end
    end
end


symList = sym('d', [1 n]); 

A = [0 t; 0 0]; % A matrisi

[rows, cols] = size(A);

result = eye(rows);
for i = 1:n
    temp = calculateIntegral(substituteVariable(A, t, symList(i)), symList(i), 0, t);
    for j = 1:i-1
        temp = substituteVariable(temp, t, symList(i-j));
        temp = calculateIntegral(substituteVariable(A, t, symList(i-j)) * temp, symList(i-j), 0, t);
    end
    result = result + temp;
end

disp(result)

for i = 1:rows
    for j = 1:cols
        f = result(i, j);
        fplot(f, [0, n]);
        hold on;
    end
end

xlabel('x');
ylabel('f(x)');
