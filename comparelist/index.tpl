{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    <h1>{lang key="compare" section="global"}</h1>
    
    {if !empty($cHinweis)}
        <p class="alert alert-success">{$cHinweis}</p>
    {/if}
    
    {include file="snippets/extension.tpl"}
    
    {if $oVergleichsliste->oArtikel_arr|@count >1}
        <div class="comparelist table-responsive">
            <table class="table table-striped table-bordered table-condensed table">
                <tr>
                    <td>&nbsp;</td>
                    {foreach name=vergleich from=$oVergleichsliste->oArtikel_arr item=oArtikel}
                        <td style="width:{$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px;" class="text-center">
                            <div class="thumbnail">
                                <a href="{$oArtikel->cURL}">
                                    {image src=$oArtikel->cVorschaubild alt=$oArtikel->cName class="image"}
                                </a>
                            </div>
                            <p>
                                <a href="{$oArtikel->cURL}">{$oArtikel->cName}</a>
                            </p>
    
                            {if $oArtikel->Preise->fVKNetto == 0 && $Einstellungen.global.global_preis0 === 'N'}
                                <p>{lang key="priceOnApplication" section="global"}</p>
                            {else}
                                <p>
                                    {if isset($oArtikel->Preise->strPreisGrafik_Detail)}
                                        {assign var=priceImage value=$oArtikel->Preise->strPreisGrafik_Detail}
                                    {else}
                                        {assign var=priceImage value=null}
                                    {/if}
                                    {include file="productdetails/price.tpl" Artikel=$oArtikel price_image=$priceImage tplscope="detail"}
                                </p>
                            {/if}
                            <p>
                                <a href="{$oArtikel->cURLDEL}" data-id="{$oArtikel->kArtikel}" class="remove pr">
                                                <span class="img-ct icon">
													<svg>
													  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
													</svg>
                                                </span> </a>
                            </p>
                        </td>
                    {/foreach}
                </tr>
                {foreach name=priospalten from=$cPrioSpalten_arr item=cPrioSpalten}
                    {if $cPrioSpalten !== 'Merkmale' && $cPrioSpalten !== 'Variationen'}
                        {if $smarty.foreach.priospalten.iteration % 2 == 0}
                            <tr class="first">
                                {else}
                            <tr class="last">
                        {/if}
                    {/if}
    
                    {if $cPrioSpalten === 'cArtNr' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_artikelnummer != 0}
                        <!-- Artikelnummer-->
                        <td valign="top">
                            <b>{lang key="productNumber" section="comparelist"}</b>
                        </td>
                    {/if}
                    {if $cPrioSpalten === 'cHersteller' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_hersteller != 0}
                        <!-- Hersteller -->
                        <td valign="top">
                            <b>{lang key="manufacturer" section="comparelist"}</b>
                        </td>
                    {/if}
                    {if $cPrioSpalten === 'cBeschreibung' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_beschreibung != 0}
                        <!-- Beschreibung -->
                        <td valign="top">
                            <div class="custom_content">
                                <b>{lang key="description" section="comparelist"}</b>
                            </div>
                        </td>
                    {/if}
                    {if $cPrioSpalten === 'cKurzBeschreibung' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_kurzbeschreibung != 0}
                        <!-- Kurzbeschreibung -->
                        <td valign="top">
                            <b>{lang key="shortDescription" section="comparelist"}</b>
                        </td>
                    {/if}
                    {if $cPrioSpalten === 'fArtikelgewicht' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_artikelgewicht != 0}
                        <!-- Artikelgewicht -->
                        <td valign="top">
                            <b>{lang key="productWeight" section="comparelist"}</b>
                        </td>
                    {/if}
                    {if $cPrioSpalten === 'fGewicht' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_versandgewicht != 0}
                        <!-- Versandgewicht -->
                        <td valign="top">
                            <b>{lang key="shippingWeight" section="comparelist"}</b>
                        </td>
                    {/if}
                    {if $cPrioSpalten !== 'Merkmale' && $cPrioSpalten !== 'Variationen'}
                        {foreach name=vergleich from=$oVergleichsliste->oArtikel_arr item=oArtikel}
                            {if $oArtikel->$cPrioSpalten !== ''}
                                <td valign="top" style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px">
                                    {if $cPrioSpalten === 'fArtikelgewicht' || $cPrioSpalten === 'fGewicht'}
                                        {$oArtikel->$cPrioSpalten} {lang key="weightUnit" section="comparelist"}
                                    {else}
                                        {$oArtikel->$cPrioSpalten}
                                    {/if}
                                </td>
                            {else}
                                <td>--</td>
                            {/if}
                        {/foreach}
                        </tr>
                    {/if}
    
                    {if $cPrioSpalten === 'Merkmale' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_merkmale != 0}
                        <!-- Merkmale -->
                        {foreach name=merkmale from=$oMerkmale_arr item=oMerkmale}
                            {if $smarty.foreach.merkmale.iteration % 2 == 0}
                                <tr class="first">
                                    {else}
                                <tr class="last">
                            {/if}
                            <td valign="top">
                                <b>{$oMerkmale->cName}</b>
                            </td>
                            {foreach name=vergleich from=$oVergleichsliste->oArtikel_arr item=oArtikel}
                                <td valign="top" style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px">
                                    {if count($oArtikel->oMerkmale_arr) > 0}
                                        {foreach name=merkmale from=$oArtikel->oMerkmale_arr item=oMerkmaleArtikel}
                                            {if $oMerkmale->cName == $oMerkmaleArtikel->cName}
                                                {foreach name=merkmalwerte from=$oMerkmaleArtikel->oMerkmalWert_arr item=oMerkmalWert}
                                                    {$oMerkmalWert->cWert}{if !$smarty.foreach.merkmalwerte.last}, {/if}
                                                {/foreach}
                                            {/if}
                                        {/foreach}
                                    {else}
                                        --
                                    {/if}
                                </td>
                            {/foreach}
                            </tr>
                        {/foreach}
                    {/if}
    
                    {if $cPrioSpalten === 'Variationen' && $Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_variationen != 0}
                        <!-- Variationen -->
                        {foreach name=variationen from=$oVariationen_arr item=oVariationen}
                            {if $smarty.foreach.variationen.iteration % 2 == 0}
                                <tr class="first">
                                    {else}
                                <tr class="last">
                            {/if}
                            <td valign="top">
                                <b>{$oVariationen->cName}</b>
                            </td>
                            {foreach name=vergleich from=$oVergleichsliste->oArtikel_arr item=oArtikel}
                                <td valign="top">
                                    {if isset($oArtikel->oVariationenNurKind_arr) && $oArtikel->oVariationenNurKind_arr|@count > 0}
                                        {foreach name=variationen from=$oArtikel->oVariationenNurKind_arr item=oVariationenArtikel}
                                            {if $oVariationen->cName == $oVariationenArtikel->cName}
                                                {foreach name=variationswerte from=$oVariationenArtikel->Werte item=oVariationsWerte}
                                                    {$oVariationsWerte->cName}
                                                    {if $oArtikel->nVariationOhneFreifeldAnzahl == 1 && ($oArtikel->kVaterArtikel > 0 || $oArtikel->nIstVater == 1)}
                                                        {assign var=kEigenschaftWert value=$oVariationsWerte->kEigenschaftWert}
                                                        ({$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->cVKLocalized[$NettoPreise]}{if !empty($oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise])}, {$oArtikel->oVariationDetailPreisKind_arr[$kEigenschaftWert]->Preise->PreisecPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                                    {/if}
                                                {/foreach}
                                            {/if}
                                        {/foreach}
                                    {elseif $oArtikel->Variationen|@count > 0}
                                        {foreach name=variationen from=$oArtikel->Variationen item=oVariationenArtikel}
                                            {if $oVariationen->cName == $oVariationenArtikel->cName}
                                                {foreach name=variationswerte from=$oVariationenArtikel->Werte item=oVariationsWerte}
                                                    {$oVariationsWerte->cName}
                                                    {if $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 1 && $oVariationsWerte->fAufpreisNetto != 0}
                                                        ({$oVariationsWerte->cAufpreisLocalized[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertAufpreis[$NettoPreise]}{/if})
                                                    {elseif $Einstellungen_Vergleichsliste.artikeldetails.artikel_variationspreisanzeige == 2 && $oVariationsWerte->fAufpreisNetto != 0}
                                                        ({$oVariationsWerte->cPreisInklAufpreis[$NettoPreise]}{if !empty($oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise])}, {$oVariationsWerte->cPreisVPEWertInklAufpreis[$NettoPreise]}{/if})
                                                    {/if}
                                                    {if !$smarty.foreach.variationswerte.last},{/if}
                                                {/foreach}
                                            {/if}
                                        {/foreach}
                                    {else}
                                        &nbsp;
                                    {/if}
                                </td>
                            {/foreach}
                            </tr>
                        {/foreach}
                    {/if}
                {/foreach}
                <tr>
                    {* to do: wait for update @FM
                                    <td valign="top">&nbsp;
                                        
                                    </td>
                                    {foreach name=vergleich from=$oVergleichsliste->oArtikel_arr item=oArtikel}
                                        <td class="text-center" style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesseattribut}px">
                                            <a href="{$oArtikel->cURLDEL}" class="btn btn-default">
                                                <span class="img-ct icon">
													<svg>
													  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-bin"></use>
													</svg>
                                                </span> 
                                            </a>
                                        </td>
                                    {/foreach}
                                </tr>
                    *}
                {if !empty($bWarenkorb)}
                    <tr>
                        <td style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesseattribut}px">&nbsp;
                            
                        </td>
                        {foreach name=vergleich from=$oVergleichsliste->oArtikel_arr item=oArtikel}
                            <td valign="top" class="text-center" style="min-width: {$Einstellungen_Vergleichsliste.vergleichsliste.vergleichsliste_spaltengroesse}px">
                                <!--
                              <form action="{get_static_route id='vergleichsliste.php'}" method="get">
                                 <input type="hidden" name="vlph" value="1" />
                                 <input type="hidden" name="a" value="{$oArtikel->kArtikel}" />
                                 <input type="submit" value="{lang key="addToCart" section="global"}" />
                              </form>
                                -->
                                <button class="btn btn-default submit" onclick="window.location.href = '{$oArtikel->cURL}'">{lang key="details" section="global"}</button>
                            </td>
                        {/foreach}
                    </tr>
                {/if}
            </table>
        </div>
    {else}
        {lang key="compareListNoItems" sektion="global"}
    {/if}
    
    {if !empty($cFehler)}
        <br>
        <div class="alert alert-danger">
            {$cFehler}
        </div>
    {/if}
    
    {if isset($bAjaxRequest) && $bAjaxRequest}
        <script type="text/javascript">
            $('.modal a.remove').click(function(e) {
                var kArtikel = $(e.currentTarget).data('id');
                $('section.box-compare tr[data-id="' + kArtikel + '"]').remove();
                eModal.ajax({
                    size: 'lg',
                    url: e.currentTarget.href,
                    title: '{lang key="compare" section="global"}',
                    keyboard: true,
                    tabindex: -1
                });
    
                return false;
            });
            new function(){
                var clCount = {if isset($oVergleichsliste->oArtikel_arr)}{$oVergleichsliste->oArtikel_arr|count}{else}0{/if};
                if (clCount > 1) {
                    $('.navbar-nav .compare-list-menu .badge em').html(clCount);
                    $('.navbar-nav .compare-list-menu').removeClass('hidden');
                    $('section.box-compare .panel-body').removeClass('hidden');
                } else {
                    if (clCount == 1) {
                        $('section.box-compare .panel-body').addClass('hidden');
                    } else {
                        $('section.box-compare').html('').addClass('hidden');
                    }
                    $('.navbar-nav .compare-list-menu').addClass('hidden');
                    eModal.close();
                }
            }();
        </script>
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}