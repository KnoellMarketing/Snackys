<input type="submit" name="fake" class="hidden">

{if !isset($tplscope)}{assign var=tplscope value=""}{/if}

{if $tplscope !== 'cart'}
<span class="text-center h2 block">{lang key="basket" section="global"}</span>

{if $smarty.session.Warenkorb->PositionenArr|@count > 0}
{else}
<div class="alert alert-info">{lang key="emptybasket" section="checkout"}</div>
{/if}
{/if}
{if !empty($hinweis)}
    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}

    {if isset($zuletztInWarenkorbGelegterArtikel)}
        {assign var=pushedArtikel value=$zuletztInWarenkorbGelegterArtikel}
    {else}
        {assign var=pushedArtikel value=$Artikel}
    {/if}
        <div class="alert alert-success">{$pushedArtikel->cName} {lang key="productAddedToCart" section="global"}</div>
    {/if}
{/if}

{foreach name=positionen from=$smarty.session.Warenkorb->PositionenArr item=oPosition}
    {if !$oPosition->istKonfigKind()}
        <div class="type-{$oPosition->nPosTyp} basket-item{if isset($isSidebar)} sidebar-item{/if}{if isset($isCheckout)} sidebar-item{/if}">
            <div class="row">
                {* if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y' *}
                    <div class="img-col col-xs-3 col-md-2 preload">
                        {if !empty($oPosition->Artikel->cVorschaubild)}
                        <a href="{$oPosition->Artikel->cURL}" title="{$oPosition->cName|trans}">
                            <div class="image-content">
                                <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$oPosition->Artikel->cVorschaubild}" alt="{$oPosition->cName|trans}" class="img-responsive-width" />
                            </div>
                        </a>
                        {/if}
                    </div>
                {* /if *}
                <div class="col-xs-9 col-md-10">
                    <div class="row first">
                        <div class="col-xs-9 col-lg-9">
                             {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                <a href="{$oPosition->Artikel->cURL}" title="{$oPosition->cName|trans}"><strong>{$oPosition->cName|trans}</strong></a>
                                {if !isset($isSidebar)}
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
                                    
                                    {if !isset($isCheckout)}
                                    {if $Einstellungen.kaufabwicklung.bestellvorgang_artikelkurzbeschreibung == 'Y' && $oPosition->Artikel->cKurzBeschreibung|strlen > 0}
                                        <li class="shortdescription">{$oPosition->Artikel->cKurzBeschreibung}</li>
                                    {/if}
                                    {/if}

                                    {if isset($oPosition->Artikel->cGewicht) && $Einstellungen.artikeldetails.artikeldetails_gewicht_anzeigen === 'Y' && $oPosition->Artikel->fGewicht > 0}
                                        <li class="weight">
                                            <strong>{lang key="shippingWeight" section="global"}: </strong>
                                            <span class="value">{$oPosition->Artikel->cGewicht} {lang key="weightUnit" section="global"}</span>
                                        </li>
                                    {/if}
                                </ul>
                                {/if}
                            {else}
                                <strong>{$oPosition->cName|trans}{if isset($oPosition->discountForArticle)}{$oPosition->discountForArticle|trans}{/if}</strong>
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
                        </div>
                        <div class="col-xs-3 col-lg-3 text-right">
                            {if $tplscope === 'cart'}
                                {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                    {if !isset($Einstellungen.template.theme.qty_modify_dropdown) || $Einstellungen.template.theme.qty_modify_dropdown === 'Y'}
                                        {if $oPosition->istKonfigVater()}
                                            <div class="qty-wrapper modify">
                                                <input name="anzahl[{$smarty.foreach.positionen.index}]" type="hidden" class="form-control" value="{$oPosition->nAnzahl}" />
                                                <div id="cartitem-dropdown-menu{$smarty.foreach.positionen.index}" class="">
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
                                            <div class="qty-wrapper modify">                    
                                                <div id="cartitem-dropdown-menu{$smarty.foreach.positionen.index}" class="">
                                                    <div class="panel-body text-center">
                                                        <div class="form-inline">
                                                           {* <label for="quantity{$smarty.foreach.positionen.index}">{lang key='quantity'}
                                                                {if $oPosition->Artikel->cEinheit}
                                                                    ({$oPosition->Artikel->cEinheit})
                                                                {/if}
                                                            </label>:*}
                                                            <div id="quantity-grp{$smarty.foreach.positionen.index}" class="choose_quantity input-group">
                                                                <input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="form-control quantity form-control text-right" size="3" value="{$oPosition->nAnzahl}" />
                                                                <span class="input-group-btn">
                                                                    <button type="submit" class="btn btn-default preload" title="{lang key='refresh' section='checkout'}">
                                                                        <span class="image-content icon">
																			<svg>
																			  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-refresh"></use>
																			</svg>
                                                                        </span>
                                                                    </button>
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
                                                <div class="input-group" role="group" id="quantity-grp{$smarty.foreach.positionen.index}">
                                                    <input name="anzahl[{$smarty.foreach.positionen.index}]" id="quantity{$smarty.foreach.positionen.index}" class="btn-group form-control quantity text-right" size="3" value="{$oPosition->nAnzahl}" />
                                                    {* if $oPosition->Artikel->cEinheit}
                                                        <span class="btn-group unit input-group-addon hidden-xs">{$oPosition->Artikel->cEinheit}</span>
                                                    {/if *}
                                                    <span class="input-group-btn">
                                                        <button type="submit" class="btn btn-default preload" title="{lang key='refresh' section='checkout'}">
                                                            <span class="image-content icon">
																<svg>
																  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-refresh"></use>
																</svg>
                                                                        </span>
                                                        </button>
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
                        </div>
                    </div>
                    <div class="row">
                        {if $tplscope === 'cart'}
                        <div class="col-xs-9 col-lg-9 small">
                            {if $Einstellungen.kaufabwicklung.bestellvorgang_einzelpreise_anzeigen === 'Y'}
                                {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                    {if !$oPosition->istKonfigVater()}
                                        <span class="single-price">
                                            {lang key="pricePerUnit" section="productDetails"}: {$oPosition->cEinzelpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                        </span>
                                    {/if}
                                {/if}
                            {/if}                        
                            {if $tplscope === 'cart'}
                                {if $oPosition->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}
                                    <button type="submit" class="droppos btn btn-xs text-muted preload" name="dropPos" value="{$smarty.foreach.positionen.index}" title="{lang key="delete" section="global"}"
										gtag-type="click" gtag-event="remove_from_cart" gtag-p-value="{$oPosition->Artikel->Preise->fVKNetto}" gtag-p-currency="{$smarty.session.Waehrung->cISO}" gtag-p-items='[{ldelim}"id":"{$oPosition->Artikel->cArtNr}","name":"{$oPosition->Artikel->cName|replace:'"':''}","price":"{$oPosition->Artikel->Preise->fVKNetto}","quantity":"{$oPosition->nAnzahl}"{rdelim}]'
									>
                                        <span class="image-content icon">
											<svg>
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-bin"></use>
											</svg
                                        </span> <span class="hidden-xxs">{lang key="delete" section="global"}</span>
                            </button>
                                {/if}
                            {/if}
                        </div>
                        {/if}
                        <div class="{if $tplscope === 'cart'}col-xs-3 col-lg-3{else}col-xs-12 col-lg-12{/if} text-right">
                            <strong class="price">
                                {if $oPosition->istKonfigVater()}
                                    {$oPosition->cKonfigpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {else}
                                    {$oPosition->cGesamtpreisLocalized[$NettoPreise][$smarty.session.cWaehrungName]}
                                {/if}
                            </strong>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/foreach}