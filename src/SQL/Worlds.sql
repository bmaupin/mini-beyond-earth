-- Scale down map sizes for faster gameplay
UPDATE Worlds
SET
  GridWidth = CASE
    -- Calculate new size, round to nearest INT, then subtract 1 if odd to make sure it's
    -- even; odd map sizes seem to cause crashes
    -- Use MAX to set minimum map size; smaller sizes might cause crashes
    WHEN ROUND(GridWidth * 0.425) % 2 = 1
      THEN MAX(16, ROUND(GridWidth * 0.425) - 1)
    ELSE MAX(16, ROUND(GridWidth * 0.425))
  END,
  GridHeight = CASE
    WHEN ROUND(GridHeight * 0.425) % 2 = 1
      THEN MAX(8, ROUND(GridHeight * 0.425) - 1)
    ELSE MAX(8, ROUND(GridHeight * 0.425))
  END;
