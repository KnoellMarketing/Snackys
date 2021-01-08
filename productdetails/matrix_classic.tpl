{capture name="outofstock" assign="outofstockInfo"}<span class="delivery-status"><small class="status-0">{lang key="soldout" section="global"}</small></span>{/capture}
<div class="table-responsive">
    <table class="table table-striped variation-matrix">
        {* ****** 2-dimensional ****** *}
        {if $Artikel->VariationenOhneFreifeld|@count == 2}
            <thead>
            <tr>
                <td>&nbsp;</td>
                {foreach name="variationsboxHead" from=$Artikel->VariationenOhneFreifeld[0]->Werte item=oVariationWertHead}
                    <td class="vcenter">
                        {if $Artikel->oVariBoxMatrixBild_arr|@count > 0 && (($Artikel->nIstVater == 1 && $Artikel->oVariBoxMatrixBild_arr[0]->nRichtung == 0) || $Artikel->nIstVater == 0)}
                            {foreach name="vorschaubild" from=$Artikel->oVariBoxMatrixBild_arr item=oVariBoxMatrixBild}
                                {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                    <img src="{$oVariBoxMatrixBild->cBild}" class="img-responsive" alt=""><br>
                                {/if}
                            {/foreach}
                        {/if}
                        <strong>{$oVariationWertHead->cName}</strong>
                    </td>
                {/foreach}
            </tr>
            </thead>
            <tbody>
            {assign var=pushed value=0}
            {if isset($Artikel->VariationenOhneFreifeld[1]->Werte)}
                {foreach name="variationsbox1" from=$Artikel->VariationenOhneFreifeld[1]->Werte item=oVariationWert1}
                    {assign var=kEigenschaftWert1 value=$oVariationWert1->kEigenschaftWert}
                    <tr>
                        <td class="vcenter">
                            {if $Artikel->oVariBoxMatrixBild_arr|@count > 0 && (($Artikel->nIstVater == 1 && $Artikel->oVariBoxMatrixBild_arr[0]->nRichtung == 1) || $Artikel->nIstVater == 0)}
                                {foreach name="vorschaubild" from=$Artikel->oVariBoxMatrixBild_arr item=oVariBoxMatrixBild}
                                    {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWert1->kEigenschaftWert}
                                        <img src="{$oVariBoxMatrixBild->cBild}" alt=""><br>
                                    {/if}
                                {/foreach}
                            {/if}
                            <strong>{$oVariationWert1->cName}</strong>
                        </td>
                        {foreach name="variationsbox0" from=$Artikel->VariationenOhneFreifeld[0]->Werte item=oVariationWert0}
                            {assign var=bAusblenden value=false}
                                {assign var=cVariBox value=$oVariationWert0->kEigenschaft|cat:':'|cat:$oVariationWert0->kEigenschaftWert|cat:'_'|cat:$oVariationWert1->kEigenschaft|cat:':'|cat:$oVariationWert1->kEigenschaftWert}
                                {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                    {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
								{elseif $Artikel->nIstVater}
									{assign var=bAusblenden value=true}
                                {/if}
								{if !$bAusblenden}
                                <td class="vcenter">
                                    {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N' && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <small>
                                            {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                        </small>
                                    {elseif isset($child->nNichtLieferbar) && $child->nNichtLieferbar == 1}
                                        {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <small>
                                                {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        {else}
                                            {$outofstockInfo}
                                        {/if}
                                    {elseif (isset($child->bHasKonfig) && $child->bHasKonfig == true) || (isset($child->nVariationAnzahl) && isset($child->nVariationOhneFreifeldAnzahl) && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                        <div class="center-sm">
                                            <a class="btn btn-default configurepos" href="{$child->cSeo}"><span class="hidden-xs"> {lang key="configure" section="global"}</span></a>
                                        </div>
                                        {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <div>
                                                <small>
                                                    {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            </div>
                                        {/if}
                                        <div class="delivery-status">
                                            <small>
                                                {if !isset($child->nErscheinendesProdukt) || !$child->nErscheinendesProdukt}
                                                    {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && (isset($child->cLagerBeachten) && $child->cLagerBeachten === 'Y') &&
                                                    ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U') &&
                                                    $child->fLagerbestand <= 0 && $child->fZulauf > 0 && isset($child->dZulaufDatum_de)}
                                                        {assign var=cZulauf value=$child->fZulauf|cat:':::'|cat:$child->dZulaufDatum_de}
                                                        <span class="status status-1"> {lang key="productInflowing" section="productDetails" printf=$cZulauf}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N' && $child->cLagerBeachten === 'Y' &&
                                                    $child->fLagerbestand <= 0 && $child->fLieferantenlagerbestand > 0 && $child->fLieferzeit > 0 &&
                                                    ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                                        <span class="status status-1"> {lang key="supplierStockNotice" section="global" printf=$child->fLieferzeit}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau'}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel'}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                    {include file="productdetails/warehouse.tpl" tplscope="detail"}
                                                {else}
                                                    {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                {/if}
                                            </small>
                                        </div>
                                    {else}
                                        <div class="input-group{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError)} has-error{/if}">
                                            <input
                                                size="3" placeholder="0" 
                                                class="form-control text-right{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError)} error{/if}"
                                                name="variBoxAnzahl[{$oVariationWert1->kEigenschaft}:{$oVariationWert1->kEigenschaftWert}_{$oVariationWert0->kEigenschaft}:{$oVariationWert0->kEigenschaftWert}]"
                                                type="text"
                                                value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}">
                                            {if $Artikel->nIstVater == 1}
                                                {if isset($child->Preise->cVKLocalized[$NettoPreise]) && $child->Preise->cVKLocalized[$NettoPreise] > 0}
                                                    <span class="input-group-addon">
                                                        &times; {$child->Preise->cVKLocalized[$NettoPreise]}{if !empty($child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                    </span>
                                                {elseif isset($child->Preise->cVKLocalized[$NettoPreise]) && $child->Preise->cVKLocalized[$NettoPreise]}
                                                    {assign var=cVariBox value=$oVariationWert1->kEigenschaft|cat:':'|cat:$oVariationWert1->kEigenschaftWert|cat:'_'|cat:$oVariationWert0->kEigenschaft|cat:':'|cat:$oVariationWert0->kEigenschaftWert}
                                                    <span class="input-group-addon">
                                                        &times; {$child->Preise->cVKLocalized[$NettoPreise]}{if !empty($child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$child->Preise->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                                    </span>
                                                {/if}
                                            {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && ($oVariationWert0->fAufpreisNetto != 0 || $oVariationWert1->fAufpreisNetto != 0)}
                                                {if !isset($oVariationWert1->fAufpreis[1])}
                                                    {assign var=ovw1 value=0}
                                                {else}
                                                    {assign var=ovw1 value=$oVariationWert1->fAufpreis[1]}
                                                {/if}
                                                {if !isset($oVariationWert0->fAufpreis[1])}
                                                    {assign var=ovw0 value=0}
                                                {else}
                                                    {assign var=ovw0 value=$oVariationWert0->fAufpreis[1]}
                                                {/if}
    
                                                {math equation='x+y' x=$ovw0 y=$ovw1 assign='fAufpreis'}
                                                <span class="input-group-addon">
                                                    {gibPreisStringLocalizedSmarty bAufpreise=true fAufpreisNetto=$fAufpreis fVKNetto=$Artikel->Preise->fVKNetto kSteuerklasse=$Artikel->kSteuerklasse nNettoPreise=$NettoPreise fVPEWert=$Artikel->fVPEWert cVPEEinheit=$Artikel->cVPEEinheit FunktionsAttribute=$Artikel->FunktionsAttribute}
                                                </span>
                                            {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && ($oVariationWert0->fAufpreisNetto != 0 || $oVariationWert1->fAufpreisNetto != 0)}
                                                {if !isset($oVariationWert1->fAufpreis[1])}
                                                    {assign var=ovw1 value=0}
                                                {else}
                                                    {assign var=ovw1 value=$oVariationWert1->fAufpreis[1]}
                                                {/if}
                                                {if !isset($oVariationWert0->fAufpreis[1])}
                                                    {assign var=ovw0 value=0}
                                                {else}
                                                    {assign var=ovw0 value=$oVariationWert0->fAufpreis[1]}
                                                {/if}

                                                {math equation='x+y' x=$ovw0 y=$ovw1 assign='fAufpreis'}
                                                <span class="input-group-addon">
                                                    &times; {gibPreisStringLocalizedSmarty bAufpreise=false fAufpreisNetto=$fAufpreis fVKNetto=$Artikel->Preise->fVKNetto kSteuerklasse=$Artikel->kSteuerklasse nNettoPreise=$NettoPreise fVPEWert=$Artikel->fVPEWert cVPEEinheit=$Artikel->cVPEEinheit FunktionsAttribute=$Artikel->FunktionsAttribute}
                                                </span>
                                            {/if}
                                        </div>
                                        {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                            <div>
                                                <small>
                                                    {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                                </small>
                                            </div>
                                        {/if}
                                        <div class="delivery-status">
                                            <small>
                                                {if $Artikel->nIstVater == 1}
                                                    {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                        {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $child->cLagerBeachten === 'Y' &&
                                                        ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U') &&
                                                        $child->fLagerbestand <= 0 && $child->fZulauf > 0 && isset($child->dZulaufDatum_de)}
                                                            {assign var=cZulauf value=$child->fZulauf|cat:':::'|cat:$child->dZulaufDatum_de}
                                                            <span class="status status-1"> {lang key="productInflowing" section="productDetails" printf=$cZulauf}</span>
                                                        {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N' && $child->cLagerBeachten === 'Y' &&
                                                        $child->fLagerbestand <= 0 && $child->fLieferantenlagerbestand > 0 && $child->fLieferzeit > 0 &&
                                                        ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                                            <span class="status status-1"> {lang key="supplierStockNotice" section="global" printf=$child->fLieferzeit}</span>
                                                        {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau'}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                        {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel'}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                        {/if}
                                                        {include file="productdetails/warehouse.tpl" tplscope="detail"}
                                                    {else}
                                                        {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                        {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                            <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                        {/if}
                                                    {/if}
                                                {/if}
                                            </small>
                                        </div>
{*
                                        {if isset($child->Lageranzeige->AmpelText)}
                                            <span class="delivery-status"><small class="status-{$child->Lageranzeige->nStatus}">{$child->Lageranzeige->AmpelText}</small></span>
                                        {/if}
*}
                                    {/if}
                                </td>
                            {else}
                                <td class="not-available">&nbsp;</td>
                            {/if}
                        {/foreach}
                    </tr>
                {/foreach}
            {/if}
        </tbody>
        {else}{* ****** 1-dimensional ****** *}
            {if $Einstellungen.artikeldetails.artikeldetails_warenkorbmatrix_anzeigeformat === 'Q' && $Artikel->VariationenOhneFreifeld[0]->Werte|count <= 10}
                {* QUERFORMAT *}
                <thead>
                <tr>
                    {foreach name="variationsboxHead" from=$Artikel->VariationenOhneFreifeld[0]->Werte item=oVariationWertHead}
                        {if $Einstellungen.global.artikeldetails_variationswertlager != 3 || (!isset($oVariationWertHead->nNichtLieferbar) || $oVariationWertHead->nNichtLieferbar != 1)}
                            {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                            <td class="vcenter" style="width: {100/$Artikel->VariationenOhneFreifeld[0]->Werte|count}%;">
                                {if $Artikel->oVariBoxMatrixBild_arr|@count > 0}
                                    {foreach name="vorschaubild" from=$Artikel->oVariBoxMatrixBild_arr item=oVariBoxMatrixBild}
                                        {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                            <img src="{$oVariBoxMatrixBild->cBild}" alt=""><br>
                                        {/if}
                                    {/foreach}
                                {/if}
                                <strong>{$oVariationWertHead->cName}</strong>
                            </td>
                        {/if}
                    {/foreach}
                </tr>
                <thead>
                <tbody>
                <tr>
                    {foreach name="variationsboxHead" from=$Artikel->VariationenOhneFreifeld[0]->Werte item=oVariationWertHead}
                        {if $Einstellungen.global.artikeldetails_variationswertlager != 3 || !isset($oVariationWertHead->nNichtLieferbar) || $oVariationWertHead->nNichtLieferbar != 1}
                            {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                            {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                                {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                            {/if}
                            <td class="vcenter">
                                {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N' && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                    <small>
                                        {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                    </small>
                                {elseif isset($oVariationWertHead->nNichtLieferbar) && $oVariationWertHead->nNichtLieferbar == 1}
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <small>
                                            {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                        </small>
                                    {else}
                                        {$outofstockInfo}
                                    {/if}
                                {elseif (isset($child->bHasKonfig) && $child->bHasKonfig == true) || (isset($child->nVariationAnzahl) && isset($child->nVariationOhneFreifeldAnzahl) && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                    <div class="center-sm">
                                        <a class="btn btn-default configurepos" href="{$child->cSeo}"><span class="hidden-xs"> {lang key="configure" section="global"}</span></a>
                                    </div>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status">
                                        <small>
                                            {if !$child->nErscheinendesProdukt}
                                                {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $child->cLagerBeachten === 'Y' &&
                                                ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U') &&
                                                $child->fLagerbestand <= 0 && $child->fZulauf > 0 && isset($child->dZulaufDatum_de)}
                                                    {assign var=cZulauf value=$child->fZulauf|cat:':::'|cat:$child->dZulaufDatum_de}
                                                    <span class="status status-1"> {lang key="productInflowing" section="productDetails" printf=$cZulauf}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N' && $child->cLagerBeachten === 'Y' &&
                                                $child->fLagerbestand <= 0 && $child->fLieferantenlagerbestand > 0 && $child->fLieferzeit > 0 &&
                                                ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                                    <span class="status status-1"> {lang key="supplierStockNotice" section="global" printf=$child->fLieferzeit}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau'}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel'}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                {/if}
                                                {include file="productdetails/warehouse.tpl" tplscope="detail"}
                                            {else}
                                                {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {else}
                                    <div class="input-group{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} has-error{/if}">
                                        <input class="form-control text-right" placeholder="0" 
                                            name="variBoxAnzahl[_{$oVariationWertHead->kEigenschaft}:{$oVariationWertHead->kEigenschaftWert}]"
                                            type="text"
                                            value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}"{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} style="background-color: red;"{/if} />
                                        {if $Artikel->nVariationAnzahl == 1 && ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
                                            {assign var=kEigenschaftWert value=$oVariationWertHead->kEigenschaftWert}
                                            <span class="input-group-addon">&times; {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]) && !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}){/if}</small></span>
                                        {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationWertHead->fAufpreisNetto != 0}
                                            <span class="input-group-addon">{$oVariationWertHead->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise]})</small>{/if}</span>
                                        {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationWertHead->fAufpreisNetto != 0}
                                            <span class="input-group-addon">&times; {$oVariationWertHead->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}</span>
                                        {/if}
                                    </div>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status">
                                        <small>
                                            {if $Artikel->nIstVater == 1}
                                                {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                    {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $child->cLagerBeachten === 'Y' &&
                                                    ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U') &&
                                                    $child->fLagerbestand <= 0 && $child->fZulauf > 0 && isset($child->dZulaufDatum_de)}
                                                        {assign var=cZulauf value=$child->fZulauf|cat:':::'|cat:$child->dZulaufDatum_de}
                                                        <span class="status status-1"> {lang key="productInflowing" section="productDetails" printf=$cZulauf}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N' && $child->cLagerBeachten === 'Y' &&
                                                    $child->fLagerbestand <= 0 && $child->fLieferantenlagerbestand > 0 && $child->fLieferzeit > 0 &&
                                                    ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                                        <span class="status status-1"> {lang key="supplierStockNotice" section="global" printf=$child->fLieferzeit}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau'}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel'}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                    {include file="productdetails/warehouse.tpl" tplscope="detail"}
                                                {else}
                                                    {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {/if}
                            </td>
                        {/if}
                    {/foreach}
                </tr>
                </tbody>
            {else}
                {* HOCHFORMAT *}
                <tbody>
                {foreach name="variationsboxHead" from=$Artikel->VariationenOhneFreifeld[0]->Werte item=oVariationWertHead}
                    {if $Einstellungen.global.artikeldetails_variationswertlager != 3 || (!isset($oVariationWertHead->nNichtLieferbar) || $oVariationWertHead->nNichtLieferbar != 1)}
                        {assign var=cVariBox value=$oVariationWertHead->kEigenschaft|cat:':'|cat:$oVariationWertHead->kEigenschaftWert}
                        {if isset($Artikel->oVariationKombiKinderAssoc_arr[$cVariBox])}
                            {assign var=child value=$Artikel->oVariationKombiKinderAssoc_arr[$cVariBox]}
                        {/if}
                        <tr>
                            <td class="vcenter img-row">
                                {if $Artikel->oVariBoxMatrixBild_arr|@count > 0}
                                    {foreach name="vorschaubild" from=$Artikel->oVariBoxMatrixBild_arr item=oVariBoxMatrixBild}
                                        {if $oVariBoxMatrixBild->kEigenschaftWert == $oVariationWertHead->kEigenschaftWert}
                                            	<img src="{$oVariBoxMatrixBild->cBild}" alt="">
                                        {/if}
                                    {/foreach}
                                {/if}
                                <strong> {$oVariationWertHead->cName}</strong>
                            </td>
                            <td class="test">
                                {if $Einstellungen.global.global_erscheinende_kaeuflich === 'N' && isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                    <small>
                                        {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                    </small>
                                {elseif isset($oVariationWertHead->nNichtLieferbar) && $oVariationWertHead->nNichtLieferbar == 1}
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <small>
                                            {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                        </small>
                                    {else}
                                        {$outofstockInfo}
                                    {/if}
                                {elseif (isset($child->bHasKonfig) && $child->bHasKonfig == true) || (isset($child->nVariationAnzahl) && isset($child->nVariationOhneFreifeldAnzahl) && $child->nVariationAnzahl > $child->nVariationOhneFreifeldAnzahl)}
                                    <a class="btn btn-default configurepos" href="{$child->cSeo}"><span class="hidden-xs"> {lang key="configure" section="global"}</span></a>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status">
                                        <small>
                                            {if !$child->nErscheinendesProdukt}
                                                {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $child->cLagerBeachten === 'Y' &&
                                                ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U') &&
                                                $child->fLagerbestand <= 0 && $child->fZulauf > 0 && isset($child->dZulaufDatum_de)}
                                                    {assign var=cZulauf value=$child->fZulauf|cat:':::'|cat:$child->dZulaufDatum_de}
                                                    <span class="status status-1"> {lang key="productInflowing" section="productDetails" printf=$cZulauf}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N' && $child->cLagerBeachten === 'Y' &&
                                                $child->fLagerbestand <= 0 && $child->fLieferantenlagerbestand > 0 && $child->fLieferzeit > 0 &&
                                                ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                                    <span class="status status-1"> {lang key="supplierStockNotice" section="global" printf=$child->fLieferzeit}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau'}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel'}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                {/if}
                                                {include file="productdetails/warehouse.tpl" tplscope="detail"}
                                            {else}
                                                {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau' && ($child->fLagerbestand > 0 || $child->cLagerKleinerNull === 'Y')}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                    <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {else}
                                    <div class="input-line {if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->bError) && $smarty.session.variBoxAnzahl_arr[$cVariBox]->bError} has-error{/if}">
                                        <input
                                            class="form-control text-right" placeholder="0" 
                                            name="variBoxAnzahl[_{$oVariationWertHead->kEigenschaft}:{$oVariationWertHead->kEigenschaftWert}]"
                                            type="text" value="{if isset($smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl)}{$smarty.session.variBoxAnzahl_arr[$cVariBox]->fAnzahl|replace_delim}{/if}">
                                    {if $Artikel->nVariationAnzahl == 1 && ($Artikel->kVaterArtikel > 0 || $Artikel->nIstVater == 1)}
                                        {assign var=kEigenschaftWert value=$oVariationWertHead->kEigenschaftWert}
                                        <span class="input-group-addon">
                                            &times; {$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if isset($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]) && !empty($Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$Artikel->oVariationDetailPreis_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                        </span>
                                    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationWertHead->fAufpreisNetto!=0}
                                        <span class="input-group-addon">
                                            {$oVariationWertHead->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertAufpreis[$NettoPreise]})</small>{/if}
                                        </span>
                                    {elseif $Einstellungen.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationWertHead->fAufpreisNetto!=0}
                                        <span class="input-group-addon">
                                            &times; {$oVariationWertHead->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise])} <small>({$oVariationWertHead->cPreisVPEWertInklAufpreis[$NettoPreise]})</small>{/if}
                                        </span>
                                    {/if}
                                    </div>
                                    {if isset($child->nErscheinendesProdukt) && $child->nErscheinendesProdukt == 1}
                                        <div>
                                            <small>
                                                {lang key="productAvailableFrom" section="global"}: <strong>{$child->Erscheinungsdatum_de}</strong>
                                            </small>
                                        </div>
                                    {/if}
                                    <div class="delivery-status">
                                        <small>
                                            {if $Artikel->nIstVater == 1}
                                                {if isset($child->nErscheinendesProdukt) && !$child->nErscheinendesProdukt}
                                                    {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $child->cLagerBeachten === 'Y' &&
                                                    ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U') &&
                                                    $child->fLagerbestand <= 0 && $child->fZulauf > 0 && isset($child->dZulaufDatum_de)}
                                                        {assign var=cZulauf value=$child->fZulauf|cat:':::'|cat:$child->dZulaufDatum_de}
                                                        <span class="status status-1"> {lang key="productInflowing" section="productDetails" printf=$cZulauf}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige !== 'nichts' && $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen !== 'N' && $child->cLagerBeachten === 'Y' &&
                                                    $child->fLagerbestand <= 0 && $child->fLieferantenlagerbestand > 0 && $child->fLieferzeit > 0 &&
                                                    ($child->cLagerKleinerNull === 'N' || $Einstellungen.artikeldetails.artikeldetails_lieferantenbestand_anzeigen === 'U')}
                                                        <span class="status status-1"> {lang key="supplierStockNotice" section="global" printf=$child->fLieferzeit}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau'}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel'}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                    {include file="productdetails/warehouse.tpl" tplscope="detail"}
                                                {else}
                                                    {if $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'verfuegbarkeit' || $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'genau' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->cLagerhinweis[$Einstellungen.artikeldetails.artikel_lagerbestandsanzeige]}</span>
                                                    {elseif $Einstellungen.artikeldetails.artikel_lagerbestandsanzeige === 'ampel' && ((isset($child->fLagerbestand) && $child->fLagerbestand > 0) || (isset($child->cLagerKleinerNull) && $child->cLagerKleinerNull === 'Y'))}
                                                        <span class="status status-{$child->Lageranzeige->nStatus}"> {$child->Lageranzeige->AmpelText}</span>
                                                    {/if}
                                                {/if}
                                            {/if}
                                        </small>
                                    </div>
                                {/if}
                            </td>
                        </tr>
                    {/if}
                {/foreach}
                </tbody>    
            {/if}
        {/if}
    </table>
</div>
<input type="hidden" name="variBox" value="1" />
<button name="inWarenkorb" type="submit" value="{lang key="addToCart" section="global"}" class="sn-addBasket submit btn btn-primary">{lang key="addToCart" section="global"}</button>