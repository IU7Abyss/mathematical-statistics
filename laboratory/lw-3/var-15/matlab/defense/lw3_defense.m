function lw3_defense()
    degree = input(strcat('input degree of polynom: '));

    t0Array = csvread('t.csv');
    y0Array = csvread('y.csv');
    
    y1Array = OLSWithDegree(y0Array, t0Array, degree);
    
    delta = calculateDelta(y0Array, y1Array);
    fprintf('Delta = %3.2f', delta);
    
    plot(t0Array, y0Array, '.b', t0Array, y1Array, 'r');
    legend({
        'Original sample';
        'Output model';
    });
end

function Y = OLSWithDegree(yArray, tArray, degree)
    psiMatrix = makePsiMatrixDegree(tArray, degree);
    
    thetaArray = (psiMatrix' * psiMatrix) \ (psiMatrix' * yArray'); 
    disp(thetaArray);
    
    lenYArray     = length(yArray);
    lenThetaArray = length(thetaArray);
    Y             = zeros(1, lenYArray);
    for i = 1:lenYArray
        Y(i) = thetaArray(1);
        for j = 2:lenThetaArray
            power = j - 1;
            Y(i)  = Y(i) + thetaArray(j) * tArray(i)^power;
        end
    end
end

function Psi = makePsiMatrixDegree(tArray, degree)
    n    = length(tArray);
    nCol = degree + 1;
    Psi  = zeros(n, nCol);
    for i = 1:n
        Psi(i, 1) = 1;
        for j = 2:nCol
            power = j - 1;
            Psi(i, j) = tArray(i)^power;
        end
    end
end

function X = calculateDelta(yArray, yNewArray)
    n   = length(yArray);
    sum = 0;
    for i = 1:n
        sum = sum + power((yArray(i) - yNewArray(i)), 2);
    end
    X = sqrt(sum);
end