-- Создание таблицы Genres
CREATE TABLE Genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Создание таблицы Artists
CREATE TABLE Artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Создание таблицы Albums
CREATE TABLE Albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER
);

-- Создание таблицы Tracks
CREATE TABLE Tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    duration INTERVAL,
    album_id INTEGER REFERENCES Albums(id)
);

-- Создание таблицы Compilations
CREATE TABLE Compilations (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    release_year INTEGER
);

-- Создание таблицы Artists_Genres (связь многие-ко-многим: Исполнители и жанры)
CREATE TABLE Artists_Genres (
    artist_id INTEGER REFERENCES Artists(id),
    genre_id INTEGER REFERENCES Genres(id),
    PRIMARY KEY (artist_id, genre_id)
);

-- Создание таблицы Artists_Albums (связь многие-ко-многим: Исполнители и альбомы)
CREATE TABLE Artists_Albums (
    artist_id INTEGER REFERENCES Artists(id),
    album_id INTEGER REFERENCES Albums(id),
    PRIMARY KEY (artist_id, album_id)
);

-- Создание таблицы Tracks_Compilations (связь многие-ко-многим: Треки и сборники)
CREATE TABLE Tracks_Compilations (
    track_id INTEGER REFERENCES Tracks(id),
    compilation_id INTEGER REFERENCES Compilations(id),
    PRIMARY KEY (track_id, compilation_id)
);