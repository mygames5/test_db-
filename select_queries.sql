-- 1. Количество исполнителей в каждом жанре
SELECT g.name, COUNT(ag.artist_id) as artist_count
FROM Genres g
JOIN Artist_Genres ag ON g.genre_id = ag.genre_id
GROUP BY g.name;

-- 2. Количество треков, вошедших в альбомы 2019–2020 годов
SELECT COUNT(t.track_id) as track_count
FROM Tracks t
JOIN Albums a ON t.album_id = a.album_id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по каждому альбому
SELECT a.title, AVG(EXTRACT(EPOCH FROM t.duration)) as avg_duration_seconds
FROM Albums a
JOIN Tracks t ON a.album_id = t.album_id
GROUP BY a.title;

-- 4. Все исполнители, которые не выпустили альбомы в 2020 году
SELECT name 
FROM Artists 
WHERE artist_id NOT IN (
    SELECT aa.artist_id 
    FROM Artist_Albums aa
    JOIN Albums a ON aa.album_id = a.album_id
    WHERE a.release_year = 2020
);

-- 5. Названия сборников, в которых присутствует конкретный исполнитель
SELECT c.title
FROM Collections c
JOIN Collection_Tracks ct ON c.collection_id = ct.collection_id
JOIN Tracks t ON ct.track_id = t.track_id
JOIN Albums a ON t.album_id = a.album_id
JOIN Artist_Albums aa ON a.album_id = aa.album_id
WHERE aa.artist_id = 1; -- Замените 1 на нужный artist_id

-- 6. Названия альбомов, в которых присутствуют исполнители более чем одного жанра
SELECT a.title
FROM Albums a
JOIN Artist_Albums aa ON a.album_id = aa.album_id
JOIN Artist_Genres ag ON aa.artist_id = ag.artist_id
GROUP BY a.title
HAVING COUNT(DISTINCT ag.genre_id) > 1;

-- 7. Наименования треков, которые не входят в сборники
SELECT t.title
FROM Tracks t
LEFT JOIN Collection_Tracks ct ON t.track_id = ct.track_id
WHERE ct.track_id IS NULL;

-- 8. Исполнитель или исполнители, написавшие самый короткий по продолжительности трек
SELECT ar.name
FROM Artists ar
JOIN Artist_Albums aa ON ar.artist_id = aa.artist_id
JOIN Albums al ON aa.album_id = al.album_id
JOIN Tracks t ON al.album_id = t.album_id
WHERE t.duration = (
    SELECT MIN(duration) 
    FROM Tracks
);

-- 9. Название и продолжительность самого длительного трека
SELECT title, duration 
FROM Tracks 
ORDER BY duration DESC 
LIMIT 1;

-- 10. Название треков, продолжительность которых не менее 3,5 минут
SELECT title 
FROM Tracks 
WHERE duration >= '00:03:30';

-- 11. Названия сборников, вышедших в период с 2018 по 2020 год включительно
SELECT title 
FROM Collections 
WHERE release_year BETWEEN 2018 AND 2020;

-- 12. Исполнители, чьё имя состоит из одного слова
SELECT name 
FROM Artists 
WHERE name NOT LIKE '% %';

-- 13. Название треков, которые содержат слово «мой» или «my»
SELECT title 
FROM Tracks 
WHERE (string_to_array(lower(title), ' ') && ARRAY['мой', 'my']) OR 
      (string_to_array(lower(title), ' ') && ARRAY['my']);
