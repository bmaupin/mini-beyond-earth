-- This prevents the negative reaction dialogue and the hit to respect from AI players
-- when cities are founded.
DELETE FROM Reactions
WHERE Type = 'REACTION_OUTPOST_FOUNDED_DISLIKE'
-- Only apply for Rising Tide
AND EXISTS (SELECT Description FROM Civilizations WHERE Type = 'CIVILIZATION_CHUNGSU');
