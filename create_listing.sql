-- Table: public.listing

-- DROP TABLE public.listing;

CREATE TABLE public.listing
(
    "ID" integer NOT NULL,
    "ISIN" text COLLATE pg_catalog."default" NOT NULL,
    "Platform" text COLLATE pg_catalog."default" NOT NULL,
    "Section" text COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT listing_pkey PRIMARY KEY ("ID")
)

TABLESPACE pg_default;

ALTER TABLE public.listing
    OWNER to postgres;

copy public.listing  FROM 'D:\Dta\Data\listing_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';