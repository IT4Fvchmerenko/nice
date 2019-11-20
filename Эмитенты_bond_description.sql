select public.listing."ID", public.listing."ISIN", public.listing."Platform", public.listing."Section" , public.bond_description."IssuerName",
	public.bond_description."IssuerName_NRD", public.bond_description."IssuerOKPO"
from public.listing 
LEFT JOIN public.bond_description
ON public.listing."ISIN" = public.bond_description."ISIN, RegCode, NRDCode"
;
