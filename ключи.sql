ALTER TABLE public.listing
ADD CONSTRAINT listing_pkey PRIMARY KEY ("ISIN")
;

ALTER TABLE public.bond_description
ADD CONSTRAINT bond_description_fkey FOREIGN KEY ("ISIN, RegCode, NRDCode") REFERENCES public.listing ("ISIN")
;

ALTER TABLE public.quotes
ADD CONSTRAINT quotes_fkey FOREIGN KEY ("ISIN") REFERENCES public.listing ("ISIN")
;

-- Комментарий:
-- Неверно! bond_description должна быть материнской таблицей по отношению listing, т.к. одна и также облигация может торговаться на разных площадках и/или в разных секциях.
-- ISIN в двух таблицах не является уникальным полем. 