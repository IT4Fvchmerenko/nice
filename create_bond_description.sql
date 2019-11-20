-- Table: public.bond_description

-- DROP TABLE public.bond_description;

CREATE TABLE public.bond_description
(
    "ISIN, RegCode, NRDCode" text COLLATE pg_catalog."default" NOT NULL,
    "FinToolType" text COLLATE pg_catalog."default" NOT NULL,
    "SecurityType" text COLLATE pg_catalog."default",
    "SecurityKind" text COLLATE pg_catalog."default",
    "CouponType" text COLLATE pg_catalog."default",
    "RateTypeNameRus_NRD" text COLLATE pg_catalog."default",
    "CouponTypeName_NRD" text COLLATE pg_catalog."default",
    "HaveOffer" boolean NOT NULL,
    "AmortisedMty" boolean NOT NULL,
    "MaturityGroup" text COLLATE pg_catalog."default",
    "IsConvertible" boolean NOT NULL,
    "ISINCode" text COLLATE pg_catalog."default" NOT NULL,
    "Status" text COLLATE pg_catalog."default",
    "HaveDefault" boolean NOT NULL,
    "IsLombardCBR_NRD" boolean,
    "IsQualified_NRD" boolean,
    "ForMarketBonds_NRD" boolean,
    "MicexList_NRD" text COLLATE pg_catalog."default",
    "Basis" text COLLATE pg_catalog."default",
    "Basis_NRD" text COLLATE pg_catalog."default",
    "Base_Month" smallint NOT NULL,
    "Base_Year" smallint NOT NULL,
    "Coupon_Period_Base_ID" smallint,
    "AccruedintCalcType" boolean NOT NULL,
    "IsGuaranteed" boolean NOT NULL,
    "GuaranteeType" text COLLATE pg_catalog."default",
    "GuaranteeAmount" text COLLATE pg_catalog."default",
    "GuarantVal" bigint,
    "Securitization" text COLLATE pg_catalog."default",
    "CouponPerYear" smallint,
    "Cp_Type_ID" smallint,
    "NumCoupons" smallint,
    "NumCoupons_M" smallint NOT NULL,
    "NumCoupons_NRD" smallint,
    "Country" text COLLATE pg_catalog."default" NOT NULL,
    "FaceFTName" text COLLATE pg_catalog."default" NOT NULL,
    "FaceFTName_M" smallint NOT NULL,
    "FaceFTName_NRD" text COLLATE pg_catalog."default",
    "FaceValue" bigint NOT NULL,
    "FaceValue_M" smallint NOT NULL,
    "FaceValue_NRD" bigint,
    "CurrentFaceValue_NRD" bigint,
    "BorrowerName" text COLLATE pg_catalog."default" NOT NULL,
    "BorrowerOKPO" bigint,
    "BorrowerSector" text COLLATE pg_catalog."default",
    "BorrowerUID" integer NOT NULL,
    "IssuerName" text COLLATE pg_catalog."default" NOT NULL,
    "IssuerName_NRD" text COLLATE pg_catalog."default",
    "IssuerOKPO" bigint,
    "NumGuarantors" smallint NOT NULL,
    "EndMtyDate" date,
    CONSTRAINT bond_description_pkey PRIMARY KEY ("ISIN, RegCode, NRDCode")
)

TABLESPACE pg_default;

ALTER TABLE public.bond_description
    OWNER to postgres;

copy public.bond_description  FROM 'D:\Dta\Data\bond_description_task.csv' DELIMITER ';' CSV HEADER ENCODING 'WIN 1251';