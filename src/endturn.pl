:- include('fakta.pl').

/* ---------- TURN - END TURN ---------- */
sum_of_list([], 0).
sum_of_list([Head | Tail], Sum) :-
	sum_list(Tail, SumTail),
	Sum is Head + SumTail.

total_tentara_tambahan(X, Y) :-
	current_player(X),
	status(X, 6),
	active_card(X, 6),
	Y is 0, !.

total_tentara_tambahan(X, Y) :-
	current_player(X),
	findall(Bonus, (benua_player(X, B), bonus_benua(B, Bonus)), Bonuses),
	sum_of_list(Bonuses, TotalBonus),
	total_wilayah_player(X, N),
	N1 is N // 2,
	status(X, 3),
	active_card(X, 3),
	Y is (TotalBonus + N1)*2, !.

total_tentara_tambahan(X, Y) :-
	current_player(X),
	findall(Bonus, (benua_player(X, B), bonus_benua(B, Bonus)), Bonuses),
	sum_of_list(Bonuses, TotalBonus),
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
	assertz(current_player(Y)),
	retract(status(Y, _)),
	total_tentara_tambahan(Y, S),
	write('Player '), write(Y), write(' mendapatkan '), write(S), write(' tentara tambahan.').
