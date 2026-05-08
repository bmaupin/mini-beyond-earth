# Map sizes

#### Get maps that have hard-coded sizes

```
$ find . -iname "*.lua" -exec sh -c "grep -H GetMapInitData -A 10 \"{}\" | grep 'GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {'" \; | sort
./steamassets/assets/dlc/dlc_sp_maps/maps/tiltedaxis.lua-               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {52, 32},
./steamassets/assets/dlc/dlc_sp_maps/maps/vulcan.lua-           [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {28, 20},
./steamassets/assets/dlc/expansion1/maps/ice_age.lua-           [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {44, 18},
./steamassets/assets/dlc/expansion1/maps/inland_sea.lua-                [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {28, 18},
./steamassets/assets/dlc/expansion1/maps/skirmish.lua-          [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {28, 18},
./steamassets/assets/maps/ice_age.lua-          [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {44, 18},
./steamassets/assets/maps/inland_sea.lua-               [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {28, 18},
./steamassets/assets/maps/skirmish.lua-         [GameInfo.Worlds.WORLDSIZE_DUEL.ID] = {28, 18},
```

#### Get DLC map names

```
$ egrep -A 1 TXT_KEY_MAP_.+_NAME steamassets/assets/gameplay/xml/text/en_us/civbegametextinfos_dlc.xml
                <Row Tag="TXT_KEY_MAP_VULCAN_NAME">
                        <Text>82 Eridani e</Text>
--
                <Row Tag="TXT_KEY_MAP_ARIDEAN_NAME">
                        <Text>Rigil Khantoris Bb</Text>
--
                <Row Tag="TXT_KEY_MAP_OCEANIA_NAME">
                        <Text>Tau Ceti d</Text>
--
                <Row Tag="TXT_KEY_MAP_TILTED_AXIS_NAME">
                        <Text>Mu Arae f</Text>
--
                <Row Tag="TXT_KEY_MAP_ARBOREAN_NAME">
                        <Text>Kepler 186f</Text>
--
                <Row Tag="TXT_KEY_MAP_WILDERNESS_NAME">
                        <Text>Eta Vulpeculae b</Text>
```

#### Get base game map names

```
$ egrep -v "_HELP|_TITLE|_FORMAT|_OPTION|_SCRIPT|_SIZE|_TYPE|_FOLDER" steamassets/assets/gameplay/xml/text/en_us/civbegametextinfos_frontendscreens.xml  | grep -A 1 "TXT_KEY_MAP"
    <Row Tag="TXT_KEY_MAP_TERRAN">
      <Text>Terran</Text>
--
    <Row Tag="TXT_KEY_MAP_PROTEAN">
      <Text>Protean</Text>
--
    <Row Tag="TXT_KEY_MAP_ATLANTEAN">
                  <Text>Atlantean</Text>
--
    <Row Tag="TXT_KEY_MAP_TAIGAN">
      <Text>Taigan</Text>
--
    <Row Tag="TXT_KEY_MAP_ARCHIPELAGO">
      <Text>Archipelago</Text>
--
    <Row Tag="TXT_KEY_MAP_TINY_ISLANDS">
      <Text>Tiny Islands</Text>
--
    <Row Tag="TXT_KEY_MAP_SKIRMISH">
      <Text>Skirmish</Text>
--
    <Row Tag="TXT_KEY_MAP_INLAND_SEA">
      <Text>Inland Sea</Text>
--
    <Row Tag="TXT_KEY_MAP_ICE_AGE">
      <Text>Glacial</Text>
--
    <Row Tag="TXT_KEY_MAP_EQUATORIAL">
      <Text>Equatorial</Text>
```

## Map size testing

#### Goal

2-3 cities per player

#### Settings

- Mini Beyond Earth only, no other mods
- Planet Size: Dwarf (4 players)
- Random players
- Difficulty: Vostok
- All victories unchecked
- Game Options: Always Peace, Disable Covert Operations, Disable Health, Disable Tutorial Popups, Don't Stagger Starts, No Marvels, Quick Combat, Quick Movement
- 200 turns auto play
- Rotate through maps that don't have landmass options
  - Archipelago
  - Atlantean
  - Inland Sea
  - Protean
  - Terran
- Goal, 2-3 cities per faction
  - So the map should have ~8 cities with room for ~12
  - But since we're going by real-world results, let's take the actual cities built and adjust so it's 10 (2.5 per player)

#### Results: Rising Tide, 0.3

- 6 cities (1.5 per player), terran
- 6 cities (1.5 per player), atlantean
- 6 cities (1.5 per player), atlantean

#### Results: base game, 0.45

- Archipelago
  - 14, room for 18
- Atlantean
  - 11, room for 13
- Inland Sea
  - 13, room for 17
- Protean
  - 7, room for 10
- Terran
  - 8, room for 10
- average
  - 10.6, room for 13.6
  - ~~so we should reduce size ~88% : 12/13.6\*0.45 = 0.397~~
  - if the goal is 2.5 cities per player : 10/10.6\*0.45 = 0.425

#### Results: Rising Tide, 0.45

- Archipelago
  - 12, room for 18
- Atlantean
  - 12, room for 16
- Inland Sea
  - 14, room for 16
- Protean
  - 12, room for 14
- Terran
  - 16, room for 19
- average
  - 13.2, room for 16.6
  - ~~so we should reduce size ~72% : 12/16.6\*0.45 = 0.325~~
  - if the goal is 2.5 cities per player : 10/13.2\*0.45 = 0.34
