--1 ЗАДАНИЕ

--Создаем таблицу actions с 17 столбцами, регистр везде устанавлием на маленькие буквы,
--чтобы не запоминать, какой столбец какого регистра в данной таблице
DROP TABLE if exists public.actions
;
CREATE TABLE public.actions
(
        "rat_id" smallint NOT NULL,
	"grade" text NOT NULL,
	"outlook" text,
	"change" text NOT NULL,
	"date" date,
	"ent_name" text,
	"okpo" bigint,
	"ogrn" bigint,
	"inn" bigint,
	"finst" bigint,
	"agency_id" text,
	"rat_industry" text,
	"rat_type" text,
	"horizon" text,
	"scale_typer" text,
	"currency" text,
	"backed_flag" text
	
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Назначаем владельца таблицы
ALTER TABLE public.actions
    OWNER to postgres;
-- Импортируем Excel файл, учитывая Header, Delimiter (;) и WIN1251
--Либо используем командную строку
\copy public.actions  FROM 'Путь файла' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';


--Создаем таблицу credit_events с тремя столбцами "INN", "DATE", "EVENT"
--Столбцы "INN" и "EVENT" ненулевые, т.к. они содержат ключевую информацию для данной таблицы: 
--если мы не знаем, что было за событие, нам не поможет информация об INN, и наоборот.
DROP TABLE if exists public.credit_events
;
CREATE TABLE public.credit_events
(
        "INN" bigint NOT NULL,
	"DATE" date,
	"EVENT" text NOT NULL
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Назначаем владельца таблицы
ALTER TABLE public.credit_events
    OWNER to postgres;
--Импортируем Excel файл, учитывая Header и Delimiter (;)
--Либо используем командную строку
\copy public.credit_events  FROM 'Путь Excel документа' DELIMITER ';' CSV HEADER;


--Создаем таблицу scale_exp с двумя столбцами "grade" и "grade_id"
DROP TABLE if exists public.scale_exp
;
CREATE TABLE public.scale_exp
(
    "grade" text ,
    "grade_id" int
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

-- Назначаем владельца таблицы
ALTER TABLE public.scale_exp
    OWNER to postgres;
--Импортируем Excel файл, учитывая Header, Delimiter (;) и WIN 1251
--Либо используем командную строку
\copy public.scale_exp  FROM 'Путь файла' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';

--2 ЗАДАНИЕ
--Проанализируем таблицу actions для дальнейшего удобства в работе
--1.Узнаем, сколько всего строк в таблице actions(их 38252)
select count(*)
from actions;
--2.Узнаем, можно ли использовать столбец rat_id как первичный ключ
--(Нельзя, поскольку различных rat_id в таблице всего 111)
select count(distinct "rat_id")
from actions;
--3.Узнаем, сколько различных рейтингуемых компаний (их 2048)
select count(distinct ent_name)
from actions;
--4.Узнаем, сколько различных строк, содержащих информацию о рейтингуемой компании (их 2048)
SELECT COUNT(*) 
FROM (SELECT DISTINCT ent_name, okpo, ogrn, inn, finst
      FROM actions) AS bbb;
--ВЫВОД: в новой таблице ent_info можно использовать столбец ent_name (аналогично, okpo,ogrn,inn,finst)
--в качестве первичного ключа, однако, поскольку название компании и другие регистрационные номера могут поменяться,
--следует ввести идентификатор(в нашем случае, можно ограничиться нумерацией)

--Cоздание таблицы для выноса информации о дифференциации рейтингуемых компаний.
--Создаем столбец ent_id в качестве первичного ключа
DROP TABLE IF EXISTS public.ent_info
;
CREATE TABLE public.ent_info
(
	"ent_id" integer,
        "ent_name" text,
	"okpo" bigint,
	"ogrn" bigint,
	"inn" bigint,
	"finst" bigint,
    CONSTRAINT infokey PRIMARY KEY ("ent_id")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;
-- Назначаем владельца таблицы
ALTER TABLE public.ent_info
    OWNER to postgres;
    
    
--Заполняем созданную нами таблицу ent_info, где в роли идентификатора выступает 
--новый столбец ent_id
insert into ent_info select count(*) over (order by  "ent_name","okpo",
"ogrn","inn","finst") as ent_id,
"ent_name","okpo","ogrn","inn",
"finst"
from (select distinct "ent_name","okpo","ogrn","inn","finst"
from actions)
 as my_table


--Создание таблицы для выноса информации о дифференциации рейтингов.
--Добавляем новый столбец rat_number, который будет идентифицировать каждую совокупность
--характеристик для определенного рейтинга
DROP TABLE IF EXISTS public.ratings_info
;
CREATE TABLE public.ratings_info
(
        "rat_number" bigint NOT NULL,
        "rat_id" smallint NOT NULL,
	"agency_id" text NOT NULL,
	"rat_industry" text,
	"rat_type" text,
	"horizon" text,
	"scale_typer" text,
	"currency" text,
	"backed_flag" text,
    CONSTRAINT somename PRIMARY KEY ("rat_number")
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE public.ratings_info
    OWNER to postgres;
    
--Заполняем созданную нами таблицу ratings_info, где в роли идентификатора выступает 
--столбец rat_number(просто нумерация, счетчик с увеличением на 1)
--*Подробные пояснения данного запроса были объяснены на семинаре 2.
insert into ratings_info select count(*) over (order by  "rat_id","agency_id",
"rat_industry","rat_type","horizon","scale_typer",
"currency","backed_flag") as rat_number,
"rat_id","agency_id","rat_industry","rat_type",
"horizon","scale_typer","currency","backed_flag"
from (select distinct "rat_id","agency_id","rat_industry","rat_type",
"horizon","scale_typer","currency","backed_flag"
from actions)
 as my_table1
 

--3 ЗАДАНИЕ 
--Создаем внешний ключ fr_key_1, в роли которого выступает столбец rat_number. Данный ключ связывает две таблицы:
--actions и ratings_info, при этом являясь первичным ключом в таблице ratings_info. Выбор внешнего ключа зависит от
--конкретной постановки задачи. Например, в данном задании в качестве внешних ключей можно также задать либо
--столбец ent_id, который будет связывать таблицы actions и ent_info, либо столбец grade, который будет связывать
--таблицы actions и scale_exp. Но, чтобы не нагромождать таблицу actions дополнительными столбцами, ограничимся
--установкой единственного внешнего ключа.

--Создаем столбец rat_number в таблице actions
alter table actions 
add column "rat_number" integer;
--Заполняем столбец rat_number в таблице actions
UPDATE actions
SET rat_number = ratings_info.rat_number
FROM ratings_info
WHERE 
actions.rat_id = ratings_info.rat_id AND
actions.agency_id = ratings_info.agency_id AND
(actions.rat_industry = ratings_info.rat_industry
OR (actions.rat_industry is null and ratings_info.rat_industry is null)) AND
(actions.rat_type = ratings_info.rat_type
OR (actions.rat_type is null and ratings_info.rat_type is null)) AND
(actions.horizon = ratings_info.horizon
OR (actions.horizon is null and ratings_info.horizon is null)) AND
(actions.scale_typer = ratings_info.scale_typer
OR (actions.scale_typer is null and ratings_info.scale_typer is null)) AND
(actions.currency = ratings_info.currency
OR (actions.currency is null and ratings_info.currency is null)) AND
(actions.backed_flag = ratings_info.backed_flag
OR (actions.backed_flag is null and ratings_info.backed_flag is null));
ALTER TABLE public.actions 
ADD CONSTRAINT fr_key_1 FOREIGN KEY (rat_number) 
REFERENCES public.ratings_info (rat_number);
    
--Создаем внешний ключ fr_key_2, в роли которого выступает столбец ent_id. Данный ключ связывает две таблицы:
--credit_events и ent_info, при этом являясь первичным ключом в таблице ent_info.
--Добавляем в таблицу credit_events новый столбец ent_id
alter table credit_events 
add column "ent_id" integer;
--Заполняем поле с кодами-ссылками на новую таблицу
update credit_events 
set ent_id=ent_info.ent_id
from ent_info
where credit_events."INN"=ent_info."inn";
-- Присвоение полю ограничение внешнего ключа
ALTER TABLE public.credit_events 
ADD CONSTRAINT fr_key_2 FOREIGN KEY (ent_id) REFERENCES public.ent_info (ent_id);
    
--4 ЗАДАНИЕ

--Выбираем столбцы ent_name, date(который называем как last_date) и grade из таблицы, которая является
--пересечением таблиц actions и new_table. new_table, в свою очередь, является таблицей, полученной в ходе подзапроса,
--и содержит два столбца "COMPANY" и "LAST_DATE". 
SELECT "ent_name", "date" as "last_date", "grade"
FROM actions
INNER JOIN (SELECT "ent_name" as "COMPANY", max("date") as "LAST_DATE"
FROM actions
--Ограничения для rat_id и date устанавливает пользователь для конкретной задачи
WHERE "rat_id"=52 AND "date"<='2014-11-05'
--Группируем по столбцу ent_name
GROUP BY "ent_name"
--Располагаем в алфавитном порядке
ORDER BY "ent_name") AS new_table
--Указываем столбцы двух таблиц, по которым реализовываем пересечение (в данном случае, это столбцы, отвечающие за
--название рейтингуемой компании и дату присвоения рейтинга)
ON "ent_name"=new_table."COMPANY"
AND "date"=new_table."LAST_DATE"
--Устанавливаем ограничение, согласно которому мы не учитываем рейтинг за последнюю дату, если он был снят или приостановлен.
WHERE "grade"!='Снят' AND "grade"!='Приостановлен'
--Окончательный результат выводим в алфавитном порядке
ORDER BY "ent_name";
