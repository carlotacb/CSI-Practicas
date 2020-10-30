int: n; % numero d'equips
int: g; % numero de grups
int: s; % numero d'equips per cada grup
int: w; % numero de setmanes a analitzar

set of int: Eq = 1..n; % conjunt d'equips
set of int: Gr = 1..g; % conjunt de grups
set of int: Si = 1..s; % conjunt de megagrups 
set of int: We = 1..w; % conjunt de setmanes

array[We,Gr] of var set of Eq: distribution;

constraint forall(i in We)(forall(j in Gr)(card(distribution[i,j])=s));
constraint forall(i in We)(forall(j,k in Gr where j!=k)(card(distribution[i,j] intersect distribution[i,k])=0));
constraint forall(i,q in We where q>i)(forall(j,k in Gr where j!=k)(card(distribution[i,j] intersect distribution[q,k])=1));

solve satisfy;

%output [ if j == w then ( show(distribution[i, j]) ++ "\n" ) else ( show(distribution[i, j]) ++ "\t" ) endif | i in Gr, j in We ];