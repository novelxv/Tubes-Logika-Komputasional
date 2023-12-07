# :- include('fakta.pl').
:- include('map.pl').

% current_player(p1).
% jumlah_tentara_wilayah(na1, 10).
% jumlah_tentara_wilayah(na2, 3).
% jumlah_tentara_wilayah(na3, 1).
% jumlah_tentara_wilayah(na4, 3).
% jumlah_tentara_wilayah(na5, 1).
% jumlah_tentara_wilayah(e1, 2).
% jumlah_tentara_wilayah(e2, 4).
% jumlah_tentara_wilayah(e3, 8).
% jumlah_tentara_wilayah(e4, 4).
% jumlah_tentara_wilayah(e5, 8).
% jumlah_tentara_wilayah(a1, 1).
% jumlah_tentara_wilayah(a2, 1).
% jumlah_tentara_wilayah(a3, 1).
% jumlah_tentara_wilayah(a4, 1).
% jumlah_tentara_wilayah(a5, 1).
% jumlah_tentara_wilayah(a6, 1).
% jumlah_tentara_wilayah(a7, 1).
% jumlah_tentara_wilayah(sa1, 2).
% jumlah_tentara_wilayah(sa2, 2).
% jumlah_tentara_wilayah(af1, 3).
% jumlah_tentara_wilayah(af2, 3).
% jumlah_tentara_wilayah(af3, 3).
% jumlah_tentara_wilayah(au1, 4).
% jumlah_tentara_wilayah(au2, 4).

% wilayah_milik(p1, na1).


% 14. attack
attack :-
    current_player(Player),
    write('Sekarang giliran Player '), write(Player), write(' menyerang.'),
    write('\n/* PETA */'), nl,
    displayMap, 

    write('\nPilihlah daerah yang ingin Anda mulai untuk melakukan penyerangan:'),
    read(StartRegion),
    wilayah_milik(Player, StartRegion),
    jumlah_tentara_wilayah(StartRegion, TentaraDiWilayah), 
    TentaraDiWilayah > 1,
    
    write('\nPlayer '), write(Player), write(' ingin memulai penyerangan dari daerah '), write(StartRegion), nl,
    write('Dalam daerah '), write(StartRegion), write(' Anda memiliki sebanyak '), write(TentaraDiWilayah), write(' tentara.'),
    
    write('\nMasukkan banyak tentara yang akan bertempur:'),
    read(JumlahTentara),
    JumlahTentara > 0, JumlahTentara < TentaraDiWilayah,

    write('\n/* PETA */'),
    displayMap, 

    write('\nPilihlah daerah yang ingin Anda serang:'),
    listAdjacentRegions(StartRegion, ListAdjacentRegions),
    printList(ListAdjacentRegions),

    write('\nPilih:'),
    read(TargetRegion),
    member(TargetRegion, ListAdjacentRegions),

    write('\nPerang telah dimulai.'),
    attackBattle(StartRegion, JumlahTentara, TargetRegion).

attackBattle(StartRegion, JumlahTentara, TargetRegion) :-
    current_player(Attacker),
    wilayah_milik(TargetRegion, Defender),
    jumlah_tentara_wilayah(TargetRegion, TentaraDiTarget),
    
    % Simulasi pelemparan dadu
    simulateDiceRoll(Attacker, JumlahTentara, ListDaduAttacker),
    simulateDiceRoll(Defender, TentaraDiTarget, ListDaduDefender),
    
    write('\nPlayer'), write(Attacker),
    write('Dadu yang dilempar:'), printList(ListDaduAttacker),
    TotalDaduAttacker is sum_list(ListDaduAttacker),
    write('Total:'), write(TotalDaduAttacker),

    write('\nPlayer'), write(Defender),
    write('Dadu yang dilempar:'), printList(ListDaduDefender),
    TotalDaduDefender is sum_list(ListDaduDefender),
    write('Total:'), write(TotalDaduDefender),

    (TotalDaduAttacker > TotalDaduDefender ->
        write('\nPlayer'), write(Attacker), write('menang! Wilayah'), write(TargetRegion),
        write('sekarang dikuasai oleh Player'), write(Attacker),
        write('\nSilahkan tentukan banyaknya tentara yang menetap di wilayah'), write(TargetRegion),
        read(JumlahTentaraPindah),
        JumlahTentaraPindah > 0, JumlahTentaraPindah =< JumlahTentara,
        moveTroops(StartRegion, JumlahTentaraPindah, TargetRegion),
        write('\nTentara di wilayah'), write(StartRegion), write(':'), write(JumlahTentara - JumlahTentaraPindah),
        write('Tentara di wilayah'), write(TargetRegion), write(':'), write(JumlahTentaraPindah);
        
        write('\nPlayer'), write(Defender), write('menang! Sayang sekali penyerangan Anda gagal :('),
        write('\nTentara di wilayah'), write(StartRegion), write(':'), write(JumlahTentara),
        write('Tentara di wilayah'), write(TargetRegion), write(':'), write(TentaraDiTarget)).

simulateDiceRoll(Player, NumDice, Result) :-
    status(Player, 2),
    active_card(Player, 2),
    length(Result, NumDice),
    maplist(make6, Result),
    write('\nPlayer'), write(Player),
    write('Dadu yang dilempar:'), printList(Result), !.

simulateDiceRoll(Player, NumDice, Result) :-
    status(Player, 5),
    active_card(Player, 5),
    length(Result, NumDice),
    maplist(make1, Result),
    write('\nPlayer'), write(Player),
    write('Dadu yang dilempar:'), printList(Result), !.

simulateDiceRoll(Player, NumDice, Result) :-
    length(Result, NumDice),
    maplist(rand_dice, Result),
    write('\nPlayer'), write(Player),
    write('Dadu yang dilempar:'), printList(Result).

printList([]).
printList([H|T]) :-
    write(' '), write(H),
    printList(T).

moveTroops(StartRegion, JumlahTentaraPindah, TargetRegion) :-
    current_player(Player),
    jumlah_tentara_wilayah(StartRegion, TentaraDiStart),
    retract(jumlah_tentara_wilayah(StartRegion, TentaraDiStart)),
    NewTentaraDiStart is TentaraDiStart - JumlahTentaraPindah,
    assert(jumlah_tentara_wilayah(StartRegion, NewTentaraDiStart)),

    jumlah_tentara_wilayah(TargetRegion, TentaraDiTarget),
    retract(jumlah_tentara_wilayah(TargetRegion, TentaraDiTarget)),
    NewTentaraDiTarget is TentaraDiTarget + JumlahTentaraPindah,
    assert(jumlah_tentara_wilayah(TargetRegion, NewTentaraDiTarget)).

make1(X) :-
    X is 1.

make6(X) :-
    X is 6.

listAdjacentRegions(StartRegion, ListAdjacentRegions) :-
    setof(AdjacentRegion, tetangga(StartRegion, AdjacentRegion), ListAdjacentRegions).
    