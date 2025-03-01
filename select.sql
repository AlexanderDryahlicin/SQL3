-- ( 2 ) Название и продолжительность самого длительного трека.
SELECT title, duration
FROM Tracks
ORDER BY duration DESC
LIMIT 1;

--Название треков, продолжительность которых не менее 3,5 минут.
SELECT title
FROM Tracks
WHERE duration >= INTERVAL '3 minutes 30 seconds';

--Названия сборников, вышедших в период с 2018 по 2020 год включительно.
SELECT title
FROM Compilations
WHERE release_year BETWEEN 2018 AND 2020;

--Исполнители, чьё имя состоит из одного слова.
SELECT name
FROM Artists
WHERE name NOT LIKE '% %';

--Название треков, которые содержат слово «мой» или «my»
SELECT title
FROM Tracks
WHERE
    title ILIKE 'мой %'   -- Слово в начале строки
    OR title ILIKE '% мой' -- Слово в конце строки
    OR title ILIKE '% мой %' -- Слово в середине строки
    OR title ILIKE 'мой'   -- Название состоит только из этого слова

-- ( 3 ) (Количество исполнителей в каждом жанре.)
SELECT g.name genre_name, COUNT(ag.artist_id) artist_count
FROM genres g
LEFT JOIN Artists_Genres ag ON g.id = ag.genre_id
GROUP BY g.name
ORDER BY artist_count DESC;

-- задание 2 (Количество треков, вошедших в альбомы 2019–2020 годов.)
SELECT COUNT(t.id) AS total_track_count
FROM tracks t
JOIN Albums a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

--Задание 3 (Средняя продолжительность треков по каждому альбому.)
select a.title AS album_title, AVG(EXTRACT(EPOCH FROM t.duration)) AS avg_duration_seconds
FROM tracks t
JOIN Albums a ON t.album_id = a.id
GROUP BY a.title
ORDER BY avg_duration_seconds DESC;

--4 задание (Все исполнители, которые не выпустили альбомы в 2020 году.)
SELECT ar.name AS artist_name
FROM artists ar
WHERE ar.id NOT IN (
    SELECT DISTINCT aa.artist_id
    FROM artists_albums aa
    JOIN albums al ON aa.album_id = al.id
    WHERE al.release_year = 2020
);

--5задание Названия сборников, в которых присутствует конкретный исполнитель.
SELECT DISTINCT c.title AS сборник
FROM Compilations c
JOIN Tracks_Compilations tc ON c.id = tc.compilation_id
JOIN Tracks t ON tc.track_id = t.id
JOIN Albums a ON t.album_id = a.id
JOIN Artists_Albums aa ON a.id = aa.album_id
JOIN Artists ar ON aa.artist_id = ar.id
WHERE ar.name = 'Кино';
