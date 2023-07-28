-- Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)

SELECT cats.id, cats.`name`, shops.id, shops.shopname FROM cats
LEFT JOIN shops ON shops.id = cats.shops_id
ORDER BY shops.id;


-- Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)

SELECT cats.`name`, shops.id, shops.shopname FROM cats
JOIN shops ON shops.id = cats.shops_id
WHERE cats.`name`= "Murzik";

SELECT * FROM shops
WHERE id IN (SELECT shops_id FROM cats WHERE `name`= "Murzik");


-- Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

SELECT * FROM shops
WHERE shops.id NOT IN (SELECT shops_id FROM cats WHERE `name` IN ("Murzik", "Zuza"))
ORDER BY shops.id;


-- Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.

SELECT orders.ord_datetime, analysis.an_name, analysis.an_price
FROM orders
LEFT JOIN analysis ON orders.ord_an=analysis.an_id
WHERE orders.ord_datetime BETWEEN "2020-02-05 00:00:00" AND "2020-02-12 00:00:00";

