int: n; % numero d'equips
int: g; % numero de grups
int: s; % numero d'equips per cada grup
int: w; % numero de setmanes a analitzar

array[1..w,1..n] of var 1..n: distribution;

constraint forall(i in 1..w, j,q in 1..n where j < q)((distribution[i, j] != distribution[i,q]));
constraint forall(w1,w2 in 1..w where w1 < w2)(forall(g1,g2 in 1..n where g1 < g2)(forall(m11,m12,m21,m22 in 1..s where m11 != m12 /\ m21 != m22)(distribution[w1,((m11+g1) mod s)+1] != distribution[w2, ((m12+g2) mod s)+1] /\ distribution[w1, ((m21+g1) mod s)+1] != distribution[w2,((m22 + g2) mod s)+1])));
 
solve satisfy;