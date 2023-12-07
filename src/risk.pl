getElement([Head | _Tail], Index, Element) :- 
	Index = 1, !, 
	Element is Head.

getElement([_Head | Tail], Index, Element) :- 
	Index > 1,
	NewIndex is Index - 1,
	getElement(Tail, NewIndex, Element).

rand_player(X) :-
	current_player(P),
	player_idx(N, P),
	jumlah_player(J),
	random(1, J+1, N1),
	N1\=N,
	player_idx(N1, X), !.

rand_player(X) :-
	current_player(P),
	player_idx(N, P),
	jumlah_player(J),
	random(1, J+1, N1),
	N1=:=N,
	rand_player(X).

rand_rebel(X) :-
	current_player(P),
	findall(W, wilayah_milik(P, W), L),
	total_wilayah_player(P, J),
	random(1, J+1, Y),
	getElement(L, Y, X).

rand_risk_card(X) :-
	random(1, 7, X).

card(1) :-
	write('CEASIFIRE ORDER.').

card(2) :-
	write('SUPER SOLDIER SERUM.').

card(3) :-
	write('AUXILIARY TROOPS.').

card(4) :-
	write('REBELLION.').

card(5) :-
	write('DISEASE OUTBREAK.').

card(6) :-
	write('SUPPLY CHAIN ISSUE.').

desc_card(1) :-
	write('Hingga giliran berikutnya, wilayah pemain tidak dapat diserang oleh lawan.').

desc_card(2) :-
	write('Hingga giliran berikutnya,'), nl,
	write('semua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 6.').

desc_card(3) :-
	write('Pada giliran berikutnya,'), nl, 
	write('Tentara tambahan yang didapatkan pemain akan bernilai 2 kali lipat.').

desc_card(4) :-
	write('Salah satu wilayah acak pemain akan berpindah kekuasaan menjadi milik lawan.'), nl,
	nl,
	rand_rebel(X),
	rand_player(P),
	retract(wilayah_milik(_, X)),
	asserta(wilayah_milik(P, X)),
	write('Wilayah '), write(X), write('sekarang dikuasai oleh Player '), write(P), write('.').

desc_card(5) :-
	write('Hingga giliran berikutnya,'), nl,
	write('semua hasil lemparan dadu saat penyerangan dan pertahanan akan bernilai 1.').

desc_card(6) :-
	write('Pada giliran berikutnya, pemain tidak mendapatkan tentara tambahan.').

active_card(P, 1) :-
	status(P, 1),
	write('Tidak bisa menyerang!'), nl,
	write('Wilayah ini dalam pengaruh '), card(1).

active_card(P, 2) :-
	status(P, 2),
	write('Tentara '), write(P),  write(' dalam pengaruh '), card(3), write('.'), nl.

active_card(P, 3) :-
	status(P, 3),
	write('Player '), write(P),  write(' mendapatkan '), card(3), write('!'), nl.

active_card(P, 5) :-
	status(P, 5),
	write('Tentara '), write(P),  write(' dalam pengaruh '), card(5), write('.'), nl.

active_card(P, 6) :-
	status(P, 6),
	write('Player '), write(P),  write(' terdampak '), card(6), write('!'), nl.

risk :-
	current_player(P),
	rand_risk_card(X),
	asserta(status(P, X)),
	write('Player '), write(P), write(' mendapatkan risk card '), card(X), nl,
	desc_card(X).
