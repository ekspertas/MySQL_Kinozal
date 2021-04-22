-- Простая выборка с объединением 3-х таблиц

SELECT  u1.nick_name AS 'Ник',
		pr.favorite_movie AS 'Любимый фильм',
		tr.title AS 'Раздает'
FROM torrents AS tr
	 JOIN profiles AS pr ON (pr.user_id = tr.user_id)
	 JOIN users AS u1 ON (u1.id = tr.user_id)
ORDER BY u1.nick_name;

-- Представление для вывода стран проживания пользователей раздающих фильмы

CREATE or replace VIEW distributors
AS 
SELECT  tr.distributor_name AS 'Раздает',
		pr.country AS 'Откуда',
		tr.title AS 'Название фильма'
FROM torrents AS tr
	 JOIN profiles AS pr ON (pr.user_id = tr.user_id)
ORDER BY pr.country;

SELECT * FROM distributors;

-- Представление для вывода даты рождения и пола пользователей

CREATE or replace VIEW short_view
AS 
SELECT  u.nick_name AS 'Ник',
		pr.birthday AS 'Дата рождения',
		pr.gender AS 'Пол'
FROM users AS u
	 JOIN profiles AS pr ON (pr.user_id = u.id)
ORDER BY pr.gender;
  
 SELECT * FROM short_view;