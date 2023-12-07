% World Leaders
:- include('fakta.pl').

napoleon_bonaparte(X) :-
    (
        % Kuasai semua wilayah di Amerika Utara
        kuasai_amerika_utara(X)
    ; 
        % Atau menangkan lima wilayah pada lima ronde berturut
        menangkan_lima_wilayah_berturut(X)
    ),

    write('Napoleon Bonaparte was a French military leader and emperor'), nl, 
    write('known for his strategic brilliance and his impact on European history'), nl,
    write('in the late 18th and early 19th centuries.'),nl,

    asserta(status(X, active)).

menguasai_europe(X):-
    wilayah_benua(W, europe),
    not((wilayah(X), not(wilayah_milik(X, W)))).

genghis_khan(X) :-
    (
        % Kuasai seluruh wilayah pada benua Asia.
        menguasai_asia(X)
    ;   
        % Eliminasi satu buah pemain, yakni mengakuisisi wilayah terakhir yang dimiliki pemain lawan.
        eliminasi_pemain(X, TargetPlayer)
    ),

    write('Genghis Khan was the founder and leader of the Mongol Empire,'), nl,
    write('known for his exceptional military prowess and the vast territory he conquered.'), nl,
    
    asserta(status(X, aktif)).
    
menguasai_asia(X) :-
    wilayah_benua(W, asia),
    not((wilayah(X), not(wilayah_milik(X, W)))).
    
eliminasi_pemain(X, TargetPlayer) :-
    pemain(TargetPlayer),
    TargetPlayer \= X,
    wilayah_milik(TargetPlayer, WilayahTerakhir),
    not(wilayah_milik(_, WilayahTerakhir)),
    retract(wilayah_milik(TargetPlayer, WilayahTerakhir)),
    assertz(wilayah_milik(X, WilayahTerakhir)),
    write('Pemain '), write(X), write(' mengeliminasi Pemain '), write(TargetPlayer), nl.


kanye_west(X) :-
    (
        % Kuasai semua wilayah di Amerika Utara
        menguasai_north_america(X)
    ;
        % Menangkan lima wilayah pada lima ronde berturut
        menangkan_lima_wilayah_berturut(X)
    ),

    write('Ye is the last living jedi...'), nl,
    
    asserta(status(X, aktif)).
    
menguasai_north_america(X) :-
    wilayah_benua(W, north_america),
    not((wilayah(X), not(wilayah_milik(X, W)))).
    
menangkan_lima_wilayah_berturut(X) :-
    current_player(X),
    menangkan_wilayah(X, 1),
    menangkan_wilayah(X, 2),
    menangkan_wilayah(X, 3),
    menangkan_wilayah(X, 4),
    menangkan_wilayah(X, 5).
    
menangkan_wilayah(X, Ronde) :-
    current_player(X),
    wilayah(W),
    not(wilayah_milik(_, W)),
    write('Pemain '), write(X), write(' menangkan wilayah pada ronde '), write(Ronde), write(': '), write(W), nl.