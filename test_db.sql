-- Создание таблицы для музыкальных жанров
CREATE TABLE Genres (
    genre_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Создание таблицы для исполнителей
CREATE TABLE Artists (
    artist_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Создание промежуточной таблицы для связи исполнителей и жанров (многие ко многим)
CREATE TABLE Artist_Genres (
    artist_id INT REFERENCES Artists(artist_id),
    genre_id INT REFERENCES Genres(genre_id),
    PRIMARY KEY (artist_id, genre_id)
);

-- Создание таблицы для альбомов
CREATE TABLE Albums (
    album_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT
);

-- Создание промежуточной таблицы для связи исполнителей и альбомов (многие ко многим)
CREATE TABLE Artist_Albums (
    artist_id INT REFERENCES Artists(artist_id),
    album_id INT REFERENCES Albums(album_id),
    PRIMARY KEY (artist_id, album_id)
);

-- Создание таблицы для треков
CREATE TABLE Tracks (
    track_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration TIME,
    album_id INT REFERENCES Albums(album_id)
);

-- Создание таблицы для сборников
CREATE TABLE Collections (
    collection_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT
);

-- Создание промежуточной таблицы для связи сборников и треков (многие ко многим)
CREATE TABLE Collection_Tracks (
    collection_id INT REFERENCES Collections(collection_id),
    track_id INT REFERENCES Tracks(track_id),
    PRIMARY KEY (collection_id, track_id)
);

-- Добавление данных
-- Добавление жанров
INSERT INTO Genres (name) VALUES
('Pop'), ('Rock'), ('Soul');

-- Добавление исполнителей
INSERT INTO Artists (name) VALUES
('The Beatles'), ('Michael Jackson'), ('Adele');

-- Добавление связи исполнителей и жанров
INSERT INTO Artist_Genres (artist_id, genre_id) VALUES
(1, 2), -- The Beatles - Rock
(2, 1), -- Michael Jackson - Pop
(3, 1), -- Adele - Pop
(3, 3); -- Adele - Soul

-- Добавление альбомов
INSERT INTO Albums (title, release_year) VALUES
('Please Please Me', 1963),
('Thriller', 1982),
('19', 2008);

-- Добавление связи исполнителей и альбомов
INSERT INTO Artist_Albums (artist_id, album_id) VALUES
(1, 1), -- The Beatles - Please Please Me
(2, 2), -- Michael Jackson - Thriller
(3, 3); -- Adele - 19

-- Добавление треков
INSERT INTO Tracks (title, duration, album_id) VALUES
('I Saw Her Standing There', '02:55', 1),
('Baby It\'s You', '02:38', 1),
('Beat It', '04:18', 2),
('Billie Jean', '04:54', 2),
('Daydreamer', '03:40', 3),
('Chasing Pavements', '03:30', 3);

-- Добавление сборников
INSERT INTO Collections (title, release_year) VALUES
('Best of the 60s', 2020),
('80s Greatest Hits', 2021);

-- Добавление треков в сборники
INSERT INTO Collection_Tracks (collection_id, track_id) VALUES
(1, 1), -- I Saw Her Standing There
(1, 2), -- Baby It's You
(2, 3), -- Beat It
(2, 4); -- Billie Jean
