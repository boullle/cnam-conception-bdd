INSERT INTO register
(
    idApprenticeNumber,
    idScheduling,
    idOffer,
    isValid,
    type
)
VALUES
-- APPRENTI 1
-- Formation 1 / 2020
-- Offre validé
-- personnel
(1, 1, 1, True, "continuousTraining"),
(1, 2, 1, True, "continuousTraining"),
(1, 3, 1, True, "continuousTraining"),
-- APPRENTI 2
-- Formation 2 / 2021
-- Offre en cours
-- personnel
(2, 10, 2, False, "learning"),
(2, 11, 2, False, "learning"),
(2, 12, 2, False, "learning"),
-- APPRENTI 3
-- Formation 3 / 2021
-- Offre validé
-- Centre financier
(3, 16, 3, True, "other"),
(3, 17, 3, True, "other"),
(3, 18, 3, True, "other"),
-- APPRENTI 4
-- Formation 1 / 2021
-- Offre validé
-- Centre financier
-- Facture non payée
(4, 4, 4, True, "priorLearningAssessment"),
(4, 5, 4, True, "priorLearningAssessment"),
(4, 6, 4, True, "priorLearningAssessment"),
-- APPRENTI 5
-- Formation 1 / 2021
-- Offre validé
(5, 4, 5, True, "learning"),
(5, 5, 5, True, "learning"),
(5, 6, 5, True, "learning");