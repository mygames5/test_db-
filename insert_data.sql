-- Вставка исполнителей
INSERT INTO Artists (name) VALUES 
('Artist1'), 
('Artist2'), 
('Artist3'), 
('Artist4');

-- Вставка жанров
INSERT INTO Genres (name) VALUES 
('Genre1'), 
('Genre2'), 
('Genre3');

-- Вставка альбомов
INSERT INTO Albums (title, release_year) VALUES 
('Album1', 2019), 
('Album2', 2020), 
('Album3', 2021);

-- Вставка треков
INSERT INTO Tracks (title, duration, album_id) VALUES 
('Track1', '00:04:30', 1), 
('Track2', '00:03:45', 1), 
('Track3', '00:05:00', 2), 
('Track4', '00:02:30', 2), 
('Track5', '00:03:15', 3), 
('Track6', '00:04:00', 3);

-- Вставка сборников
INSERT INTO Collections (title, release_year) VALUES 
('Collection1', 2018), 
('Collection2', 2019), 
('Collection3', 2020), 
('Collection4', 2021);

-- Связь исполнителей и жанров
INSERT INTO Artist_Genres (artist_id, genre_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 1);

-- Связь исполнителей и альбомов
INSERT INTO Artist_Albums (artist_id, album_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 1);

-- Связь сборников и треков
INSERT INTO Collection_Tracks (collection_id, track_id) VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(1, 5), 
(2, 6);
