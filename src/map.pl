:- include('fakta.pl').

displayMap :-
    write('#################################################################################################'), nl,
    write('#         North America         #        Europe         #                 Asia                  #'), nl,
	write('#                               #                       #                                       #'), nl,
	write('#       [NA1('),
		jumlah_tentara_wilayah(na1, JNA1), write(JNA1),
		write(')]-[NA2('),
		jumlah_tentara_wilayah(na2, JNA2), write(JNA2),
		write(')]       #                       #                                       #'), nl,
	write('-----------|       |----[NA5('), 
		jumlah_tentara_wilayah(na5, JNA5), write(JNA5), 
		write(')]----[E1('), 
		jumlah_tentara_wilayah(e1, JE1), write(JE1), 
		write(')]-[E2('), 
		jumlah_tentara_wilayah(e2, JE2), write(JE2),
		write(')]----------[A1('), 
		jumlah_tentara_wilayah(a1, JA1), write(JA1),
		write(')] [A2('), 
		jumlah_tentara_wilayah(a2, JA2), write(JA2),
		write(')] [A3('), 
		jumlah_tentara_wilayah(a3, JA3), write(JA3),
		write(')]-----------'), nl,
    write('#       [NA3('), 
		jumlah_tentara_wilayah(na3, J3), write(J3),
		write(')]-[NA4('), 
		jumlah_tentara_wilayah(na4, J4), write(J4),
		write(')]       #       |       |       #        |       |       |              #'), nl,
    write('#          |                    #    [E3('),
		jumlah_tentara_wilayah(e3, JE3), write(JE3),
		write(')]-[E4('), 
		jumlah_tentara_wilayah(e4, JE4), write(JE4),
		write(')]    ####     |       |       |              #'), nl,
    write('###########|#####################       |       |-[E5('), 
		jumlah_tentara_wilayah(e5, JE5), write(JE5),
		write(')]-----[A4('), 
		jumlah_tentara_wilayah(a4, JA4), write(JA4),
		write(')]----+----[A5('), 
		jumlah_tentara_wilayah(a5, JA5), write(JA5),
		write(')]           #'), nl,
    write('#          |                    ########|#######|###########             |                      #'), nl,
    write('#       [SA1('), 
		jumlah_tentara_wilayah(sa1, JSA1),write(JSA1),
		write(')]                #       |       |          #             |                      #'), nl,
	write('#          |                    #       |    [AF2('), 
		jumlah_tentara_wilayah(af2, JAF2), write(JAF2),
		write(')]     #          [A6('),
		jumlah_tentara_wilayah(a6, JA6), write(JA6),
		write(')]---[A7('),
		jumlah_tentara_wilayah(a7, JA7), write(JA7),
		write(')]          #'), nl,
    write('#   |---[SA2('), 
		jumlah_tentara_wilayah(sa2, JSA2), write(JSA2),
		write(')]---------------------[AF1('), 
		jumlah_tentara_wilayah(af1, JAF1), write(JAF1), 
		write(')]---|          #             |                      #'), nl,
    write('#   |                           #               |          ##############|#######################'), nl,
    write('#   |                           #            [AF3('), 
		jumlah_tentara_wilayah(af3, JAF3), write(JAF3),
		write(')]      #             |                      #'), nl,
    write('----|                           #                          #          [AU1('), 
		jumlah_tentara_wilayah(au1, JAU1), write(JAU1),
		write(')]---[AU2('), 
		jumlah_tentara_wilayah(au2, JAU2), write(JAU2),
		write(')]-------'), nl,
    write('#                               #                          #                                    #'), nl,
    write('#       South America           #         Africa           #          Australia                 #'), nl,
    write('#################################################################################################'), nl.


/* Inisiasi Display
#################################################################################################
#         North America         #        Europe         #                 Asia                  #
#                               #                       #                                       #
#       [NA1(0)]-[NA2(0)]       #                       #                                       # 
-----------|       |----[NA5(0)]----[E1(0)]-[E2(0)]----------[A1(0)] [A2(0)] [A3(0)]-----------
#       [NA3(0)]-[NA4(0)]       #       |       |       #        |       |       |              #
#          |                    #    [E3(0)]-[E4(0)]    ####     |       |       |              #
###########|#####################       |       |-[E5(0)]-----[A4(0)]----+----[A5(0)]           #
#          |                    ########|#######|###########             |                      #
#       [SA1(0)]                #       |       |          #             |                      #
#          |                    #       |    [AF2(14)]     #          [A6(1)]---[A7(2)]         #
#   |---[SA2(0)]---------------------[AF1(0)]---|          #             |                      #
#   |                           #               |          ##############|#######################
#   |                           #            [AF3(0)]      #             |                      #
----|                           #                          #          [AU1(0)]---[AU2(0)]-------
#                               #                          #                                    #
#       South America           #         Africa           #          Australia                 #
############################################################################################### */