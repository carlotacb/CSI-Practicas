int: n; % Numero de reines, files i columnes

array[1..n, 1..n] of var 0..1: board;

constraint forall(i in 1..n)(sum(j in 1..n)(board[i,j])=1);
constraint forall(i in 1..n)(sum(j in 1..n)(board[j,i])=1);
constraint forall(i in 1..n)(sum(j in 1..i)(board[(i-j+1),j])<=1); 
constraint forall(i in 1..n)(sum(j in i..n)(board[(j-i+1),j])<=1);
constraint forall(i in 1..n)(sum(j in i..n)(board[j,(j-i+1)])<=1); 
constraint forall(i in 1..n)(sum(j in 1..i)(board[j,(n-j+1)])<=1);

solve satisfy;



output ["\(board)"];

