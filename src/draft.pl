draft(X, Y) :- % Berhasil mengisi
	current_player(P),
	wilayah_milik(P, X),
	jumlah_tentara_wilayah(X, J),
	jumlah_tentara_nganggur(P, N),
	N >= Y,
	J1 is J + Y,
	N1 is N - Y,
	retract(jumlah_tentara_wilayah(X, J)),
	asserta(jumlah_tentara_wilayah(X, J1)),
	retract(jumlah_tentara_nganggur(P, N)),
	asserta(jumlah_tentara_nganggur(P, N1)),
	write('Player '), write(P), write(' meletakkan '), write(Y), write(' tentara tambahan di '), write(X), nl, !.

draft(X, Y) :- % Wilayah bukan milk sendiri
	current_player(P),
	wilayah_milik(Q, X),
	P \= Q,
	write('Player '), write(P), write(' tidak memiliki wilayah '), write(X), !.

draft(X, Y) :- % Tentara tambahan tidak cukup
	current_player(P),
	wilayah_milik(P, X),
	jumlah_tentara_wilayah(X, J),
	jumlah_tentara_nganggur(P, N),
	N < Y,
	write('Pasukan tidak mencukupi.'), nl,
	write('Jumlah Pasukan Tambahan Player '), write(P), write(': '), write(N), nl,
	write('draft dibatalkan.').
