{strip}
{* variationskombination *}
{if $Variationswert->fAufpreisNetto!=0}
	{$Variationswert->fAufpreis[$NettoPreise]}
{elseif ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
    {if $Artikel->nVariationOhneFreifeldAnzahl == 1}
        {assign var=kEigenschaftWert value=$Variationswert->kEigenschaftWert}
		{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->fAufpreis[$NettoPreise])}
			{$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->fAufpreis[$NettoPreise]}
		{/if}
    {/if}
{/if}
{/strip}