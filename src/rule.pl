:- include('fakta.pl').

/* Deklarasi Rules */

/* ---------- MAP ---------- */
jumlah_tentara_wilayah(X, Y) :-
    jumlah_tentara_awal(X, Y).

/* ---------- INITIATING ---------- */


/* ---------- TURN - END TURN ---------- */
total_tentara_tambahan(X, Y) :-
	current_player(X),
	findall(Bonus, (benua_player(X, B), bonus_benua(B, Bonus)), Bonuses),
	sum_list(Bonuses, TotalBonus),
	total_wilayah_player(X, N),
	N1 is N // 2,
	Y is TotalBonus + N1.

endTurn :- 
	current_player(X), 
	write('Player '), write(X), write(' mengakhiri giliran.'), nl,
	nl,
	next_player(X, Y),
	write('Sekarang giliran Player '), write(Y), write(!), nl,
	retract(current_player(X)),
	asserta(current_player(Y)),
	total_tentara_tambahan(Y, S),
	write('Player '), write(Y), write(' mendapatkan '), write(S), write(' tentara tambahan.').


/* ---------- TURN - DRAFT ---------- */
draft(X, Y) :-
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

draft(X, Y) :-
	current_player(P),
	wilayah_milik(Q, X),
	P \= Q,
	write('Player '), write(P), write(' tidak memiliki wilayah '), write(X), !.

draft(X, Y) :-
	current_player(P),
	wilayah_milik(P, X),
	jumlah_tentara_wilayah(X, J),
	jumlah_tentara_nganggur(P, N),
	N < Y,
	write('Pasukan tidak mencukupi.'), nl,
	write('Jumlah Pasukan Tambahan Player '), write(P), write(': '), write(N), nl,
	write('draft dibatalkan.').

/* ---------- TURN - MOVE ---------- */
% 13. move(X1,X2,Y)

/* ---------- TURN - ATTACK ---------- */


/* ---------- TURN - RISK ---------- */
% 16. rand_risk_card(X)
% 17. ceasifireOrder
% 18. superSoldierGun
% 19. auxiliaryTroops
% 20. rebelliion
% 21. diseaseOutbreak
% 22. supplyChainIssue

/* ---------- WILAYAH ---------- */

/* ---------- PLAYER ---------- */
total_tentara_pemain(X, Y) :-
	current_player(X),
	jumlah_tentara_aktif(X, M),
	jumlah_tentara_nganggur(X, N),
	Y is M + N.

jumlah_tentara_aktif(X, Y) :-
	current_player(X),
	findall(Tentara, (wilayah_milik(X, W), jumlah_tentara_wilayah(W, Tentara)), Tentaraa),
	sum_list(Tentaraa, TotalTentara),
	Y is TotalTentara.

# benua_player(X, Y) :-
 
# jumlah_wilayah_benua_player(X, Y, Z) :-

total_wilayah_player(X, Y) :-
	wilayah_milik(X, W),
	S is 1,
	Y is Y + 1,
	total_wilayah_player(X, Sum+S).

# displaybenua(X) :-
	findall()

checkPlayerDetail(X) :-
	write('PLAYER '), write(X), ln,
	ln,
	write('Nama						: '), nama(X), ln,
	write('Benua					: '), displaybenua(X), ln,
	total_wilayah_player(X, Y),
	write('Total Wilayah			: '), write(Y), ln,
	jumlah_tentara_aktif(X, W),
	write('Total Tentara Aktif		: '), write(W), ln,
	total_tentara_tambahan(X, Z),
	write('Total Tentara Tambahan	: '), write(Z), ln.

# checkPlayerTerritories(X) :-

checkIncomingTroops(X) :-
	nama(X, N),
	write('Nama									: '), write(N), ln,
	total_wilayah_player(X, W),
	write('Total wilayah						: '), write(W), ln,
	T is W // 2,
	write('Jumlah tentara tambahan dari wilayah	: '), write(T), ln,
	display_bonus_benua(X),
	total_tentara_tambahan(X, Z),
	write('Total tentara tambahan				: '), write(Z), ln.

menang(X) :-
	total_wilayah_player(X, Y),
	Y == 24,
	nama(X, N),
	write('***************************'), ln,
	write('*'), write(N), write(' telah menguasai dunia*'), ln,
	write('***************************'), ln.


kalah(X) :-
	total_wilayah_player(X, Y),
	Y == 0,
	nama(X, N),
	write('Jumlah wilayah Player '), write(N), write(' 0.'), ln,
	write('Player '), write(N), write(' keluar dari permainan!'), ln.

