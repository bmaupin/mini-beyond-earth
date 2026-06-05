-- The base game does not have a Reactions table, so create a harmless stub first
-- to avoid SQLite 'no such table: Reactions' errors in the database log.
CREATE TABLE IF NOT EXISTS Reactions (
  Type TEXT
);

-- This prevents the negative reaction dialogue and the hit to respect from AI players
-- when cities are founded. Only applies to Rising Tide as the Reactions table doesn't
-- exist in the base game.
DELETE FROM Reactions
WHERE Type = 'REACTION_OUTPOST_FOUNDED_DISLIKE';
