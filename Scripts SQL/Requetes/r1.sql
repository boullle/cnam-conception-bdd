-- Obtenir la liste des modules pour lesquelles s'est inscrit l'apprenti 2 (Martin)
SELECT 
apprentice.name AS nom_apprenti, 
apprentice.surname AS prenom_apprenti, 
scheduling.startingDate AS date_debut, 
scheduling.endDate AS date_fin, 
scheduling.hourNumber AS nombre_heures, 
unit.hourPrice AS prix_heure, 
unit.domain AS domaine, 
unit.content AS contenu 
FROM apprentice 
INNER JOIN register ON apprentice.idApprenticeNumber = register.idApprenticeNumber
INNER JOIN scheduling ON register.idScheduling = scheduling.idScheduling
INNER JOIN unit ON unit.idUnit = scheduling.idUnit
WHERE apprentice.name = 'Martin'