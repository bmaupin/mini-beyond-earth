-- This prevents the negative reaction dialogue and the hit to respect from AI players
-- when cities are founded in Rising Tide
DELETE FROM Reactions
WHERE Type = 'REACTION_OUTPOST_FOUNDED_DISLIKE'
  -- Only apply for Rising Tide (the Reactions table doesn't exist in the base game)
  AND EXISTS (SELECT Description FROM Civilizations WHERE Type = 'CIVILIZATION_CHUNGSU');
