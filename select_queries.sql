-- 1. Название и продолжительность самого длительного трека.
SELECT title, duration 
FROM tracks 
ORDER BY duration DESC 
LIMIT 1;

-- 2. Название треков, продолжительность которых не менее 3,5 минут.
SELECT title 
FROM tracks 
WHERE duration >= '00:03:30';

-- 3. Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title 
FROM collections 
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители, чьё имя состоит из одного слова.
SELECT name 
FROM artists 
WHERE name NOT LIKE '% %';

-- 5. Название треков, которые содержат слово «мой» или «my».
SELECT title 
FROM tracks 
WHERE title ILIKE '%мой%' OR title ILIKE '%my%';




-- 1. Количество исполнителей в каждом жанре.
SELECT g.name, COUNT(ag.artist_id) as artist_count
FROM genres g
JOIN artist_genre ag ON g.genre_id = ag.genre_id
GROUP BY g.name;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов.
SELECT COUNT(t.track_id) as track_count
FROM tracks t
JOIN albums a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому.
SELECT a.title, AVG(t.duration) as avg_duration
FROM albums a
JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.title;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году.
SELECT name 
FROM artists 
WHERE artist_id NOT IN (
    SELECT aa.artist_id 
    FROM artist_album aa
    JOIN albums a ON aa.album_id = a.album_id
    WHERE a.release_year = 2020
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель.
SELECT c.title
FROM collections c
JOIN collection_track ct ON c.collection_id = ct.collection_id
JOIN tracks t ON ct.track_id = t.track_id
JOIN albums a ON t.album_id = a.album_id
JOIN artist_album aa ON a.album_id = aa.album_id
WHERE aa.artist_id = 1; -- Заглушка id




-- 1. Названия альбомов, в которых присутствуют исполнители более чем одного жанра.
SELECT a.title
FROM albums a
JOIN artist_album aa ON a.album_id = aa.album_id
JOIN artist_genre ag ON aa.artist_id = ag.artist_id
GROUP BY a.title
HAVING COUNT(DISTINCT ag.genre_id) > 1;

-- 2. Наименования треков, которые не входят в сборники.
SELECT t.title
FROM tracks t
LEFT JOIN collection_track ct ON t.track_id = ct.track_id
WHERE ct.track_id IS NULL;

-- 3. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек.
SELECT ar.name
FROM artists ar
JOIN artist_album aa ON ar.artist_id = aa.artist_id
JOIN albums al ON aa.album_id = al.album_id
JOIN tracks t ON al.album_id = t.album_id
WHERE t.duration = (
    SELECT MIN(duration) 
    FROM tracks
);

-- 4. Названия альбомов, содержащих наименьшее количество треков.
SELECT a.title
FROM albums a
JOIN tracks t ON a.album_id = t.album_id
GROUP BY a.title
ORDER BY COUNT(t.track_id)
LIMIT 1;
