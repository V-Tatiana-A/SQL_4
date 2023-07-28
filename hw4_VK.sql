-- Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.

SELECT m.user_id, CONCAT(u.firstname, " ", u.lastname) AS fullname, p.birthday, COUNT(l.id) AS likes_sum
FROM media AS m
LEFT JOIN likes AS l ON l.media_id=m.id
JOIN users AS u ON u.id=m.user_id
JOIN `profiles` AS p ON p.user_id=u.id
WHERE p.birthday>"2011-07-28"
GROUP BY m.user_id;

-- Определить кто больше поставил лайков (всего): мужчины или женщины.

SELECT p.gender, COUNT(l.id) AS total_likes FROM likes AS l
LEFT JOIN `profiles` AS p ON l.user_id=p.user_id
GROUP BY p.gender
ORDER BY COUNT(l.id) DESC
LIMIT 1;

-- Вывести всех пользователей, которые не отправляли сообщения.

SELECT u.id, CONCAT(u.firstname, " ", u.lastname) AS fullname FROM users u
WHERE u.id NOT IN (SELECT from_user_id FROM messages)
ORDER BY u.id;

-- или

SELECT u.id, CONCAT(u.firstname, " ", u.lastname) AS fullname FROM users u
LEFT JOIN messages m ON m.from_user_id=u.id
WHERE m.id IS NULL;


-- Пусть задан некоторый пользователь(выбираете сами, к примеру, Reuben). 
-- Из всех друзей этого пользователя найдите человека, который больше всех написал ему сообщений.

SELECT u.id, CONCAT(u.firstname, " ", u.lastname) AS fullname, COUNT(m.body) AS messages_count FROM users u
LEFT JOIN (
SELECT initiator_user_id, `status` FROM friend_requests WHERE target_user_id IN (SELECT id FROM users WHERE firstname="Reuben")
UNION
SELECT target_user_id, `status` FROM friend_requests WHERE initiator_user_id IN (SELECT id FROM users WHERE firstname="Reuben"))
AS friends ON friends.initiator_user_id= u.id
LEFT JOIN messages m ON m.from_user_id=u.id
WHERE friends.`status`="approved" AND
m.to_user_id IN (SELECT id FROM users WHERE firstname="Reuben")
GROUP BY u.id
ORDER BY messages_count DESC
LIMIT 1;