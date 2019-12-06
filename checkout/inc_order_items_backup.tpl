<input type="submit" name="fake" class="hidden">

<table class="table table-striped order-items layout-fixed hyphens">
    <thead>
        <tr class="row">
            {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                <th class="col-sm-2"></th>
            {/if}
            <th class="{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'
                            && $tplscope === 'cart'}col-xs-6 col-sm-3
                        {elseif $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'
                            && $tplscope !== 'cart'}col-xs-8 col-sm-5
                        {elseif ($Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'N'
                            || $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y')
                            && $tplscope === 'cart'}col-xs-6 col-sm-5
                        {elseif ($Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'N'
                            || $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y')
                            && $tplscope !== 'cart'}col-xs-8 col-sm-7
                        {elseif $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'N'
                            && $tplscope === 'cart'}col-xs-6 col-sm-7
                        {else}col-xs-8 col-sm-9{/if}">{lang key="product" section="global"}</th>
            <th class="{if $tplscope === "cart"}col-xs-2{else}col-xs-2 col-sm-1{/if}">
                {lang key="quantity" section="global"}
            </th>
            {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                <th class="hidden-xs col-sm-2 text-right">{lang key="pricePerUnit" section="productDetails"}</th>
            {/if}
            <th class="col-xs-2 text-right">{lang key="price" section="global"}</th>
            {if $tplscope === 'cart'}
                <th class="col-xs-2 col-sm-1 delitem-col"></th>
            {/if}
        </tr>
    </thead>
    <tbody>
    {foreach name=positionen from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
        {if !$oPosition->istKonfigKind()}
            <tr class="type-{$oPosition->nPosTyp}">
                {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y' && !empty($oPosition->Artikel->cVorschaubild)}
                    <td class="col-sm-2 img-col hidden-xs text-center vcenter">
                        <a href="{$oPosition->Artikel->cURL}" title="{$oPosition->cName|trans}">
                            <img src="{$oPosition->Artikel->cVorschaubild}" alt="{$oPosition->cName|trans}" class="img-responsive-width" />
                        </a>
                    </td>
                {elseif $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                    <td class="col-sm-2 hidden-xs"></td>
                {/if}
                <td class="{if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'
                            && $tplscope === 'cart'}col-xs-6 col-sm-3
                        {elseif $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'
                            && $tplscope !== 'cart'}col-xs-8 col-sm-5
                        {elseif ($Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'N'
                            || $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y')
                            && $tplscope === 'cart'}col-xs-6 col-sm-5
                        {elseif ($Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'N'
                            || $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y')
                            && $tplscope !== 'cart'}col-xs-8 col-sm-7
                        {elseif $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'N'
                            && $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'N'
                            && $tplscope === 'cart'}col-xs-6 col-sm-7
                        {else}col-xs-8 col-sm-9{/if}">
                    {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                        <a href="{$oPosition->Artikel->cURL}" title="{$oPosition->cName|trans}">{$oPosition->cName|trans}</a>
                        <ul class="list-unstyled text-muted small">
                            <li class="sku"><strong>{lang key="productNo" section="global"}:</strong> {$oPosition->Artikel->cArtNr}</li>
                            {if isset($oPosition->Artikel->dMHD) && isset($oPosition->Artikel->dMHD_de) && $oPosition->Artikel->dMHD_de !== null}
                                <li title="{lang key='productMHDTool' section='global'}" class="best-before">
                                    <strong>{lang key="productMHD" section="global"}:</strong> {$oPosition->Artikel->dMHD_de}
                                </li>
                            {/if}
                            {if $oPosition->Artikel->cLocalizedVPE && $oPosition->Artikel->cVPE !== 'N'}
                                <li class="baseprice"><strong>{lang key="basePrice" section="global"}:</strong> {$oPosition->Artikel->cLocalizedVPE[$NettoPreise]}</li>
                            {/if}
                            {if $Einstellungen.kaufabwicklung.warenkorb_varianten_varikombi_anzeigen === 'Y' && isset($oPosition->WarenkorbPosEigenschaftArr) && !empty($oPosition->WarenkorbPosEigenschaftArr)}
                                {foreach name=variationen from=$oPosition->WarenkorbPosEigenschaftArr item=Variation}
                                    <li class="variation">
                                        <strong>{$Variation->cEigenschaftName|trans}:</strong> {$Variation->cEigenschaftWertName|trans}
                                    </li>
                                {/foreach}
                            {/if}
                            {if $Einstellungen.kaufabwicklung.bestellvorgang_lieferstatus_anzeigen === 'Y' && $oPosition->cLieferstatus|trans}
                                <li class="delivery-status"><strong>{lang key="deliveryStatus" section="global"}:</strong> {$oPosition->cLieferstatus|trans}</li>
                            {/if}
                            {if !empty($oPosition->cHinweis)}
                                <li class="text-info notice">{$oPosition->cHinweis}</li>
                            {/if}

                            {* Buttonloesung eindeutige Merkmale *}
                            {if $oPosition->Artikel->cHersteller && $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen != "N"}
                                 <li class="manufacturer">
                                    <strong>{lang key="manufacturer" section="productDetails"}</strong>:
                                    <span class="values">
                                       {$oPosition->Artikel->cHersteller}
                                    </span>
                                 </li>
                            {/if}

                            {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelmerkmale == 'Y' && !empty($oPosition->Artikel->oMerkmale_arr)}
                                {foreach from=$oPosition->Artikel->oMerkmale_arr item="oMerkmale_arr"}
                                    <li class="characteristic">
                                        <strong>{$oMerkmale_arr->cName}</strong>:
                                        <span class="values">
                                            {foreach name="merkmalwerte" from=$oMerkmale_arr->oMerkmalWert_arr item="oWert"}
                                                {if !$smarty.foreach.merkmalwerte.first}, {/if}
                                                {$oWert->cWert}
                                            {/foreach}
                                        </span>
                                    </li>
                                {/foreach}
                            {/if}

                            {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelattribute == 'Y' && !empty($oPosition->Artikel->Attribute)}
                                {foreach from=$oPosition->Artikel->Attribute item="oAttribute_arr"}
                                    <li class="attribute">
                                        <strong>{$oAttribute_arr->cName}</strong>:
                                        <span class="values">
                                            {$oAttribute_arr->cWert}
                                        </span>
                                    </li>
                                {/foreach}
                            {/if}

                            {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                <li class="shortdescription">{$oPosition->Artikel->cKurzBeschreibung}</li>
                            {/if}

                            {if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
                                <li class="weight">
                                    <strong>{lang key="shippingWeight" section="global"}: </strong>
                                    <span class="value">{$oPosition->Artikel->cGewicht} {lang key="weightUnit" section="global"}</span>
                                </li>
                            {/if}
                        </ul>
                    {else}
                        {$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}
                        {if isset($oPosition->cArticleNameAffix)}
                            {if is_array($oPosition->cArticleNameAffix)}
                                <ul class="small text-muted">
                                    {foreach from=$oPosition->cArticleNameAffix item="cArticleNameAffix"}
                                        <li>{$cArticleNameAffix|trans}</li>
                                    {/foreach}
                                </ul>
                            {else}
                                <ul class="small text-muted">
                                    <li>{$oPosition->cArticleNameAffix|trans}</li>
                                </ul>
                            {/if}
                        {/if}
                        {if !empty($oPosition->cHinweis)}
                            <small class="text-info notice">{$oPosition->cHinweis}</small>
                        {/if}
                    {/if}

                    {if $oPosition->istKonfigVater()}
                        <ul class="config-items text-muted small">
                            {foreach from=$smarty.session.Warenkorb->PositionenArr item=KonfigPos name=konfigposition}
                                {if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
                                    && !$KonfigPos->isIgnoreMultiplier()}
                                    <li>
                                        <span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                                        {$KonfigPos->cName|trans} &raquo;
                                        <span class="price_value">
                                            {$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                            {lang key="pricePerUnit" section="checkout"}
                                        </span>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                        <ul class="config-items text-muted small">
                            <strong>{lang key="one-off" section="checkout"}</strong>
                            {foreach from=$smarty.session.Warenkorb->PositionenArr item=KonfigPos name=konfigposition}
                                {if $oPosition->cUnique == $KonfigPos->cUnique && $KonfigPos->kKonfigitem > 0
                                    && $KonfigPos->isIgnoreMultiplier()}
                                    <li>
                                        <span class="qty">{if !$KonfigPos->istKonfigVater()}{$KonfigPos->nAnzahlEinzel}{else}1{/if}x</span>
                                        {$KonfigPos->cName|trans} &raquo;
                                        <span class="price_value">
                                            {$KonfigPos->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                            {lang key="pricePerUnit" section="checkout"}
                                        </span>
                                    </li>
                                {/if}
                            {/foreach}
                        </ul>
                    {/if}
                </td>

                <td class="{if $tplscope === "cart"}col-xs-2{else}col-xs-2 col-sm-1{/if} qty-col">
                    {if $tplscope === 'cart'}
                        {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                            {if !isset($Einstellungen.template.theme.qty_modify_dropdown) || $Einstellungen.template.theme.qty_modify_dropdown === 'Y'}
                                {if $oPosition->istKonfigVater()}
                                    <div class="qty-wrapper dropdown modify">
                                        {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                                        <input name="anzahl[{$smarty.foreach.positionen.index}]" type="hidden" class="form-control" value="{$oPosition->nAnzahl}" />
                                        <button class="btn btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown" aria-label="{lang key='configure'}">
                                            <span class="caret"></span>
                                        </button>
                                        <div id="cartitem-dropdown-menu{$smarty.foreach.positionen.index}" class="dropdown-menu dropdown-menu-right keepopen">
                                            <div class="panel-body text-center">
                                                <div class="form-inline">
                                                    <span class="btn-group">
                                                        <a class="btn btn-default configurepos"
                                                           href="index.php?a={$oPosition->kArtikel}&ek={$smarty.foreach.positionen.index}">
                                                            <span class="visible-xs visible-sm"></span>
                                                            <span class="hidden-xs hidden-sm">{lang key='configure'}</span>
                                                        </a>
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {else}
                                    <div class="qty-wrapper dropdown modify">
                                        {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                                        <button class="btn btn-default btn-xs dropdown-toggle" type="button" data-toggle="dropdown" aria-label="{lang key='quantity'}">
                                            <span class="caret"></span>
                                        </button>
                                        <div id="cartitem-dropdown-menu{$smarty.foreach.positionen.index}" class="dropdown-menu dropdown-menu-right keepopen">
                                            <div class="panel-body text-center">
                                                <div class="form-inline">
                                                    <label for="quantity{$smarty.foreach.positionen.index}">{lang key='quantity'}
                                                        {if $oPosition->Artikel->cEinheit}
                                                            ({$oPosition->Artikel->cEinheit})
                                                        {/if}
                                                    </label>:
                                                    <div id="quantity-grp{$smarty.foreach.positionen.index}" class="choose_quantity input-group">
                                                        <input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="form-control quantity form-control text-right" size="3" value="{$oPosition->nAnzahl}" />
                                                        <span class="input-group-btn">
                                                            <button type="submit" class="btn btn-default" title="{lang key='refresh' section='checkout'}"></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                {/if}
                            {else}
                                {if $oPosition->istKonfigVater()}
                                    <div class="qty-wrapper modify">
                                        <div class="btn-group-vertical" role="group" id="quantity-grp{$smarty.foreach.positionen.index}">
                                            <input name="anzahl[{$smarty.foreach.positionen.index}]" type="text" class="form-control text-center" value="{$oPosition->nAnzahl}" readonly />
                                            <span class="btn-group">
                                                <a class="btn btn-default configurepos"
                                                    href="index.php?a={$oPosition->kArtikel}&ek={$smarty.foreach.positionen.index}">
                                                    <span class="visible-xs visible-sm"></span>
                                                    <span class="hidden-xs hidden-sm">{lang key="configure" section="global"}</span>
                                                </a>
                                            </span>
                                        </div>
                                    </div>
                                {else}
                                    <div class="form-inline">
                                        <div class="btn-group-vertical" role="group" id="quantity-grp{$smarty.foreach.positionen.index}">
                                            <input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="btn-group form-control quantity text-right" size="3" value="{$oPosition->nAnzahl}" />
                                            {if $oPosition->Artikel->cEinheit}
                                                <span class="btn-group unit input-group-addon hidden-xs">{$oPosition->Artikel->cEinheit}</span>
                                            {/if}
                                            <span class="btn-group">
                                                <button type="submit" class="btn btn-default" title="{lang key='refresh' section='checkout'}"></button>
                                            </span>
                                        </div>
                                    </div>
                                {/if}
                            {/if}
                        {elseif $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_GRATISGESCHENK}
                            <input name="anzahl[{$smarty.foreach.positionen.index}]" type="hidden" value="1" />
                        {/if}
                    {else}
                        {$oPosition->nAnzahl|replace_delim} {if !empty($oPosition->Artikel->cEinheit)}{$oPosition->Artikel->cEinheit}{/if}
                    {/if}
                </td>
                {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                    <td class="hidden-xs col-sm-2 text-right price-col text-right">
                        {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                            {if !$oPosition->istKonfigVater()}
                                {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                            {/if}
                        {/if}
                    </td>
                {/if}
                <td class="col-xs-2 text-right price-col text-right">
                    <strong class="price_overall">
                        {if $oPosition->istKonfigVater()}
                            {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                        {else}
                            {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                        {/if}
                    </strong>
                </td>
                {if $tplscope === 'cart'}
                    <td class="col-xs-2 col-sm-1 delitem-col text-right">
                    {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                        <button type="submit" class="btn btn-xs btn-small btn-danger droppos" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}"></button>
                    {/if}
                    </td>
                {/if}
            </tr>
        {/if}
    {/foreach}

    </tbody>
    <tfoot>
    {if $NettoPreise}
        <tr class="total-net">
            {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                <td class="hidden-xs"></td>
            {/if}
            <td class="text-right" colspan="2"><span class="price_label"><strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong></span></td>
            <td class="text-right price-col" colspan="{if $tplscope === 'cart'}4{else}3{/if}"><strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong></td>
        </tr>
    {/if}

    {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
        {foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
            <tr class="tax">
                {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                    <td class="hidden-xs"></td>
                {/if}
                <td class="text-right" colspan="2"><span class="tax_label">{$Steuerposition->cName}:</span></td>
                <td class="text-right price-col" colspan="{if $tplscope === 'cart'}4{else}3{/if}"><span class="tax_label">{$Steuerposition->cPreisLocalized}</span></td>
            </tr>
        {/foreach}
    {/if}

    {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
         <tr class="customer-credit">
             {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                 <td class="hidden-xs"></td>
             {/if}
             <td class="text-right" colspan="2">{lang key="useCredit" section="account data"}</td>
             <td class="text-right" colspan="{if $tplscope === 'cart'}4{else}3{/if}">{$smarty.session.Bestellung->GutscheinLocalized}</td>
         </tr>
    {/if}

    <tr class="total info">
        {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
            <td class="hidden-xs"></td>
        {/if}
        <td class="text-right" colspan="2"><span class="price_label"><strong>{lang key="totalSum" section="global"}:</strong></span></td>
        <td class="text-right price-col" colspan="{if $tplscope === 'cart'}4{else}3{/if}"><strong class="price total-sum">{$WarensummeLocalized[0]}</strong></td>
    </tr>
    </tfoot>
</table>
