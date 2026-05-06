-- Scale down map sizes for faster gameplay
UPDATE Worlds
SET
  GridWidth = CASE
    -- Calculate new size, round to nearest INT, then subtract 1 if odd to make sure it's even
    -- Use MAX to set minimum map size; smaller sizes might cause crashes
    WHEN ROUND(GridWidth * 0.3) % 2 = 1
      THEN MAX(16, ROUND(GridWidth * 0.3) - 1)
    ELSE MAX(16, ROUND(GridWidth * 0.3))
  END,
  GridHeight = CASE
    WHEN ROUND(GridHeight * 0.3) % 2 = 1
      THEN MAX(8, ROUND(GridHeight * 0.3) - 1)
    ELSE MAX(8, ROUND(GridHeight * 0.3))
  END;
