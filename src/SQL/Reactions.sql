-- The AI will still make snarky comments when cities are founded too close to them, but
-- at least we can remove the hit to respect. Removing the comment would involve
-- overriding DefaultReactionHelpers.lua, which we want to avoid.
UPDATE Reactions
SET
  RespectChange = 0
WHERE Type = 'REACTION_OUTPOST_FOUNDED_DISLIKE'
-- Only apply for Rising Tide
AND EXISTS (SELECT Description FROM Civilizations WHERE Type = 'CIVILIZATION_CHUNGSU');