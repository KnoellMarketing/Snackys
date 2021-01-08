{* template to display products in p-ls *}

{if $snackyConfig.variation_select_productlist === 'N' || $snackyConfig.hover_productlist !== 'Y'}
    {assign var="hasOnlyListableVariations" value=0}
{else}
    {hasOnlyListableVariations artikel=$Artikel maxVariationCount=$snackyConfig.variation_select_productlist maxWerteCount=$snackyConfig.variation_max_werte_productlist assign="hasOnlyListableVariations"}
{/if}
<div id="result-wrapper_buy_form_{$Artikel->kArtikel}" class="p-c{if $snackyConfig.hover_productlist === 'Y'} hv-e{/if}{if isset($listStyle) && $listStyle === 'list'} active{/if}">
    <div class="product-body row {if $tplscope !== 'list'} text-center{/if}">
        <div class="col-xs-3 text-center">
            {block name="img-w"}
                <a class="img-w" href="{$Artikel->cURL}">
                    {if isset($Artikel->Bilder[0]->cAltAttribut)}
                        {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
                    {else}
                        {assign var="alt" value=$Artikel->cName}
                    {/if}

                    {include file="snippets/image.tpl" src=$Artikel->Bilder[0]->cPfadNormal alt=$alt tplscope=$tplscope}

					{if isset($Artikel->oSuchspecialBild->cSuchspecial)}
						{if $Artikel->oSuchspecialBild->cSuchspecial == 'Sonderangebote' && $snackyConfig.saleprozent == 'Y'}
							{assign var="rabatt" value=($Artikel->Preise->alterVKNetto-$Artikel->Preise->fVKNetto)/$Artikel->Preise->alterVKNetto*100}
							<span class="ov-t {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">- {$rabatt|round:0}%</span>
						{elseif isset($oSuchspecial[$Artikel->oSuchspecialBild->cSuchspecial|replace:'ü':''])}
							<span class="ov-t {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">{$oSuchspecial[$Artikel->oSuchspecialBild->cSuchspecial|replace:'ü':'']}</span>
						{*Workaround for damn ü !*}
						{elseif $Artikel->oSuchspecialBild->cSuchspecial|substr:0:4|lower == 'in k'}
							<span class="ov-t bald-verfuegbar">{$oSuchspecial['bald-verfuegbar']}</span>
						{else}
							<span class="ov-t {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">#{$Artikel->oSuchspecialBild->cSuchspecial}</span>
						{/if}
					{/if}

                    {if $snackyConfig.quickview_productlist === 'Y' && !$Artikel->bHasKonfig}
                        <span class="quickview badge hidden-xs" data-src="{$Artikel->cURL}" data-target="buy_form_{$Artikel->kArtikel}" title="{$Artikel->cName}">{lang key="downloadPreview" section="productDownloads"}</span>
                    {/if}
                </a>
            {/block}
            {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
                {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}
            {/if}
        </div>
        <div class="col-xs-5 product-detail">
            {block name="product-title"}
                <h4 class="title" itemprop="name">
                    <a href="{$Artikel->cURL}">{$Artikel->cName}</a>
                </h4>
                <meta itemprop="url" content="{$ShopURL}/{$Artikel->cURL}">
            {/block}
            {block name="product-manufacturer"}
                {if $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen !== 'N'}
                    <div class="media hidden-xs top0 bottom5">
                        {if ($Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'BT'
                        || $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'B') && !empty($Artikel->cHerstellerBildKlein)}
                            <div class="media-left">
                                {if !empty($Artikel->cHerstellerHomepage)}<a href="{$Artikel->cHerstellerHomepage}">{/if}
                                    <img src="{$Artikel->cHerstellerBildKlein}" alt="" class="img-xs">
                                {if !empty($Artikel->cHerstellerHomepage)}</a>{/if}
                            </div>
                        {/if}
                        {if ($Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'BT'
                        || $Einstellungen.artikeluebersicht.artikeluebersicht_hersteller_anzeigen === 'Y') && !empty($Artikel->cHersteller)}
                            <div class="media-body">
                                <span class="small text-uppercase">
                                    {if !empty($Artikel->cHerstellerHomepage)}<a href="{$Artikel->cHerstellerHomepage}">{/if}
                                        {$Artikel->cHersteller}
                                    {if !empty($Artikel->cHerstellerHomepage)}</a>{/if}
                                </span>
                            </div>
                        {/if}
                    </div>
                {/if}
            {/block}

            <div class="product-info hidden-xs">
                {block name="product-info"}
                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                        <div class="shortdescription">
                            {$Artikel->cKurzBeschreibung}
                        </div>
                    {/if}
                    <ul class="attr-group list-unstyled small text-muted top10 hidden-xs">
                        <li class="item row attr-sku">
                            <span class="attr-label col-sm-5">{lang key="productNo" section="global"}: </span> <span class="value col-sm-7">{$Artikel->cArtNr}</span>
                        </li>
                        {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                            <li class="item row attr-best-before" title="{lang key='productMHDTool' section='global'}">
                                <span class="attr-label col-sm-5">{lang key="productMHD" section="global"}: </span> <span class="value col-sm-7">{$Artikel->dMHD_de}</span>
                            </li>
                        {/if}
                        {if isset($Artikel->cGewicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_gewicht_anzeigen === 'Y' && $Artikel->fGewicht > 0}
                            <li class="item row attr-weight">
                                <span class="attr-label col-sm-5">{lang key="shippingWeight" section="global"}: </span>
                                <span class="value col-sm-7">{$Artikel->cGewicht} {lang key="weightUnit" section="global"}</span>
                            </li>
                        {/if}
                        {if isset($Artikel->cArtikelgewicht) && $Einstellungen.artikeluebersicht.artikeluebersicht_artikelgewicht_anzeigen === 'Y' && $Artikel->fArtikelgewicht > 0}
                            <li class="item row attr-weight weight-unit-article hidden-sm">
                                <span class="attr-label col-sm-5">{lang key="productWeight" section="global"}: </span>
                                <span class="value col-sm-7">{$Artikel->cArtikelgewicht} {lang key="weightUnit" section="global"}</span>
                            </li>
                        {/if}
                        {if $Einstellungen.artikeluebersicht.artikeluebersicht_artikelintervall_anzeigen === 'Y' && $Artikel->fAbnahmeintervall > 0}
                            <li class="item row attr-quantity-scale">
                                <span class="attr-label col-sm-5">{lang key="purchaseIntervall" section="productOverview"}: </span>
                                <span class="value col-sm-7">{$Artikel->fAbnahmeintervall} {$Artikel->cEinheit}</span>
                            </li>
                        {/if}
                        {if count($Artikel->Variationen)>0}
                            <li class="item row attr-variations">
                                <span class="attr-label col-sm-5">{lang key="variationsIn" section="productOverview"}: </span>
                                <span class="value-group col-sm-7">{foreach name=variationen from=$Artikel->Variationen item=Variation}{if !$smarty.foreach.variationen.first}, {/if}
                                <span class="value">{$Variation->cName}</span>{/foreach}</span>
                            </li>
                        {/if}
                    </ul>{* /attr-group *}
                    {if $Artikel->oVariationKombiVorschau_arr|@count > 0 && $Artikel->oVariationKombiVorschau_arr && $Einstellungen.artikeluebersicht.artikeluebersicht_varikombi_anzahl > 0}
                        <div class="varikombis-thumbs hidden-md hidden-sm">
                            {foreach name=varikombis from=$Artikel->oVariationKombiVorschau_arr item=oVariationKombiVorschau}
                                <a href="{$oVariationKombiVorschau->cURL}" class="thumbnail"><img src="{$oVariationKombiVorschau->cBildMini}" alt="" /></a>
                            {/foreach}
                        </div>
                    {/if}
                {/block}
            </div>{* /product-info *}

        </div>{* /col-md-9 *}
        <div class="col-xs-4 product-detail">
            <div class="product-detail-cell">
                {block name="form-basket"}
                    {assign var=price_image value=""}
                    {if isset($Artikel->Preise->strPreisGrafik_Suche)}
                        {assign var=$price_image value=$Artikel->Preise->strPreisGrafik_Suche}
                    {/if}
                    {include file="productdetails/price.tpl" Artikel=$Artikel price_image=$price_image tplscope=$tplscope}
                    <div class="delivery-status">
                        {block name="delivery-status"}
                            {assign var=anzeige value=$Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandsanzeige}
                            {if $Artikel->nErscheinendesProdukt}
                                <div class="availablefrom">
                                    <small>{lang key="productAvailable" section="global"}: {$Artikel->Erscheinungsdatum_de}</small>
                                </div>
                                {if $Einstellungen.global.global_erscheinende_kaeuflich === 'Y' && $Artikel->inWarenkorbLegbar === 1}
                                    <div class="attr attr-preorder"><small class="value">{lang key="preorderPossible" section="global"}</small></div>
                                {/if}
                            {elseif $anzeige !== 'nichts' &&
                                $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N' &&
                                $Artikel->cLagerBeachten === 'Y' && ($Artikel->cLagerKleinerNull === 'N' ||
                                $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U') &&
                                $Artikel->fLagerbestand <= 0 && $Artikel->fZulauf > 0 && isset($Artikel->dZulaufDatum_de)}
                                {assign var=cZulauf value=$Artikel->fZulauf|cat:':::'|cat:$Artikel->dZulaufDatum_de}
                                <div class="signal_image status-1"><small>{lang key="productInflowing" section="productDetails" printf=$cZulauf}</small></div>
                            {elseif $anzeige !== 'nichts' &&
                                $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen !== 'N' &&
                                $Artikel->cLagerBeachten === 'Y' && $Artikel->fLagerbestand <= 0 &&
                                $Artikel->fLieferantenlagerbestand > 0 && $Artikel->fLieferzeit > 0 &&
                                ($Artikel->cLagerKleinerNull === 'N' ||
                                $Einstellungen.artikeluebersicht.artikeluebersicht_lagerbestandanzeige_anzeigen === 'U')}
                                <div class="signal_image status-1"><small>{lang key="supplierStockNotice" section="global" printf=$Artikel->fLieferzeit}</small></div>
                            {elseif $anzeige === 'verfuegbarkeit' || $anzeige === 'genau'}
                                <div class="signal_image status-{$Artikel->Lageranzeige->nStatus}"><small>{$Artikel->Lageranzeige->cLagerhinweis[$anzeige]}</small></div>
                            {elseif $anzeige === 'ampel'}
                                <div class="signal_image status-{$Artikel->Lageranzeige->nStatus}"><small>{$Artikel->Lageranzeige->AmpelText}</small></div>
                            {/if}
                            {if $Artikel->cEstimatedDelivery}
                                <div class="estimated_delivery hidden-xs">
                                    <small>{lang key="shippingTime" section="global"}: {$Artikel->cEstimatedDelivery}</small>
                                </div>
                            {/if}
                        {/block}
                    </div>
                    <form action="" method="post" class="hidden-xs product-actions" data-toggle="product-actions">
                        {$jtl_token}
                        <div class="actions btn-group btn-group-xs btn-group-justified" role="group" aria-label="...">
                            {block name="product-actions"}
                                {if !($Artikel->nIstVater && $Artikel->kVaterArtikel === 0)}
                                    {if $Einstellungen.artikeluebersicht.artikeluebersicht_vergleichsliste_anzeigen === 'Y'}
                                        <div class="btn-group btn-group-xs" role="group">
                                            <button name="Vergleichsliste" type="submit" class="compare btn btn-default" title="{lang key="addToCompare" section="productOverview"}">
                                                
                                            </button>
                                        </div>
                                    {/if}
                                    {if $Einstellungen.global.global_wunschliste_anzeigen === 'Y' && $Einstellungen.artikeluebersicht.artikeluebersicht_wunschzettel_anzeigen === 'Y'}
                                        <div class="btn-group btn-group-xs" role="group">
                                            <button name="Wunschliste" type="submit" class="wishlist btn btn-default" title="{lang key="addToWishlist" section="productDetails"}">
                                                
                                            </button>
                                        </div>
                                    {/if}
                                    {if $Artikel->verfuegbarkeitsBenachrichtigung === 3 && (($Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull !== 'Y') || $Artikel->cLagerBeachten !== 'Y')}
                                        <div class="btn-group btn-group-xs" role="group">
                                            <button type="button" id="n{$Artikel->kArtikel}" class="popup-dep notification btn btn-default btn-left" title="{lang key="requestNotification" section="global"}">
                                                
                                            </button>
                                        </div>
                                    {/if}
                                {/if}
                            {/block}
                        </div>
                        <input type="hidden" name="a" value="{if !empty({$Artikel->kVariKindArtikel})}{$Artikel->kVariKindArtikel}{else}{$Artikel->kArtikel}{/if}" />
                    </form>
                    <div class="exp">
                        <form id="buy_form_{$Artikel->kArtikel}" action="navi.php" method="post" class="form form-basket evo-validate" data-toggle="basket-add">
                            {block name="form-expandable"}
                            {if $hasOnlyListableVariations > 0 && !$Artikel->bHasKonfig && $Artikel->kEigenschaftKombi === 0}
                                <div class="hidden-xs basket-variations">
                                    {assign var="singleVariation" value=true}
                                    {include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=false smallView=true ohneFreifeld=($hasOnlyListableVariations == 2)}
                                </div>
                            {/if}
                            <div class="hidden-xs basket-details">
                                {block name="basket-details"}
                                    {if ($Artikel->inWarenkorbLegbar === 1 || ($Artikel->nErscheinendesProdukt === 1 && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y')) &&
                                        (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0) || $hasOnlyListableVariations === 1) && !$Artikel->bHasKonfig
                                    }
                                        <div class="quantity-wrapper form-group top7">
                                            {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                                                <p class="alert alert-info choose-variations">{lang key="chooseVariations" section="messages"}</p>
                                            {else}
                                                <div class="quantity-wrapper form-group top7">
                                                    <div class="input-group input-group-sm">
                                                        <input type="number" min="0"
                                                               {if $Artikel->fAbnahmeintervall > 0}step="{$Artikel->fAbnahmeintervall}"{/if} size="2"
                                                               id="quantity{$Artikel->kArtikel}" class="quantity form-control text-right" name="anzahl"
                                                               autocomplete="off"
                                                               value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}1{/if}">

                                                        <span class="input-group-btn">
                                                            <button type="submit" class="btn btn-primary sn-addBasket" id="submit{$Artikel->kArtikel}"
                                                                    title="{lang key="addToCart" section="global"}">
                                                                <span> {lang key="addToCart" section="global"}</span>
                                                            </button>
                                                        </span>
                                                    </div>
                                                </div>
                                            {/if}
                                        </div>
                                    {else}
                                        <div class="top7 form-group">
                                            <a class="btn btn-default btn-sm btn-block" role="button" href="{$Artikel->cURL}">{lang key="details"}</a>
                                        </div>
                                    {/if}
                                {/block}
                            </div>
                            {if $Artikel->kArtikelVariKombi > 0}
                                <input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
                            {/if}
                            {if isset($Artikel->kVariKindArtikel)}
                                <input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}" />
                            {/if}
                            <input type="hidden" name="a" value="{$Artikel->kArtikel}" />
                            <input type="hidden" name="wke" value="1" />
                            <input type="hidden" name="overview" value="1" />
                            <input type="hidden" name="Sortierung" value="{if isset($Suchergebnisse->Sortierung)}{$Suchergebnisse->Sortierung}{/if}" />
                            {if isset($Suchergebnisse->Seitenzahlen) && $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}
                                <input type="hidden" name="seite" value="{$Suchergebnisse->Seitenzahlen->AktuelleSeite}" />
                            {/if}
                            {if isset($NaviFilter->Kategorie) && $NaviFilter->Kategorie->kKategorie > 0}
                                <input type="hidden" name="k" value="{$NaviFilter->Kategorie->kKategorie}" />
                            {/if}
                            {if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller > 0}
                                <input type="hidden" name="h" value="{$NaviFilter->Hersteller->kHersteller}" />
                            {/if}
                            {if isset($NaviFilter->Suchanfrage) && $NaviFilter->Suchanfrage->kSuchanfrage > 0}
                                <input type="hidden" name="l" value="{$NaviFilter->Suchanfrage->kSuchanfrage}" />
                            {/if}
                            {if isset($NaviFilter->MerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert > 0}
                                <input type="hidden" name="m" value="{$NaviFilter->MerkmalWert->kMerkmalWert}" />
                            {/if}
                            {if isset($NaviFilter->Tag) && $NaviFilter->Tag->kTag > 0}
                                <input type="hidden" name="t" value="{$NaviFilter->Tag->kTag}">
                            {/if}
                            {if isset($NaviFilter->KategorieFilter) && $NaviFilter->KategorieFilter->kKategorie > 0}
                                <input type="hidden" name="kf" value="{$NaviFilter->KategorieFilter->kKategorie}" />
                            {/if}
                            {if isset($NaviFilter->HerstellerFilter) && $NaviFilter->HerstellerFilter->kHersteller > 0}
                                <input type="hidden" name="hf" value="{$NaviFilter->HerstellerFilter->kHersteller}" />
                            {/if}
                            {if isset($NaviFilter->MerkmalFilter)}
                                {foreach name=merkmalfilter from=$NaviFilter->MerkmalFilter item=mmfilter}
                                    <input type="hidden" name="mf{$smarty.foreach.merkmalfilter.iteration}" value="{$mmfilter->kMerkmalWert}" />
                                {/foreach}
                            {/if}
                            {if isset($NaviFilter->TagFilter)}
                                {foreach name=tagfilter from=$NaviFilter->TagFilter item=tag}
                                    <input type="hidden" name="tf{$smarty.foreach.tagfilter.iteration}" value="{$tag->kTag}" />
                                {/foreach}
                            {/if}
                            {/block}
                        </form>
                    </div>
                {/block}
            </div>
        </div>{* /col-md-3 *}
    </div>{* /product-body *}
</div>{* /p-c *}

{* popup-content *}
{if $Artikel->verfuegbarkeitsBenachrichtigung === 3}
    <div id="popupn{$Artikel->kArtikel}" class="hidden">
        {include file='productdetails/availability_notification_form.tpl' position="popup" tplscope='artikeldetails'}
    </div>
{/if}
