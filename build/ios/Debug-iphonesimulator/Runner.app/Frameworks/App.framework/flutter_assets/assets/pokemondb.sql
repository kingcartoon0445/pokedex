-- Pokemon database schema
CREATE TABLE IF NOT EXISTS pokemon (
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Height REAL,
    Weight REAL,
    Image TEXT,
    Hp INTEGER,
    Attack INTEGER,
    Defense INTEGER,
    Special_attack INTEGER,
    Special_defense INTEGER,
    Speed INTEGER,
    Type1 TEXT,
    Type2 TEXT
);
-- Pokemon database schema
CREATE TABLE IF NOT EXISTS moves (
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL,
    Power REAL,
    Pp REAL,
    Type TEXT
);
CREATE TABLE IF NOT EXISTS generation (
    Id INTEGER PRIMARY KEY,
    Name TEXT NOT NULL, 
    Downloaded BOOLEAN
);

 INSERT INTO generation (Id, Name, Downloaded)
 VALUES
        (1,"Kanto",false),
        (2,"Johto",false),
        (3,"Hoenn",false),
        (4,"Sinnoh",false),
        (5,"Unova",false),
        (6,"Kalos",false),
        (7,"Alola",false),
        (8,"Galar",false),
        (9,"Paldea",false);
-- -- Sample data insertion
-- INSERT INTO pokemon (Id, Name, Height, Weight, Image, Hp, Attack, Defense, Special_attack, Special_defense, Speed, Type)
-- VALUES
--     (1, 'Bulbasaur', 0.7, 6.9, 'bulbasaur.png', 45, 49, 49, 65, 65, 45, 'Grass','Poison'),
--     (2, 'Ivysaur', 1.0, 13.0, 'ivysaur.png', 60, 62, 63, 80, 80, 60, 'Grass','Poison'),
--     (3, 'Venusaur', 2.0, 100.0, 'venusaur.png', 80, 82, 83, 100, 100, 80, 'Grass/Poison'),
--     (4, 'Charmander', 0.6, 8.5, 'charmander.png', 39, 52, 43, 60, 50, 65, 'Fire'),
--     (5, 'Charmeleon', 1.1, 19.0, 'charmeleon.png', 58, 64, 58, 80, 65, 80, 'Fire'),
--     (6, 'Charizard', 1.7, 90.5, 'charizard.png', 78, 84, 78, 109, 85, 100, 'Fire/Flying'),
--     (7, 'Squirtle', 0.5, 9.0, 'squirtle.png', 44, 48, 65, 50, 64, 43, 'Water'),
--     (8, 'Wartortle', 1.0, 22.5, 'wartortle.png', 59, 63, 80, 65, 80, 58, 'Water'),
--     (9, 'Blastoise', 1.6, 85.5, 'blastoise.png', 79, 83, 100, 85, 105, 78, 'Water'),
--     (10, 'Pikachu', 0.4, 6.0, 'pikachu.png', 35, 55, 40, 50, 50, 90, 'Electric'),
--     (11, 'Raichu', 0.8, 30.0, 'raichu.png', 60, 90, 55, 90, 80, 110, 'Electric'),
--     (12, 'Jigglypuff', 0.5, 5.5, 'jigglypuff.png', 115, 45, 20, 45, 25, 20, 'Normal/Fairy'),
--     (13, 'Mewtwo', 2.0, 122.0, 'mewtwo.png', 106, 110, 90, 154, 90, 130, 'Psychic'),
--     (14, 'Mew', 0.4, 4.0, 'mew.png', 100, 100, 100, 100, 100, 100, 'Psychic'),
--     (15, 'Gyarados', 6.5, 235.0, 'gyarados.png', 95, 125, 79, 60, 100, 81, 'Water/Flying'); 