:- include('fakta.pl').

% Deklarasi Fakta
dynamic(player_idx/2).
dynamic(total_nilai_dadu/2).
% dynamic(next_player/2).
% dynamic(jumlah_tentara_nganggur/2).
% dynamic(current_player/1).
% dynamic(wilayah_milik/2).
% dynamic(jumlah_tentara_wilayah/2).
dynamic(wilayah_kosong/1).

/* COMMANDS */
startGame :-
    retract_all,
    nl,
    init_player, nl, % inisiasi pemain
    roll_dice_for_all_players, nl, % lempar dadu untuk tiap pemain
    determine_turn_order, nl, % menentukan urutan pemain
    distribusi_tentara_awal, nl, % mendistribusikan tentara awal
    mulai_giliran, % memulai giliran
    init_wilayah_kosong.

/* ------------------------ startGame ------------------------ */
/* MENGINISIALISASI PEMAIN */
init_player :-
    write('Masukkan jumlah pemain: '),
    read(N),
    (N >= 2, N =< 4, !, init_player_names(N, 1);
        write('Mohon masukkan angka antara 2 - 4.'), nl,
        init_player
    ).

init_player_names(0, _).
init_player_names(N, Idx) :-
    N > 0,
    format('Masukkan nama pemain ~w: ', [Idx]),
    read(PlayerName),
    assertz(player_idx(Idx, PlayerName)),
    assertz(player(PlayerName)),
    NextIdx is Idx + 1,
    NextN is N - 1,
    init_player_names(NextN, NextIdx).

% Inisialisasi wilayah kosong
init_wilayah_kosong :-
    assertz(wilayah_kosong(na1)),
    assertz(wilayah_kosong(na2)),
    assertz(wilayah_kosong(na3)),
    assertz(wilayah_kosong(na4)),
    assertz(wilayah_kosong(na5)),
    assertz(wilayah_kosong(e1)),
    assertz(wilayah_kosong(e2)),
    assertz(wilayah_kosong(e3)),
    assertz(wilayah_kosong(e4)),
    assertz(wilayah_kosong(e5)),
    assertz(wilayah_kosong(a1)),
    assertz(wilayah_kosong(a2)),
    assertz(wilayah_kosong(a3)),
    assertz(wilayah_kosong(a4)),
    assertz(wilayah_kosong(a5)),
    assertz(wilayah_kosong(a6)),
    assertz(wilayah_kosong(a7)),
    assertz(wilayah_kosong(sa1)),
    assertz(wilayah_kosong(sa2)),
    assertz(wilayah_kosong(af1)),
    assertz(wilayah_kosong(af2)),
    assertz(wilayah_kosong(af3)),
    assertz(wilayah_kosong(au1)),
    assertz(wilayah_kosong(au2)).

% Retract all
retract_all :-
    retractall(player_idx(_, _)),
    retractall(total_nilai_dadu(_, _)),
    retractall(next_player(_, _)),
    retractall(jumlah_tentara_nganggur(_, _)),
    retractall(current_player(_)),
    retractall(wilayah_milik(_, _)),
    retractall(jumlah_tentara_wilayah(_, _)),
    retractall(wilayah_kosong(_)).

/* MELEMPARKAN DADU UNTUK SETIAP PEMAIN */
rand_dice(X) :-
    random(1, 7, X).

roll_dice(Player) :-
    rand_dice(Dice1),
    rand_dice(Dice2),
    TotalDice is Dice1 + Dice2,
    assertz(total_nilai_dadu(Player, TotalDice)),
    format('~w melempar dadu dan mendapatkan ~w.~n', [Player, TotalDice]).

roll_dice_for_players([]).
roll_dice_for_players([Player|Rest]) :-
    roll_dice(Player),
    roll_dice_for_players(Rest).

roll_dice_for_all_players :-
    findall(Player, player_idx(_, Player), Players),
    roll_dice_for_players(Players),
    reroll.

% Rule untuk mengulang pelemparan jika ada lebih dari satu pemain dengan total nilai dadu terbesar
reroll :- 
    findall(Total, total_nilai_dadu(_, Total), Totals),
    max_list(Totals, MaxTotal),
    findall(Player, total_nilai_dadu(Player, MaxTotal), HighestPlayers),
    length(HighestPlayers, NumHighest),
    (NumHighest > 1, !, write('Terjadi seri. Pelemparan ulang untuk semua pemain.'), nl,
        retractall(total_nilai_dadu(_, _)),
        roll_dice_for_all_players;
        true
    ).

/* MENENTUKAN URUTAN GILIRAN PEMAIN */
rotate_players(List, Index, RotatedList) :-
    length(List, Len),
    Index >= 0,
    Index =< Len,
    split(List, Index, Prefix, [Player|Suffix]),
    append([Player|Suffix], Prefix, RotatedList).
split(List, 0, [], List).
split([H|T], N, [H|Prefix], Suffix) :-
    N > 0,
    N1 is N - 1,
    split(T, N1, Prefix, Suffix).

% Rule untuk mendapatkan pemain dengan total nilai dadu terbesar
get_first_player(FirstPlayer) :- 
    findall(Total-Player, total_nilai_dadu(Player, Total), PlayerTotals),
    keysort(PlayerTotals, SortedPlayerTotals), 
    reverse(SortedPlayerTotals, DescSortedPlayerTotals), 
    [_-FirstPlayer | _] = DescSortedPlayerTotals.
get_first_player_index(FirstPlayerIndex) :-
    get_first_player(FirstPlayer),
    player_idx(FirstPlayerIndex, FirstPlayer).

get_turn_order(PlayerList, TurnOrderList) :-
    get_first_player_index(FirstPlayerIndex),
    FirstPlayerIndex1 is FirstPlayerIndex - 1,
    rotate_players(PlayerList, FirstPlayerIndex1, TurnOrderList).

% Rule untuk menyimpan ke fakta next_player
save_next_player([]).
save_next_player([X|Tail]) :-
    save_next_player_in_list([X|Tail]),
    save_next_player(Tail).
save_next_player_in_list([]).
save_next_player_in_list([_]).
save_next_player_in_list([X, Y|Tail]) :-
    assertz(next_player(X, Y)),
    save_next_player_in_list([Y|Tail]).
first_element([First | _], First).
last_element(List, Last) :-
    reverse(List, [Last | _]).

print_player_list([]).
print_player_list([Player | Rest]) :-
    write(Player),
    (Rest = [] -> write('.') ; write(' - ')),
    print_player_list(Rest).

determine_turn_order :-
    findall(Player, player_idx(_, Player), Players),
    get_turn_order(Players, TurnOrder),
    save_next_player(TurnOrder),
    first_element(TurnOrder, First),
    last_element(TurnOrder, Last),
    assertz(next_player(Last, First)),
    write('Urutan pemain: '),
    print_player_list(TurnOrder), nl, 
    get_first_player(FirstPlayer),
    format('~w dapat mulai terlebih dahulu.~n', [FirstPlayer]).

/* DISTRIBUSI TENTARA AWAL */
% Rule untuk menentukan jumlah tentara awal berdasarkan jumlah pemain
distribusi_tentara(NumPlayers, NumTentara) :-
    (   NumPlayers = 2, NumTentara = 24
    ;   NumPlayers = 3, NumTentara = 16
    ;   NumPlayers = 4, NumTentara = 12
    ), !.

bagi_tentara([], _).
bagi_tentara([Head | Tail], NumTentara) :-
    assertz(jumlah_tentara_nganggur(Head, NumTentara)),
    bagi_tentara(Tail, NumTentara).

distribusi_tentara_awal :-
    findall(Player, player_idx(_, Player), Players),
    length(Players, NumPlayers),
    distribusi_tentara(NumPlayers, NumTentara),
    bagi_tentara(Players, NumTentara),
    format('Setiap pemain mendapatkan ~w tentara.', [NumTentara]).
    

/* MEMULAI GILIRAN */
mulai_giliran :-
    get_first_player(FirstPlayer),
    assertz(current_player(FirstPlayer)),
    format('Giliran ~w untuk memilih wilayahnya.~n', [FirstPlayer]).

/* ------------------------ takeLocation(X) ------------------------ */
% Rule untuk menentukan apakah seluruh wilayah sudah diambil
semua_wilayah_diambil :-
    findall(Wilayah, wilayah(Wilayah), WilayahList),
    forall(member(Wilayah, WilayahList), \+ wilayah_kosong(Wilayah)).

takeLocation(Wilayah) :-
    current_player(Player),
    (   wilayah_kosong(Wilayah) ->
            assertz(wilayah_milik(Player, Wilayah)),
            retract(wilayah_kosong(Wilayah)),
            format('~w mengambil wilayah ~w.~n', [Player, Wilayah]),
            next_player(Player, NextPlayer),
            retract(current_player(_)),
            assertz(current_player(NextPlayer)),
            (   semua_wilayah_diambil ->
                write('Seluruh wilayah telah diambil pemain.'), nl,
                write('Memulai pembagian sisa tentara.'), nl,
                format('Giliran ~w untuk meletakkan tentaranya.~n', [NextPlayer]),
                pembagian_awal_tentara,
                !
            ; 
                format('Giliran ~w untuk memilih wilayahnya.~n', [NextPlayer])
            )
    ;   write('Wilayah sudah dikuasai. Tidak bisa mengambil.'), nl,
        format('Giliran ~w untuk memilih wilayahnya.~n', [Player])
    ).

pembagian_awal_tentara :-
    findall(Wilayah, wilayah(Wilayah), WilayahList),
    findall(Player, player_idx(_, Player), Players),
    (
        member(Player, Players),
        member(Wilayah, WilayahList),
        wilayah_milik(Player, Wilayah),
        assertz(jumlah_tentara_wilayah(Wilayah, 1)),
        retract(jumlah_tentara_nganggur(Player, JumlahNganggur)),
        NewJumlahNganggur is JumlahNganggur - 1,
        assertz(jumlah_tentara_nganggur(Player, NewJumlahNganggur)),
        fail
    ;
        true
    ).
    
/* ------------------------ placeTroops(X, Y) ------------------------ */
rand_jumlah_tentara(X, Y) :-
    jumlah_tentara_nganggur(X, Nganggur),
    Y is random(Nganggur) + 1.

rand_wilayah(_, Y) :-
    current_player(Player),
    findall(Wilayah, (wilayah(Wilayah), not(wilayah_milik(Wilayah, _))), ListWilayah),
    length(ListWilayah, JumlahWilayah),
    random(0, JumlahWilayah, Index),
    nth0(Index, ListWilayah, Y),
    assert(wilayah_milik(Y, Player)),
    retract(jumlah_tentara_nganggur(Player, _)),
    assert(jumlah_tentara_nganggur(Player, 0)).

placeTroops(Wilayah, Jumlah) :-
    current_player(Player),
    wilayah_milik(Player, Wilayah),
    jumlah_tentara_nganggur(Player, Nganggur),
    Jumlah =< Nganggur,
    retract(jumlah_tentara_nganggur(Player, Nganggur)),
    SisaNganggur is Nganggur - Jumlah,
    assertz(jumlah_tentara_nganggur(Player, SisaNganggur)),
    jumlah_tentara_wilayah(Wilayah, JumlahWilayah),
    TotalTentara is JumlahWilayah + Jumlah,
    retract(jumlah_tentara_wilayah(Wilayah, JumlahWilayah)),
    assertz(jumlah_tentara_wilayah(Wilayah, TotalTentara)),
    write(Player), write(' meletakkan '), write(Jumlah), write(' tentara di wilayah '), write(Wilayah), nl,
    write('Terdapat '), write(SisaNganggur), write(' tentara yang tersisa.').

placeTroopss(Wilayah, Jumlah) :-
    current_player(Player),
    wilayah_milik(Player, Wilayah),
    jumlah_tentara_nganggur(Player, Nganggur),
    Jumlah =< Nganggur,
    retract(jumlah_tentara_nganggur(Player, Nganggur)),
    SisaNganggur is Nganggur - Jumlah,
    assertz(jumlah_tentara_nganggur(Player, SisaNganggur)),
    jumlah_tentara_wilayah(Wilayah, JumlahWilayah),
    TotalTentara is JumlahWilayah + Jumlah,
    retract(jumlah_tentara_wilayah(Wilayah, JumlahWilayah)),
    assertz(jumlah_tentara_wilayah(Wilayah, TotalTentara)).

random_partition(_, 0, []).
random_partition(Number, NumParts, [Part|Rest]) :-
    NumParts > 0,
    random(1, Number, Part),
    Remaining is Number - Part,
    NewNumParts is NumParts - 1,
    random_partition(Remaining, NewNumParts, Rest).

placingTentara([], []).
placingTentara([Wilayah|Rest], [Head|Tail]):-
    placeTroopss(Wilayah, Head),
    current_player(Player),
    write(Player), write(' meletakkan '), write(Head), write(' tentara di wilayah '), write(Wilayah), write('.'), nl,
    placingTentara(Rest, Tail).

placeAutomatic :-
    current_player(Player),
    findall(Wilayah, wilayah_milik(Player, Wilayah), ListWilayah),
    length(ListWilayah, JumlahWilayah),
    JumlahWilayah > 0,
    jumlah_tentara_nganggur(Player, Nganggur),
    random_partition(Nganggur, JumlahWilayah, Parts),
    placingTentara(ListWilayah, Parts),
    write('Seluruh tentara '), write(Player), write(' sudah diletakkan.'), nl, nl,
    next_player(Player, Next),
    retract(current_player(Player)),
    assertz(current_player(Next)),
    write('Giliran '), write(Next), write(' untuk meletakkan tentaranya.'), nl.
    