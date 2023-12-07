/* Deklarasi Fakta */

/* ---------- player(X)  ---------- */
dynamic(player/1).

/* ---------- player_name(X,Y) ---------- */
dynamic(player_name/2).

/* ---------- next_player(X)  ---------- */
dynamic(next_player/2).

/* ---------- min_player(2) ---------- */
min_player(2).

/* ---------- max_player(4) ---------- */
max_player(4).

/* ---------- current_player(X) ---------- */
dynamic(current_player/1).

/* ---------- wilayah(X) ---------- */
dynamic(wilayah/1).
wilayah(na1).
wilayah(na2).
wilayah(na3).
wilayah(na4).
wilayah(na5).
wilayah(e1).
wilayah(e2).
wilayah(e3).
wilayah(e4).
wilayah(e5).
wilayah(a1).
wilayah(a2).
wilayah(a3).
wilayah(a4).
wilayah(a5).
wilayah(a6).
wilayah(a7).
wilayah(sa1).
wilayah(sa2).
wilayah(af1).
wilayah(af2).
wilayah(af3).
wilayah(au1).
wilayah(au2).

/* ---------- benua(X) ---------- */
benua(north_america).
benua(europe).
benua(asia).
benua(south_america).
benua(africa).
benua(australia).

/* ---------- wilayah_benua(X, Y) ---------- */
% North America
wilayah_benua(na1, north_america).
wilayah_benua(na2, north_america).
wilayah_benua(na3, north_america).
wilayah_benua(na4, north_america).
wilayah_benua(na5, north_america).

% Europe
wilayah_benua(e1, europe).
wilayah_benua(e2, europe).
wilayah_benua(e3, europe).
wilayah_benua(e4, europe).
wilayah_benua(e5, europe).

% Asia
wilayah_benua(a1, asia).
wilayah_benua(a2, asia).
wilayah_benua(a3, asia).
wilayah_benua(a4, asia).
wilayah_benua(a5, asia).
wilayah_benua(a6, asia).
wilayah_benua(a7, asia).

% South America
wilayah_benua(sa1, south_america).
wilayah_benua(sa2, south_america).

% Africa
wilayah_benua(af1, africa).
wilayah_benua(af2, africa).
wilayah_benua(af3, africa).

% Australia
wilayah_benua(au1, australia).
wilayah_benua(au2, australia).

/* ---------- total_wilayah_benua(X, Y) ---------- */
total_wilayah_benua(north_america, 5).
total_wilayah_benua(europe, 5).
total_wilayah_benua(asia, 7).
total_wilayah_benua(south_america, 2).
total_wilayah_benua(africa, 3).
total_wilayah_benua(australia, 2).

/* ---------- tetangga(X, Y) ---------- */
% North America
tetangga(na1, na2).
tetangga(na1, na3).
tetangga(na1, a3).
tetangga(na2, na1).
tetangga(na2, na4).
tetangga(na2, na5).
tetangga(na3, na1).
tetangga(na3, na4).
tetangga(na3, a3).
tetangga(na4, na3).
tetangga(na4, na5).
tetangga(na5, na2).
tetangga(na5, e1).

% Europe
tetangga(e1, na5).
tetangga(e1, e2).
tetangga(e1, e3).
tetangga(e2, e1).
tetangga(e2, e4).
tetangga(e2, a1).
tetangga(e3, e1).
tetangga(e3, e4).
tetangga(e4, e2).
tetangga(e4, e3).
tetangga(e4, e5).
tetangga(e5, e4).
tetangga(e5, a4).

% Asia
tetangga(a1, e2).
tetangga(a1, a2).
tetangga(a1, a4).
tetangga(a2, a1).
tetangga(a2, a3).
tetangga(a3, a2).
tetangga(a3, na1).
tetangga(a3, na3).
tetangga(a4, e5).
tetangga(a4, a1).
tetangga(a4, a5).
tetangga(a5, a4).
tetangga(a5, sa1).
tetangga(a6, a2).
tetangga(a6, a4).
tetangga(a6, a5).
tetangga(a6, a7).
tetangga(a7, a6).

% South America
tetangga(sa1, na3).
tetangga(sa1, sa2).
tetangga(sa2, sa1).
tetangga(sa2, af1).
tetangga(sa2, au2).

% Africa
tetangga(af1, sa2).
tetangga(af1, e3).
tetangga(af1, af2).
tetangga(af1, af3).
tetangga(af2, af1).
tetangga(af2, af3).
tetangga(af2, e5).
tetangga(af2, e4).
tetangga(af3, af1).
tetangga(af3, af2).

% Australia
tetangga(au1, a6).
tetangga(au1, au2).
tetangga(au2, au1).
tetangga(au2, sa2).

/* ---------- nama(X) ---------- */
nama(alaska).
nama(ontario).
nama(western_us).
nama(eastern_us).
nama(greenland).
nama(iceland).
nama(scandinavia).
nama(western_europe).
nama(northern_europe).
nama(southern_europe).
nama(urai).
nama(siberia).
nama(yakutsi).
nama(afghanistan).
nama(mongolia).
nama(india).
nama(siam).
nama(venezuela).
nama(peru).
nama(north_africa).
nama(egypt).
nama(congo).
nama(indonesia).
nama(new_guinea).

/* ---------- nama_wilayah(X, Y) ---------- */
nama_wilayah(na1, alaska).
nama_wilayah(na2, ontario).
nama_wilayah(na3, western_us).
nama_wilayah(na4, eastern_us).
nama_wilayah(na5, greenland).

nama_wilayah(e1, iceland).
nama_wilayah(e2, scandinavia).
nama_wilayah(e3, western_europe).
nama_wilayah(e4, northern_europe).
nama_wilayah(e5, southern_europe).

nama_wilayah(a1, urai).
nama_wilayah(a2, siberia).
nama_wilayah(a3, yakutsi).
nama_wilayah(a4, afghanistan).
nama_wilayah(a5, mongolia).
nama_wilayah(a6, india).
nama_wilayah(a7, siam).

nama_wilayah(sa1, venezuela).
nama_wilayah(sa2, peru).

nama_wilayah(af1, north_africa).
nama_wilayah(af2, egypt).
nama_wilayah(af3, congo).

nama_wilayah(au1, indonesia).
nama_wilayah(au2, new_guinea).

/* ---------- wilayah_milik(X, Y) ---------- */
dynamic(wilayah_milik/2).

/* ---------- jumlah_tentara_wilayah(X, Y) ---------- */
dynamic(jumlah_tentara_wilayah/2).

jumlah_tentara_awal(na1, 0).
jumlah_tentara_awal(na2, 0).
jumlah_tentara_awal(na3, 0).
jumlah_tentara_awal(na4, 0).
jumlah_tentara_awal(na5, 0).
jumlah_tentara_awal(e1, 0).
jumlah_tentara_awal(e2, 0).
jumlah_tentara_awal(e3, 0).
jumlah_tentara_awal(e4, 0).
jumlah_tentara_awal(e5, 0).
jumlah_tentara_awal(a1, 0).
jumlah_tentara_awal(a2, 0).
jumlah_tentara_awal(a3, 0).
jumlah_tentara_awal(a4, 0).
jumlah_tentara_awal(a5, 0).
jumlah_tentara_awal(a6, 0).
jumlah_tentara_awal(a7, 0).
jumlah_tentara_awal(sa1, 0).
jumlah_tentara_awal(sa2, 0).
jumlah_tentara_awal(af1, 0).
jumlah_tentara_awal(af2, 0).
jumlah_tentara_awal(af3, 0).
jumlah_tentara_awal(au1, 0).
jumlah_tentara_awal(au2, 0).

/* ---------- jumlah_tentara_nganggur(X, Y) ---------- */
dynamic(jumlah_tentara_nganggur/2).

/* ---------- bonus_benua(X, Y) ---------- */
bonus_benua(north_america, 3).
bonus_benua(europe, 3).
bonus_benua(asia, 5).
bonus_benua(south_america, 2).
bonus_benua(africa, 2).
bonus_benua(australia, 1).

/* ---------- action(X) ---------- */
action(endTurn).
action(draft).
action(move).
action(attack).
action(risk).

/* ---------- action_limit(X,Y) ---------- */
action_limit(move, 3).
action_limit(attack, 1).
action_limit(risk, 1).

/* ---------- jumlah_tentara_serang(X, Y) ---------- */
dynamic(jumlah_tentara_serang/2).

/* ---------- risk_card(X) ---------- */
risk_card(ceasifire_order).
risk_card(super_soldier_gun).
risk_card(auxiliary_troops).
risk_card(rebellion).
risk_card(disease_outbreak).
risk_card(supply_chain_issue).
dynamic(status/2).
