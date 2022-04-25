# Тема DDL = data definition language (язык определения данных)
# Команды CREATE, ALTER, DROP
DROP DATABASE IF EXISTS vk;
CREATE DATABASE vk;
USE vk;

DROP TABLE IF EXISTS users;
CREATE TABLE users(
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	# id SERIAL, # BIGINIT USSIGNED NOT NULL AUTO_INCREAMENT UNIQUE
	firstname VARCHAR(100),
	lastname VARCHAR(100),
	email VARCHAR(100) UNIQUE,
	phone BIGINT UNSIGNED UNIQUE,
	
	INDEX idx_users_username(firstname, lastname)
	
);

# отношение 1 x 1 (1 конкретоно юзера один профиль, 1 профиль может ссылаться на одного конкретного юзера)


DROP TABLE IF EXISTS profiles;
CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	genger CHAR(1),
	hometown VARCHAR(200),
	created_at DATETIME DEFAULT NOW()
);

ALTER TABLE profiles ADD CONSTRAINT fk_profiles_user_id
FOREIGN KEY (user_id) REFERENCES users(id)
;


ALTER TABLE profiles ADD COLUMN birthday DATETIME;
# ALTER TABLE profiles MODIFY COLUMN birthday DATE;
# ALTER TABLE profiles RENAME COLUMN birthday TO date_of_birth;
# ALTER TABLE profiles DROP COLUMN date_of_birth;

# отношение 1 х М (один ко многим, один пользователей может быть связан со многими сообщениями,но каждое сообщение может быть связано только с одним конкретным пользователем)

DROP TABLE IF EXISTS messages;
CREATE TABLE messages(
	id SERIAL,
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	body TEXT,
	created_at DATETIME DEFAULT NOW(),
	
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id)
);

DROP TABLE IF EXISTS friend_requests;
CREATE TABLE friend_requests (
	initiator_user_id BIGINT UNSIGNED NOT NULL,
	target_id BIGINT UNSIGNED NOT NULL,
	status ENUM('requested', 'approved', 'declined', 'unfriended'),
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	PRIMARY KEY (initiator_user_id, target_id),
	FOREIGN KEY (initiator_user_id) REFERENCES users(id),
	FOREIGN KEY (target_id) REFERENCES users(id),
	CHECK (initiator_user_id != target_id)
);

ALTER TABLE friend_requests
ADD CHECK (initiator_user_id <> target_id);


DROP TABLE IF EXISTS communities;
CREATE TABLE communities (
	id SERIAL,
	name VARCHAR(255),
	admin_user_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	
	INDEX (name),
	FOREIGN KEY (admin_user_id) REFERENCES users(id)
);

# M х М (связь многие ко многим,одно сообщестов может относиться ко многим пользователям,пользоватиль может состоять во множестве сообществ)

DROP TABLE IF EXISTS users_communities;
CREATE TABLE users_communities(
	user_id BIGINT UNSIGNED NOT NULL,
	community_id BIGINT UNSIGNED NOT NULL,
	
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (community_id) REFERENCES communities(id)
	
);

DROP TABLE IF EXISTS media_types;
CREATE TABLE media_types(
	id SERIAL,
	name VARCHAR (255) # 'text', 'video', 'music', 'image'
);

DROP TABLE IF EXISTS media;
CREATE TABLE media(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_type_id BIGINT UNSIGNED NOT NULL,
	#media_type ENUM('text', 'video', 'music', 'image'),
	body VARCHAR(255),
	#file BLOB,
	filename VARCHAR(255),
	metadata JSON,
	created_at DATETIME DEFAULT NOW(),
	updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,
	
	FOREIGN KEY (user_id) REFERENCES users(id),
	FOREIGN KEY (media_type_id) REFERENCES media_types(id)
);


DROP TABLE IF EXISTS likes;
CREATE TABLE likes(
	id SERIAL,
	user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL
);

ALTER TABLE vk.likes ADD CONSTRAINT likes_FK FOREIGN KEY (media_id) REFERENCES vk.media(id);
ALTER TABLE vk.likes ADD CONSTRAINT likes_FK_1 FOREIGN KEY (user_id) REFERENCES vk.users(id);












