:- include('fakta.pl').
:- include('endturn.pl').

/* ---------- PLAYER ---------- */
total_tentara_pemain(X, Y) :-
	player(X),
	jumlah_tentara_aktif(X, M),
	jumlah_tentara_nganggur(X, N),
	Y is M + N.

jumlah_tentara_aktif(X, Y) :-
	player(X),
	findall(Troop, (wilayah_milik(X, W), jumlah_tentara_wilayah(W, Troop)), Troops),
	sum_oflist(Troops, TotalTentara),
	Y is TotalTentara.

len([], 0).
len([_ | Tail], Len) :-
    len(Tail, LenTail),
    Len is LenTail + 1.

benua_player(X, Benua) :-
    player(X),
    benua(Benua),
    total_wilayah_benua(Benua, N),
    findall(Area, (wilayah_milik(X, Area), wilayah_benua(Area, Benua)), OwnedAreas),
    len(OwnedAreas, NumOwnedAreas),
    (NumOwnedAreas == N -> true ; fail).

jumlah_wilayah_benua_player(X, Y, Z) :-
	player(X),
	findall(Area, (wilayah_milik(X, Area), wilayah_benua(Area, Y)), Areas),
	len(Areas, Z).

total_wilayah_player(X, Y) :-
	player(X),
	findall(Area, (wilayah_milik(X, Area)), Areas),
	len(Areas, Y).

concatenate_list([], _).
concatenate_list([X], _) :- write(X).
concatenate_list([H|T], Separator) :-
    write(H),
    write(Separator),
    concatenate_list(T, Separator).

checkPlayerDetail(X) :-
	player_idx(ID, X),
	player(X),
	write('PLAYER '), write(ID), nl,
	nl,
	write('Nama                     : '), write(X), nl,
	findall(Continent, (benua_player(X, Continent)), Continents),
	write('Benua                    : '), concatenate_list(Continents, ', '), nl,
	total_wilayah_player(X, Y),
	write('Total Wilayah            : '), write(Y), nl,
	jumlah_tentara_aktif(X, W),
	write('Total Tentara Aktif      : '), write(W), nl,
	total_tentara_tambahan(X, Z),
	write('Total Tentara Tambahan   : '), write(Z), nl, !.

list_benua_milik(Player, ListBenua) :-
    setof(Benua, Wilayah^(wilayah_milik(Player, Wilayah), wilayah_benua(Wilayah, Benua)), ListBenua).

display_territories(_, []).
display_territories(X, [T|Rest]) :-
    write(T), nl,
    nama_wilayah(T, Negara),
    write('Nama                : '), write(Negara), nl,
    jumlah_tentara_wilayah(T, N),
    write('Jumlah tentara      : '), write(N), nl, nl,
    display_territories(X, Rest).

display_wilayah_each_benua(X, []).
display_wilayah_each_benua(X, [Benua|Tail]) :-
    jumlah_wilayah_benua_player(X, Benua, Z),
    total_wilayah_benua(Benua, N),
    format('Benua ~w (~w/~w)~n', [Benua, Z, N]),
    findall(T, (wilayah_benua(T, Benua), wilayah_milik(X, T)), Territories),
    display_territories(X, Territories),
    display_wilayah_each_benua(X, Tail).

checkPlayerTerritories(X) :-
    write('Nama                       : '), write(X), nl,
    list_benua_milik(X, Continents),
    display_wilayah_each_benua(X, Continents),
    write(Continents).

display_bonus_benua(_, []). 
display_bonus_benua(X, [Benua|Rest]) :-
    write('Bonus benua '), write(Benua), write('            : '),
    bonus_benua(Benua, N), write(N), nl,
    display_bonus_benua(X, Rest).

checkIncomingTroops(X) :-
	write('Nama                                 : '), write(X), nl,
	total_wilayah_player(X, W),
	write('Total wilayah                        : '), write(W), nl,
	T is W // 2,
	write('Jumlah tentara tambahan dari wilayah : '), write(T), nl,
	player(X),
	findall(B, (benua_player(X, B)), Benua),
    display_bonus_benua(X, Benua),
    total_tentara_tambahan(X, Z),
	write('Total tentara tambahan               : '), write(Z), nl.

menang(X) :-
	total_wilayah_player(X, Y),
	Y == 24,
	player_name(X, N),
	write('***************************'), nl,
	write('*'), write(N), write(' telah menguasai dunia*'), nl,
	write('***************************'), nl.

kalah(X) :-
	total_wilayah_player(X, Y),
	Y == 0,
	player_name(X, N),
	write('Jumlah wilayah Player '), write(N), write(' 0.'), nl,
	write('Player '), write(N), write(' keluar dari permainan!'), nl.