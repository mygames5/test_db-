-- Создание таблицы для исполнителей
CREATE TABLE Artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Вставка данных для исполнителей
INSERT INTO Artists (name)
VALUES 
    ('The Beatles'),
    ('Michael Jackson'),
    ('Adele');

-- Создание таблицы для альбомов
CREATE TABLE Albums (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT,
    artist_id INT REFERENCES Artists(artist_id)
);

-- Вставка данных для альбомов
INSERT INTO Albums (title, release_year, artist_id)
VALUES 
    ('Please Please Me', 1963, 1),       -- The Beatles
    ('Thriller', 1982, 2),               -- Michael Jackson
    ('19', 2008, 3);                     -- Adele

-- Создание таблицы для треков
CREATE TABLE Tracks (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration TIME,
    album_id INT REFERENCES Albums(album_id)
);

-- Вставка данных для треков
INSERT INTO Tracks (title, duration, album_id)
VALUES 
    ('I Saw Her Standing There', '00:02:55', 1),    -- The Beatles, Please Please Me
    ('Billie Jean', '00:04:54', 2),                -- Michael Jackson, Thriller
    ('Hometown Glory', '00:04:31', 3);             -- Adele, 19
