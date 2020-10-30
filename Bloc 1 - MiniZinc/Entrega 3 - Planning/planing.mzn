include "globals.mzn";

int :m;
int :n;

enum RITMO = {lenta, intermedia, rapida};
set of int: REPERTORIO = 1..m;
set of int: CANCION = 1..n;
array[REPERTORIO] of bool: esfVocal;
array[REPERTORIO] of 1..10: dificultad;
array[REPERTORIO] of RITMO: ritmo;
array[REPERTORIO] of bool: hit;
array[REPERTORIO] of 1..10: disfrute;
array[CANCION] of var REPERTORIO: x;

% No haya 3 canciones consecutivas cuya dificultad sume más de 21.
constraint forall(i in 1..(n-2))((dificultad[x[i]] + dificultad[x[i+1]] + dificultad[x[i+2]])>21);

% Despues de una cancion que requiera gran esfuerzo vocal tiene que haber mínimo dos que no lo requieran.
constraint forall(i in 3..n)(if esfVocal[x[i-2]] then not esfVocal[x[i-1]] /\  not esfVocal[x[i]] endif);

% No se puede pasar de una cancion rápida a una lenta ni de una lenta a una rápida, directamente.
constraint forall(i in 1..(n-1))(if ritmo[x[i]] == lenta \/ ritmo[x[i]] == rapida then ritmo[x[i+1]] == intermedia endif);

% Almenos una de cada 4 canciones consecutivas tiene que ser un grandest hit.
constraint forall(i in 1..(n-3))(hit[x[i]] \/ hit[x[i+1]] \/ hit[x[i+2]] \/ hit[x[i+3]]);

% El concierto tiene que empezar y acabar con un hit.
constraint hit[x[1]] /\ hit[x[n]];

% No se puede tocar la misma cancion dos veces. (El alldifferent no funciona)
constraint forall(w1,w2 in 1..n where w1 < w2)(x[w1] != x[w2]);

% La suma de disfrute de todas las canciones tiene que ser el máximo possible.
solve maximize sum(i in 1..n)(disfrute[x[i]]);


output["Disfrute Total = " ++ show(sum(i in 1..n)(disfrute[x[i]])) ++ "\n" ++ "Canciones = " ++ show(x) ++ "\n"];
