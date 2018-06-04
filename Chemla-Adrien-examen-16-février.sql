USE workshop;

#récupération de l'age et du nom des acteurs 19 LIGNES
SELECT SUM(year(NOW())-YEAR(date_naissance)) AS age, nom FROM acteur GROUP BY nom;

#récupération du nom des acteurs et du nombre de série dans lesquels ils ont joués 19 LIGNES
SELECT COUNT(titre) AS nb_series, nom FROM acteur LEFT JOIN serie ON acteur.id = serie.id GROUP BY nom;
#(faux)

#récupération du nom et de la nationalité des acteurs 16 LIGNES
SELECT nom, nationalite FROM acteur  NATURAL JOIN nationalite ORDER BY nom;

#récupération des nationalités qui ne sont pas attribuées 0 LIGNES
SELECT nationalite FROM nationalite NATURAL JOIN acteur WHERE nationalite = NULL;

#récupération du nombre de série toujours en cours



#Récupération du titre des séries contenant la lettre 'm' et la longueur des synopsis en triant par ordre décroissant 7 LIGNES
SELECT titre, LENGTH(synopsis) AS len_synopsis FROM serie WHERE titre LIKE '%m%';

#récupération des nombres  1 LIGNES 
SELECT
(SELECT COUNT(nationalite) FROM nationalite) AS nb_nationalite,
(SELECT COUNT(nom) FROM acteur) AS nb_acteur,
(SELECT COUNT(nom) FROM chaine_tv) AS nb_chaine,
(SELECT COUNT(genre) FROM genre_cinema) AS nb_genre,
(SELECT SUM(nb_episode) FROM serie) as nb_episode;

#Récupération du nom des acteurs jouant dans au moins 2 séries toujours en production


#récupération du titre des séries produite entre 2006 et 2014 11 LIGNES
SELECT titre,date_debut_diff FROM serie WHERE date_debut_diff BETWEEN '2006-01-01' AND '2014-12-31' ORDER BY date_debut_diff;

#20 3 LIGNES
SELECT id,nom FROM acteur WHERE id = '5' OR id = '15' OR id = '6' OR id = '27';

#21 4 LIGNES
SELECT id,genre FROM genre_cinema WHERE id BETWEEN '5' AND '9' LIMIT 4;

#22 16 LIGNES
SELECT titre, genre FROM serie NATURAL JOIN genre_cinema;
