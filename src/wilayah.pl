:- include('fakta.pl').

checkLocationDetail(X) :-
    nama_wilayah(X, Nama),
    wilayah_milik(Pemilik, X),
    jumlah_tentara_wilayah(X, JumlahTentara),
    tetangga(X, Tetangga),
    
    write('Kode          : '), write(X), nl,
    write('Nama          : '), write(Nama), nl,
    write('Pemilik       : '), write(Pemilik), nl,
    write('Total Tentara : '), write(JumlahTentara), nl,
    write('Tetangga      : '), write(Tetangga), nl.