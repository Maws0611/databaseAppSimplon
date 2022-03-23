-- Simplon veut réaliser une base de données pour gérer les apprenants pour l’insertion pro. Ce système doit permettre 
-- d'enregistrer les apprenants et les compétences du référentiel métier

-- 2) Créer une base de données en ligne de commande avec le langage SQL 
CREATE DATABASE simplonApp;

-- Création de tables
CREATE TABLE apprenants (

    id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
    
    nom VARCHAR(100) NOT NULL,
    
    prenom VARCHAR(100) NOT NULL,

    addresse VARCHAR(100) NOT NULL,
    
    telephone VARCHAR(100) UNIQUE NOT NULL,

    email VARCHAR(100) UNIQUE NOT NULL,

    niveauDetudes VARCHAR(100) NOT NULL,

    attentes VARCHAR(100) NOT NULL

);

-- 3) Insérer au minimum 5 apprenants et les compétences du référentiel DWWM 
INSERT INTO `apprenants` (nom, prenom, addresse, telephone, email, niveauDetudes, attentes)

VALUES 
('GUEYE', 'Rokhaya', 'yoff', '78 970 05 81', 'gueyerokhaya@gmail.com', 'licence 2', 'trouver un job'),
('DIAKHATE', 'Kiné', 'sanar', '76 100 05 92', 'Kinediakhate@gmail.com', 'Master 1', 'trouver un job'),
('SALL', 'Kiné', 'Grd yoff', '70 800 05 92', 'kinesall@gmail.com', 'Master 1', 'trouver un job'),
('GADIAGA', 'Malick', 'HLm', '77 100 05 92', 'malickgadiaga@gmail.com', 'licence 3', 'trouver un job'),
('DIA', 'Modou', 'nguint', '77 101 85 42', 'modoudia@gmail.com', 'licence 3', 'trouver un job'),
('Ndiaye', 'Ouleye', 'Mbao', '77 145 24 12', 'ouleyendiaye@gmail.com', 'licence 3', 'pouvoir developper des interface dynamique'),
('DIOP', 'Khady', 'HLM', '77 230 24 12', 'khadydiop@gmail.com', 'BAC', 'devenir developpeuse'),
('SENE', 'Asta', 'PIKINE', '70 350 24 12', 'astasene@gmail.com', 'Master 1', 'devenir developpeuse'),
('FALL', 'Modou', 'Mermoz', '78 566 24 00', 'modoufall@gmail.com', 'Master 2', 'devenir developpeur'),
('KANE', 'SAMBA', 'Yeumbeul', '76 525 11 20', 'sambakane@gmail.com', 'licence 2', 'devenir developpeur web');

    CREATE TABLE competences (

        id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
        
        libelle VARCHAR(100) NOT NULL,

        id_apprenant INTEGER NOT NULL,
        
        FOREIGN KEY (id_apprenant) REFERENCES apprenants (id)
        
    );

INSERT INTO `competences` (libelle, id_apprenant, id_categorie)

VALUES 
('Maquetter une application', '3',  '1' ),
('Développer des composants accès aux données', '1',  '4' ),
('developpement personnelle', '2', '2' ),
('Créer une base de données', '2',  '4' ),
('Développer une interface utilisateur web dynamique', '2', '2'),
('Réaliser une interface utilisateur avec une solution de gestion de contenu', '2', '2'),
('Réaliser une interface utilisateur web statique et adaptable', '2', '2'),
('Développer la partie back-end d’une application web ou web mobile', '2', '2'),
('Développer une interface utilisateur web dynamique', '2', '2'),
('Élaborer des composants de gestion de contenus', '1', '2' );

        CREATE TABLE statut (

            id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
        
            niveau INTEGER NOT NULL,

            etat VARCHAR(100) NOT NULL,

           id_competence INTEGER NOT NULL,

            FOREIGN KEY (id_competence) REFERENCES  competences (id)
        );

INSERT INTO statut (niveau, etat, id_competence)
VALUES 
('1', 'validé', '1'),
('2', 'non validé', '8'),
('3', 'validé', '4'),
('1', 'non validé', '3'),
('2', 'non validé', '3'),
('3', 'validé', '4'),
('1', 'non validé', '2'),
('2', 'validé', '5'),
('3', 'non validé', '3');

        CREATE TABLE categorie(
            id INTEGER NOT NULL AUTO_INCREMENT PRIMARY KEY,
            nom_categorie VARCHAR(255) NOT NULL 
        );
            
INSERT INTO categorie(nom_categorie)
VALUES 
('Technique'),
('Technique'),
('Technique'),
('Soft'),
('Technique'),
('Soft'),
('Technique'),
('Soft'),
('Technique'),
('Technique');

-- 4.a) retrouver l’ensemble des apprenants 
SELECT* FROM apprenants;

-- 4.b) Afficher la liste des compétences  par catégories 
SELECT libelle, nom_categorie
FROM competences
INNER JOIN categorie ON competences.id = categorie.competences_id
ORDER BY nom_categorie ASC;

-- 4.c) modifier la description de la compétence n°5
UPDATE competences SET libelle ='confiance en soi' WHERE id = '5';

-- 4.d) modifier le numéro de téléphone de l’apprenants N°2
UPDATE apprenants SET telephone ='78 267 46 12' WHERE id = '2';

-- 4.e) afficher l’ensemble des apprenants qui ont validé la compétence N°3
SELECT nom, prenom, etat
FROM apprenants
INNER JOIN competences ON apprenants.id = competences.id_apprenant
INNER JOIN statut ON competences.id = statut.id_competence
WHERE competences.id=3 AND etat='validé';
         
-- 4.f) Affiher le nombre de compétences enregistré dans la base de données

SELECT COUNT(*) FROM competences;

-- 4.g) Afficher la liste des compétences validées de l’apprenants n°4

SELECT libelle
FROM apprenants
INNER JOIN competences ON apprenants.id = competences.id_apprenant
INNER JOIN statut ON competences.id = statut.id_competence
WHERE id_apprenant.id= 4 AND etat='validé';

-- 4.h) Afficher la liste des apprenants et le nombre de compétences validés par apprenant
SELECT  COUNT(libelle)
FROM apprenants
INNER JOIN competences ON apprenants.id = competences.id_apprenant
INNER JOIN statut ON competences.id = statut.id_competence
GROUP BY nom
WHERE etat='validé';

-- 4.i) Supprimer toutes les compétences de niveau 3
DELETE FROM statut WHERE niveau = 3;

-- 4.j) Afficher la listes des apprenants qui ont validé minimum 3 compétences 
SELECT nom, prenom, etat
FROM apprenants
INNER JOIN competences ON apprenants.id = competences.id_apprenant
INNER JOIN statut ON competences.id = statut.id_competence
WHERE competences.id<3 AND etat='validé';