/*requête pour réinitialiser la BDD */
DROP DATABASE IF EXISTS `CodingDojo`;

/*requête pour créer la BDD */
CREATE DATABASE IF NOT EXISTS `CodingDojo`;

/*requête pour sélectionner la BDD */
USE `CodingDojo`;


/* création de tables */
CREATE TABLE IF NOT EXISTS `Users`(
`ID` INT AUTO_INCREMENT PRIMARY KEY,  
`Name` VARCHAR(35) NOT NULL, 
`Surname` VARCHAR(25) NOT NULL, 
`Birthdate` DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS `Games`(
`ID` INT AUTO_INCREMENT PRIMARY KEY,
`Title` VARCHAR(50),
`Category` VARCHAR(50),
`Subcategory`VARCHAR(50),
`Launch_Date` DATE
);

CREATE TABLE IF NOT EXISTS `Played_Games`(
`ID` INT AUTO_INCREMENT PRIMARY KEY,
`ID_User` INT,
`ID_Game` INT,
CONSTRAINT `Played_KEY_ID_User` FOREIGN KEY (ID_User) REFERENCES Users(ID) ON DELETE SET NULL ON UPDATE CASCADE, 
CONSTRAINT `Played_KEY_ID_Game` FOREIGN KEY (ID_Game) REFERENCES Games(ID) ON DELETE SET NULL ON UPDATE CASCADE
);


CREATE TABLE IF NOT EXISTS `Note`(
`ID` INT AUTO_INCREMENT PRIMARY KEY,
`ID_Game` INT,
`ID_User` INT,
`Note` TINYINT,
CONSTRAINT `Note_KEY_ID_Game` FOREIGN KEY (ID_Game) REFERENCES Games(ID) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT `Note_KEY_ID_User` FOREIGN KEY (ID_User) REFERENCES Users(ID) ON DELETE SET NULL ON UPDATE CASCADE
);





CREATE TABLE IF NOT EXISTS Sellers(
`ID` INT AUTO_INCREMENT PRIMARY KEY,
`Name` VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS Price(
`ID` INT AUTO_INCREMENT PRIMARY KEY,
`ID_Game` INT,
`ID_Seller` INT,
`Price` DECIMAL(6,2),
CONSTRAINT `KEY_ID_Game` FOREIGN KEY (ID_Game) REFERENCES Games(ID) ON DELETE SET NULL ON UPDATE CASCADE,
CONSTRAINT `KEY_ID_Seller` FOREIGN KEY (ID_Seller) REFERENCES Sellers(ID) ON DELETE SET NULL ON UPDATE CASCADE
);

# Insertion des valeurs dans les tables
INSERT INTO `Users` (`Name`,`Surname`, `Birthdate`) 
VALUES 
('Jean','Neymar','1990-06-28'),
('René','Kicoule','1988-10-08'),
('Tom','Ate','1996-01-15'),
('Jean','Bondepor','1998-03-19'),
('John','Attan','1995-07-04'),
('Louis','Ladebrouille','1979-02-19'),
('John','Cher','1980-07-04'),
('Jacques','Ouilles','1996-01-15'),
('Gille','haie','1993-09-20'),
('François','Kicoule','1987-12-31'),
('Flo','Tuche','1990-02-10'),
('Jean','lvre','1985-05-11'),
('Eva','Taper','1995-08-30');


INSERT INTO `Games`(`Title`, `Category`, `Subcategory`, `Launch_Date`) 
VALUES 
('Monopoly', 'Society Game', 'Board Game' , '1935-02-06'),
('Super Mario','Video Game','Platformer','1985-09-13'),
('Monster Hunter World', 'Video Game', 'RPG', '2018-01-26'),
('Tarot', 'Card Game', 'Strategy', '1400-01-01'),
('Battleship Drinking Game', 'Alcool Game','Strategy', '2015-06-10'),
('World Of Warcraft', 'Video Game','MMORPG','2004-11-23'),
('Carcassone', 'Society Game','Board Game','2010-02-10'),
('Strip Poker', 'Society Game', 'Strategy', '1821-02-10'),
('Pokemon', 'Video Game', 'RPG', '1999-09-08'),
('Pokemon', 'Society Game', 'Board game', '2007-03-14');

INSERT INTO `Sellers`(`Name`) 
VALUES 
('Amazon'),
('Cdiscount'),
('Cultura'),
('FNAC');

INSERT INTO `Played_Games`(`ID_Game`, `ID_User`) 
VALUES 
('1','1'),
('1','3'),
('2','4'),
('2','2'),
('3','1'),
('3','5'),
('3','10'),
('4','2'),
('4','9'),
('4','7'),
('5','2'),
('5','3'),
('5','5'),
('5','9'),
('6','3'),
('4','2'),
('3','5'),
('7','3');

INSERT INTO `Note`(`ID_Game`, `ID_User`, `Note`) 
VALUES 
('1','1','5'),
('1','3','4'),
('2','4','3'),
('2','2','7'),
('3','1','6'),
('3','5','8'),
('3','10','9'),
('4','2','4'),
('4','9','2'),
('4','7','9'),
('5','2','3'),
('5','3','5'),
('5','5','6'),
('5','9','8'),
('6','3','3'),
('4','2','7'),
('3','5','9'),
('7','3','3');

INSERT INTO `Price`(`ID_Game`, `ID_Seller`, `Price`) 
VALUES 
('1','1','30.50'),
('1','2','32.50'),
('2','3','20.40'),
('2','4','22.30'),
('3','2','35.90'),
('3','4','36.60'),
('4','4','40.50'),
('5','1','25.40'),
('5','3','22.50'),
('8','4','13.18'),
('5','4','41.12'),
('10','1','10.40');

/*#1 Récupérez pour chaque jeu, son titre, son genre et le nombre de client
qui y joue*/
SELECT g.title,g.Category,
COUNT(u.Name) AS Total_Users FROM GAMES AS g 
LEFT JOIN Played_Games AS p ON g.ID = p.ID_Game
LEFT JOIN Users AS u ON u.ID = p.ID_User
GROUP BY g.id ORDER BY Total_Users DESC;

/*#2 Faire la moyenne d’âge de la clientèle*/
SELECT ROUND(AVG(YEAR(NOW())- YEAR(Birthdate))) AS Age_Moyen FROM Users;

/*#3 Récupérez le nombre de jeu sortie entre 1997 et 2004*/
SELECT COUNT(Launch_Date) as Games_Number FROM Games WHERE Launch_Date BETWEEN '1997-01-01' AND '2004-12-31';

/*#4 Utilisez le mot clé ORDER BY dans une requête de votre choix.*/
SELECT g.Title, AVG(p.Price) AS Prix_Moyen 
FROM Games AS g 
INNER JOIN Price AS p ON p.ID_Game = g.ID
GROUP BY g.Title ORDER BY Prix_Moyen;


/*#5 Jointure de Played_Games avec Games et Users dans une requête avec les ID pour voir qui a acheté quoi 
SELECT * FROM Played_Games INNER JOIN Games ON Games.ID = Played_Games.ID_Game
LEFT JOIN Users ON Users.ID = Played_Games.ID_User ORDER BY Title;

/*#6 Utilisez le mot clé WHERE ... LIKE dans une requête de votre choix*/
SELECT Title FROM Games WHERE Title LIKE 'M%';

/*#7 Récupérez la liste des jeux auxquels aucuns clients ne joue*/
SELECT g.title,g.Category,
COUNT(u.Name) AS Total_Users FROM GAMES AS g 
LEFT JOIN Played_Games AS p ON g.ID = p.ID_Game
LEFT JOIN Users AS u ON u.ID = p.ID_User
GROUP BY g.id HAVING Total_Users=0 ORDER BY Total_Users DESC;


/*#8 Incluez un des 5 attributs supplémentaires dans une requête de votre
choix*/
SELECT g.Title, COUNT(n.ID_Game) AS Nombre_De_Notes
FROM Games AS g 
INNER JOIN Note AS n ON n.ID_Game = g.ID
GROUP BY g.Title ORDER BY Nombre_De_Notes

