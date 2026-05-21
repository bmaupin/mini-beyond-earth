-- Scale down map sizes for faster gameplay; target is 2-3 cities per civ

-- Base game
UPDATE Worlds
SET
  GridWidth = CASE
    -- Calculate new size, round to nearest INT, then subtract 1 if odd to make sure it's
    -- even; odd map sizes seem to cause crashes
    -- Use MAX to set minimum map size; smaller sizes might cause crashes
    WHEN ROUND(GridWidth * 0.45) % 2 = 1
      THEN MAX(16, ROUND(GridWidth * 0.45) - 1)
    ELSE MAX(16, ROUND(GridWidth * 0.45))
  END,
  GridHeight = CASE
    WHEN ROUND(GridHeight * 0.45) % 2 = 1
      THEN MAX(8, ROUND(GridHeight * 0.45) - 1)
    ELSE MAX(8, ROUND(GridHeight * 0.45))
  END
WHERE NOT EXISTS (SELECT Description FROM Civilizations WHERE Type = 'CIVILIZATION_CHUNGSU');

-- Rising Tide
--
-- Sizes are smaller than the base game to account for being able to build cities on water
UPDATE Worlds
SET
  GridWidth = CASE
    WHEN ROUND(GridWidth * 0.4) % 2 = 1
      THEN MAX(16, ROUND(GridWidth * 0.4) - 1)
    ELSE MAX(16, ROUND(GridWidth * 0.4))
  END,
  GridHeight = CASE
    WHEN ROUND(GridHeight * 0.4) % 2 = 1
      THEN MAX(8, ROUND(GridHeight * 0.4) - 1)
    ELSE MAX(8, ROUND(GridHeight * 0.4))
  END
WHERE EXISTS (SELECT Description FROM Civilizations WHERE Type = 'CIVILIZATION_CHUNGSU');
