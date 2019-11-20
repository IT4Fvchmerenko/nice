-- Table: public.quotes

-- DROP TABLE public.quotes;

CREATE TABLE public.quotes
(
    "ID" integer NOT NULL,
    "TIME" date NOT NULL,
    "ACCRUEDINT" text COLLATE pg_catalog."default",
    "ASK" text COLLATE pg_catalog."default",
    "ASK_SIZE" integer,
    "ASK_SIZE_TOTAL" integer,
    "AVGE_PRCE" text COLLATE pg_catalog."default",
    "BID" text COLLATE pg_catalog."default",
    "BID_SIZE" integer,
    "BID_SIZE_TOTAL" integer,
    "BOARDID" text COLLATE pg_catalog."default",
    "BOARDNAME" text COLLATE pg_catalog."default",
    "BUYBACKDATE" date,
    "BUYBACKPRICE" text COLLATE pg_catalog."default",
    "CBR_LOMBARD" text COLLATE pg_catalog."default",
    "CBR_PLEDGE" text COLLATE pg_catalog."default",
    "CLOSE" text COLLATE pg_catalog."default",
    "CPN" text COLLATE pg_catalog."default",
    "CPN_DATE" date,
    "CPN_PERIOD" integer,
    "DEAL_ACC" integer,
    "FACEVALUE" text COLLATE pg_catalog."default",
    "ISIN" text COLLATE pg_catalog."default",
    "ISSUER" text COLLATE pg_catalog."default",
    "ISSUESIZE" bigint,
    "MAT_DATE" date,
    "MPRICE" text COLLATE pg_catalog."default",
    "MPRICE2" text COLLATE pg_catalog."default",
    "SPREAD" text COLLATE pg_catalog."default",
    "VOL_ACC" bigint,
    "Y2O_ASK" text COLLATE pg_catalog."default",
    "Y2O_BID" text COLLATE pg_catalog."default",
    "YIELD_ASK" text COLLATE pg_catalog."default",
    "YIELD_BID" text COLLATE pg_catalog."default"
)

TABLESPACE pg_default;

ALTER TABLE public.quotes
    OWNER to postgres;

copy public.quotes  FROM 'D:\Dta\Data\quotes_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';