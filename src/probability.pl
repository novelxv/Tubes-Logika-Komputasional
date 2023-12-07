exponent(A, 0, 1).                /* BASIS */
exponent(A, 1, A).

exponent(A, B, X) :-              /* REKURENS */
	B1 is (B//2),
	exponent(A, B1, X1),
	exponent(A, B mod 2, X2),
	X is (X1 * X1 * X2).

fac(0, 1).

fac(X, Y) :-
	X1 is X-1,
	fac(X1, Y1),
	Y is (Y1 * X).

c(X, Y, H) :-
	X > Y,
	fac(X, A),
	fac(Y, B),
	fac(X-Y, C),
	H is (A//(B*C)).

sig(

wp(Wilayah, JumlahTentara) :-
	jumlah_tentara_wilayah(Wilayah, X),
	wilayah_milik(P, Wilayah),
	status(P, 2),
	Cutoff is X*6,
	find_prob(JumlahTentara, Cutoff), !.

wp(Wilayah, JumlahTentara) :-
	jumlah_tentara_wilayah(Wilayah, X),
	wilayah_milik(P, Wilayah),
	status(P, 5),
	Cutoff is X,
	find_prob(JumlahTentara, Cutoff), !.

wp(Wilayah, JumlahTentara) :-
	jumlah_tentara_wilayah(Wilayah, X),
	Cutoff is ((7*X)//2),
	find_prob(JumlahTentara, Cutoff), !.
