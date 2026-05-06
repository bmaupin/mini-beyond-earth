-- Decrease culture and research costs to account for smaller map sizes
UPDATE GameSpeeds SET CulturePercent = CAST(CulturePercent / 2 AS INTEGER);
UPDATE GameSpeeds SET ResearchPercent = CAST(ResearchPercent / 2 AS INTEGER);
