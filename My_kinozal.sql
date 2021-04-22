-- создание БД и таблиц

CREATE DATABASE my_kinozal;
USE my_kinozal;


 CREATE TABLE users (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	nick_name varchar(145) NOT NULL UNIQUE,
	email varchar(145) NOT NULL UNIQUE,
	password_hash varchar(65) DEFAULT NULL UNIQUE,
	torrent_uid varchar(65) DEFAULT NULL UNIQUE,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	status INT UNSIGNED DEFAULT NULL,
	u_rank INT UNSIGNED DEFAULT NULL,
	сups INT UNSIGNED DEFAULT NULL,
	INDEX email_unique (email)
);

 CREATE TABLE profiles (
	user_id BIGINT UNSIGNED NOT NULL,
	gender varchar(10) DEFAULT NULL,
	birthday DATE DEFAULT NULL,
	photo_id BIGINT UNSIGNED DEFAULT NULL,
	country varchar(130),
	city varchar(130),
	user_info varchar(255) DEFAULT NULL,
	favorite_movie varchar(130) DEFAULT NULL,
	favorite_persons varchar(130) DEFAULT NULL,
	UNIQUE INDEX fk_profiles_users_to_idx (user_id),
	CONSTRAINT fk_profiles_users FOREIGN KEY (user_id) REFERENCES users (id)
);

CREATE TABLE communities (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(145) NOT NULL,
	description varchar(245) NOT NULL,
	admin_id BIGINT UNSIGNED NOT NULL,
	INDEX fk_communities_users_admin_idx (admin_id),
	CONSTRAINT fk_communities_users FOREIGN KEY (admin_id) REFERENCES users (id)
);

CREATE TABLE photos (							-- фото только в формате jpg
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	file_name varchar(130) DEFAULT NULL COMMENT '/files/folder/img.jpg',
	file_size BIGINT DEFAULT NULL,
	created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

 CREATE TABLE media_types (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(145) NOT NULL,
	UNIQUE INDEX (name)
);

CREATE TABLE torrents (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	title varchar(145) NOT NULL,
	poster BIGINT UNSIGNED NOT NULL,
	sections INT UNSIGNED NOT NULL,
	description varchar(255) NOT NULL,
	relise_date YEAR NOT NULL,
	media_type INT UNSIGNED NOT NULL,
	file_size BIGINT UNSIGNED NOT NULL,
	distributor_name varchar(145) NOT NULL,
	comments varchar(255) DEFAULT NULL,
	seeds INT(100) UNSIGNED DEFAULT NULL,
	peers INT(100) UNSIGNED DEFAULT NULL,
	torrent_hash varchar(65) DEFAULT NULL UNIQUE
);


CREATE TABLE users_statuses (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(145) NOT NULL
);

CREATE TABLE users_ranks (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(145) NOT NULL
);

CREATE TABLE сhallenge_сups (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(145) NOT NULL
);

CREATE TABLE sections (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name varchar(145) NOT NULL,
	UNIQUE INDEX (name) -- для боее быстроко поиска по категориям
);

-- создание связей между таблицами


ALTER TABLE profiles ADD CONSTRAINT fk_profiles_photos FOREIGN KEY (photo_id) REFERENCES photos (id);

ALTER TABLE users ADD CONSTRAINT fk_users_users_ranks FOREIGN KEY (status) REFERENCES users_ranks (id);

ALTER TABLE users ADD CONSTRAINT fk_users_users_statuses FOREIGN KEY (u_rank) REFERENCES users_statuses (id);

ALTER TABLE users ADD CONSTRAINT fk_users_сhallenge_сups FOREIGN KEY (сups) REFERENCES сhallenge_сups (id);

ALTER TABLE torrents ADD CONSTRAINT fk01_torrents_users FOREIGN KEY (user_id) REFERENCES users (id);

ALTER TABLE torrents ADD CONSTRAINT fk02_torrents_photos FOREIGN KEY (poster) REFERENCES photos (id);

ALTER TABLE torrents ADD CONSTRAINT fk03_torrents_sections FOREIGN KEY (sections) REFERENCES sections (id);

ALTER TABLE torrents ADD CONSTRAINT fk04_torrents_media_types FOREIGN KEY (media_type) REFERENCES media_types (id);

ALTER TABLE torrents ADD CONSTRAINT fk05_torrents_users FOREIGN KEY (distributor_name) REFERENCES users (nick_name);

ALTER TABLE torrents ADD CONSTRAINT fk06_torrents_users FOREIGN KEY (torrent_hash) REFERENCES users (torrent_uid);

-- Заполнение таблиц данными

INSERT INTO users (nick_name, email)
VALUES	('зайчик','mail01@mail.com'),('шурик','mail02@mail.com'),('котик','mail03@mail.com'),('рыжик','mail04@mail.com'),
		('fuks','mail05@mail.com'),('киношник','mail06@mail.com'),('chacker','mail07@mail.com'),('мурка','mail08@mail.com'),
		('сильва','mail09@mail.com'),('pupsik','mail10@mail.com');

INSERT INTO photos (file_name, file_size) VALUES ('фото1', 256),('фото2', 321),('фото3', 213),('фото4', 320),('фото5', 189),
('фото6', 278),('фото7', 198),('фото8', 289),('фото9', 398),('фото10', 145),('постер1', 563),('постер2', 321),
('постер3', 458),('постер4', 520),('постер5', 378);
	
INSERT INTO profiles (user_id, gender, birthday, photo_id, country, city, user_info, favorite_movie, favorite_persons)
VALUES	(1,'ж', '1982-02-25', 1, 'Россия', 'Москва', 'Если к другому уходит невеста , то неизвестно кому повезло...',
		'Собака на сене', 'Александр Абдулов' ),
		(2,'м', '1976-04-21', 2, 'Россия', 'Калуга', 'АРТ-СТУДИЯ','Схватка 1995 г, Ганнибал', 'Энтони Хопкинс'),
		(3,'ж', '1990-01-11', 3, 'Германия', 'Магдебург', '"Зависть в тысячу раз хуже голода. Зависть - это голодающая
		душа" Мигель де Унамуно','Хохмачи', 'Омар Хайям'),
		(4,'ж', '1975-04-16', 4, 'СССР...', 'Новоуральск', 'КОРОНУ ИЗ ПРИНЦИПА НЕ ОДЕВАЮ... ТАК КАК ИНОЙ РАЗ КОРОНУ ЛОПАТОЙ 
		МОГУТ ПОПРАВИТЬ!!!','ЗВЕЗДНЫЕ ВОЙНЫ', 'Николас Кейдж'),
		(5,'м', '1985-01-29', 5, 'Беларусь', 'Минск', 'Кубок за количество раздач, добавленных за последнюю неделю',
		'1+1', 'Леонардо ДиКаприо'),
		(6,'м', '1991-12-16', 6, 'Россия', 'Королёв', 'За самую обсуждаемую раздачу в Кинозал.ТВ','Рожденные революцией',
		'Александр Абдулов'),
		(7,'м', '1969-06-16', 7, 'Россия', 'Москва', 'Рейтинг не накручиваю, мне он без надобности.','Собака на сене',
		'Анджелина Джоли'),
		(8,'ж', '1978-01-16', 8, 'Казахстан', 'Усть-Каменогорск', 'Какие умные мы ведем разговоры, и какую глупую мы ведем жизнь',
		'Назад в будущее', 'Джет Ли'),
		(9,'ж', '1985-11-01', 9, 'Россия', 'Рязань', 'Не отвечаю на вопросы адресованные "фонарному столбу','Собака на сене',
		'Джеки Чан'),
		(10,'ж', '1986-09-11', 10, 'США', 'Лос-Анджелес', 'Хочешь увидеть киноновинки первым? Присоеденись финансово -> D O N A T E',
		'Собачий пир, Такси-блюз', 'Пикуль, Шакуров, Солоницын');
	
INSERT INTO communities (name, description, admin_id)
VALUES	('СССР: Самые кассовые фильмы', 'Список фильмов, собравших наибольшее количество зрителей в прокате СССР.', 7),
		('Новогодние и Рождественские Ужастики', 'В данной группе представлены раздачи ужастиков тематики Рождества и Нового Года', 8),
		('День сурка', 'В эту группу будут добавляться все фильмы на тему "Дня сурка".', 3),
		('Топ Аниме Кинозал.ТВ', 'В этой группе будет именно те Аниме, которое заслужили внимание миллионы зрителей!', 5);
	
INSERT INTO media_types VALUES (1,'Видео'),(2,'Аудио'),(3,'Программы'),(4,'Игры');

INSERT INTO sections VALUES (1,'Кино'),(2,'Сериал'),(3,'Мультфильм'),(4,'Музыка'),(5,'Другое');	
	
INSERT INTO torrents (user_id, title, poster, sections, description, relise_date, media_type, file_size, distributor_name)
VALUES	(1, 'Черный', 1, 3, 'По стихотворению Саши Черного в исполнении рэпера Наума Блика.', 2012, 1, 782325, 'зайчик'),
		(3, 'Храброе сердце', 2, 1, 'Что делать, если и умея мыслить на трех языках, все равно думаешь об одном: как жить 
		и растить своих детей в стране, которая тебе не принадлежит?', 1995, 1, 1956874, 'котик'),
		(5, 'Заноза для графа', 3, 5, 'Окончив учебу, Джейд не ждала от судьбы подарков, но надеялась на лучшее. Зря!', 2021,
		2, 897256, 'fuks'),
		(9, 'Последний богатырь: Корень зла', 4, 1, 'Во второй части зрители узнают об истоках древнего зла.', 2020, 1, 
		1562387, 'сильва'),
		(6, 'Мажор. Фильм', 5, 1, 'Мажор виртуозно сбегает из тюрьмы и начинает новую жизнь. Новую сладкую жизнь!', 2021, 1, 
		2782325, 'киношник');

INSERT INTO users_ranks VALUES (1,'Зритель'),(2,'Опытный Зритель'),(3,'Заслуженный Зритель'),(4,'ВИП'),(5,'Кинооператор'),
(6,'Главный Кинооператор'),(7,'Менеджер'),(8,'Редактор'),(9,'Администратор'),(10,'Директор');

INSERT INTO users_statuses VALUES (1,'Меценат'),(2,'Девушка'),(3,'Коро(ль,лева)'),(4,'Верный сид'),(5,'Риторик'),
(6,'Хранитель раздач'),(7,'День рождения'),(8,'Предупрежден'),(9,'Предупрежден 1 Торрент'),(10,'Отключен');

INSERT INTO сhallenge_сups VALUES (1,'Кубок за лучшую раздачу'),(2,'Кубок за популярную раздачу'),
(3,'Кубок самому активному раздающему'),(4,'Кубок за самую обсуждаемую раздачу'),(5,'Кубок лучшему комментатору'),
(6,'Кубок активному Меценату'),(7,'Кубок лучшему Меценату'),(8,'Кубок лучшему ДиДжею');