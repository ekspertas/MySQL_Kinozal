/*	Процедура обновленя статуса пользователя. Если пользователь женского пола,
	устанавливаем статус Девушка.
*/

DROP PROCEDURE IF EXISTS sp_set_status_girl;

-- ставим новое обозначение окончания команды (разделитель)
DELIMITER //

CREATE PROCEDURE  sp_set_status_girl()
BEGIN
	SELECT nick_name  AS 'Имя', status AS 'Статус'
	FROM users
		JOIN profiles ON users.id = profiles.user_id; 
	IF profiles.gender = 'ж'
	THEN 
		UPDATE users SET users.status = 2 WHERE profiles.user_id = users.id;
	END IF;
END //

-- Триггеры на проверку введенной даты выхода фильма

DROP TRIGGER IF EXISTS check_relise_date_before_insert //

CREATE TRIGGER check_relise_date_before_insert BEFORE INSERT ON torrents
FOR EACH ROW
BEGIN 
    IF NEW.relise_date > YEAR(CURRENT_DATE()) THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка указания даты выхода фильма';
    END IF;
END//

DROP TRIGGER IF EXISTS check_relise_date_before_update //

CREATE TRIGGER check_relise_date_before_update BEFORE UPDATE ON torrents
FOR EACH ROW
BEGIN 
    IF NEW.relise_date > YEAR(CURRENT_DATE()) THEN 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Ошибка указания даты выхода фильма';
    END IF;
END//

DELIMITER ;-- возвращаем стандартный разделитель
