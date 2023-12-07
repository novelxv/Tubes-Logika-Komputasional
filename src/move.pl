:- include('fakta.pl').

:- dynamic(moves_count/1).

moves_count(0).

move(X1, X2, Y) :-
    current_player(Pemain),
    moves_count(N),
    N < 3,
    wilayah_milik(Pemain, X1),
    wilayah_milik(Pemain, X2),
    jumlah_tentara_wilayah(X1, JumlahTentaraX1),
    JumlahTentaraX1 >= Y,
    retract(jumlah_tentara_wilayah(X1, JumlahTentaraX1)),
    NewJumlahX1 is JumlahTentaraX1 - Y,
    assertz(jumlah_tentara_wilayah(X1, NewJumlahX1)),
    retract(jumlah_tentara_wilayah(X2, JumlahTentaraX2)),
    NewJumlahX2 is JumlahTentaraX2 + Y,
    assertz(jumlah_tentara_wilayah(X2, NewJumlahX2)),
    write('Player '), write(Pemain), write(' memindahkan '), write(Y),
    write(' tentara dari Wilayah '), write(X1), write(' ke Wilayah '), write(X2), nl,
    retract(moves_count(N)),
    NewN is N + 1,
    assertz(moves_count(NewN)), !.

move(X1, X2, Y) :-
    current_player(Pemain),
    wilayah_milik(Q, X1),
	wilayah_milik(Q, X2),
    Pemain \= Q,
    write('Player '), write(Pemain), write(' tidak memiliki wilayah '), write(X1), !.

move(X1, X2, Y) :-
    current_player(Pemain),
    wilayah_milik(Pemain, X1),
    wilayah_milik(Pemain, X2),
    jumlah_tentara_wilayah(X1, JumlahTentaraX1),
    JumlahTentaraX1 < Y,
    write('Pasukan tidak mencukupi.'), nl,
    write('Jumlah Pasukan di Wilayah '), write(X1), write(': '), write(JumlahTentaraX1), nl,
    write('Pemain '), write(Pemain), write(' tidak dapat memindahkan '), write(Y),
    write(' tentara dari Wilayah '), write(X1), write(' ke Wilayah '), write(X2), nl.