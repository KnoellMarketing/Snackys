{strip}
    {if !isset($hideVariationValue) || !$hideVariationValue}
        <span class="label-variation">{$Variationswert->cName}</span>
    {/if}
{* variationskombination *}
{if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
    {if $Artikel->nVariationOhneFreifeldAnzahl == 1}
        {assign var=kEigenschaftWert value=$Variationswert->kEigenschaftWert}
        {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1}
            {if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cAufpreisLocalized[$NettoPreise])}
                <span class="label label-info label-surcharge">{$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cAufpreisLocalized[$NettoPreise]}
                {if !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}
                    , {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}
                {/if}
                </span>
            {/if}
        {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2}
            <span class="label label-info label-surcharge">{$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}
            {if !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}
                , {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}
            {/if}
            </span>
        {/if}
    {/if}
{/if}
{* einfache kombination oder variationskombination mit mindestens 2 nicht-freifeld positionen *}
{if ($Artikel->kVaterArtikel == 0 && $Artikel->nIstVater == 0) && isset($Variationswert->fAufpreisNetto)}
    {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $Variationswert->fAufpreisNetto!=0}
        <span class="label label-info label-surcharge">{$Variationswert->cAufpreisLocalized[$NettoPreise]}</span>
    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $Variationswert->fAufpreisNetto!=0}
        <span class="label label-info label-surcharge">{$Variationswert->cPreisInklAufpreis[$NettoPreise]}</span>
    {/if}
{/if}
{* variationskombination mit mindestens 2 nicht-freifeld positionen *}
{if ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1) && $Artikel->nVariationOhneFreifeldAnzahl > 1 && isset($Variationswert->fAufpreisNetto)}
    {if $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $Variationswert->fAufpreisNetto!=0}
        <span class="label label-info label-surcharge">{$Variationswert->cAufpreisLocalized[$NettoPreise]}
        {if !empty($Variationswert->cPreisVPEWertAufpreis[$NettoPreise]) && $Artikel->nVariationOhneFreifeldAnzahl == 1}
            ({$Variationswert->cPreisVPEWertAufpreis[$NettoPreise]})
        {/if}
        </span>
    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $Variationswert->fAufpreisNetto!=0}
        <span class="label label-info label-surcharge">{$Variationswert->cPreisInklAufpreis[$NettoPreise]}
        {if !empty($Variationswert->cPreisVPEWertInklAufpreis[$NettoPreise]) && $Artikel->nVariationOhneFreifeldAnzahl == 1}
            ({$Variationswert->cPreisVPEWertInklAufpreis[$NettoPreise]})
        {/if}
        </span>
    {/if}
{/if}
{/strip}