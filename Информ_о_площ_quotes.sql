select public.listing."ID", public.listing."ISIN", public.listing."Platform", public.listing."Section" , 
	   public.quotes."BOARDID", public.quotes."BOARDNAME"
from public.listing 
LEFT JOIN public.quotes
ON public.listing."ISIN" = public.quotes."ISIN"
;


