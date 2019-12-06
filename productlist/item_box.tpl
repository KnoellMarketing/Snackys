{* template to display products in boxes and product-lists *}

{if $Einstellungen.template.productlist.variation_select_productlist === 'N' || $Einstellungen.template.productlist.hover_productlist !== 'Y'}
    {assign var="hasOnlyListableVariations" value=0}
{else}
    {hasOnlyListableVariations artikel=$Artikel maxVariationCount=$Einstellungen.template.productlist.variation_select_productlist maxWerteCount=$Einstellungen.template.productlist.variation_max_werte_productlist assign="hasOnlyListableVariations"}
{/if}
<div id="result-wrapper_buy_form_{$Artikel->kArtikel}" class="product-cell text-center{if $Einstellungen.template.productlist.hover_productlist === 'Y'} hover-enabled{/if}{if isset($listStyle) && $listStyle === 'gallery'} active{/if}{if isset($class)} {$class}{/if}">
{block name="productlist-image"}
    <a class="image-wrapper" href="{$Artikel->cURL}">
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
        {else}
            {assign var="alt" value=$Artikel->cName}
        {/if}
	{if isset($Artikel->Bilder[1])}
		{include file="snippets/image.tpl" src=$Artikel->Bilder[0]->cPfadKlein alt=$alt second=$Artikel->Bilder[1]->cPfadKlein}
	{else}
		{include file="snippets/image.tpl" src=$Artikel->Bilder[0]->cPfadKlein alt=$alt}
	{/if}
    {if isset($Artikel->oSuchspecialBild)}
        {if isset($Artikel->oSuchspecialBild->cSuchspecial)}
			{if $Artikel->oSuchspecialBild->cSuchspecial == 'Sonderangebote' && $Einstellungen.template.general.saleprozent == 'Y'}
				{assign var="rabatt" value=($Artikel->Preise->alterVKNetto-$Artikel->Preise->fVKNetto)/$Artikel->Preise->alterVKNetto*100}
				<span class="overlay-text {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">- {$rabatt|round:0}%</span>
			{elseif isset($oSuchspecial[$Artikel->oSuchspecialBild->cSuchspecial|replace:'ü':''])}
				<span class="overlay-text {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">{$oSuchspecial[$Artikel->oSuchspecialBild->cSuchspecial|replace:'ü':'']}</span>
			{*Workaround for damn ü !*}
			{elseif $Artikel->oSuchspecialBild->cSuchspecial|substr:0:4|lower == 'in k'}
				<span class="overlay-text bald-verfuegbar">{$oSuchspecial['bald-verfuegbar']}</span>
			{else}
				<span class="overlay-text {$Artikel->oSuchspecialBild->cSuchspecial|lower|strip:''}">#{$Artikel->oSuchspecialBild->cSuchspecial}</span>
			{/if}
        {/if}
    {/if}
</a>
{/block}
    {block name="productlist-image-caption"}
    <div class="caption">
        <h4 class="title" itemprop="name"><a href="{$Artikel->cURL}">{$Artikel->cKurzbezeichnung}</a></h4>
        {if $Artikel->cName !== $Artikel->cKurzbezeichnung}<meta itemprop="alternateName" content="{$Artikel->cName}">{/if}
        <meta itemprop="url" content="{$ShopURL}/{$Artikel->cURL}">
        {if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}
            {include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}<br>
        {/if}
        {assign var=price_image value=""}
        {if isset($Artikel->Preise->strPreisGrafik_Suche)}
            {assign var=$price_image value=$Artikel->Preise->strPreisGrafik_Suche}
        {/if}
        {include file="productdetails/price.tpl" Artikel=$Artikel price_image=$price_image tplscope=$tplscope}
    </div>{* /caption *}
    {/block}
    <form id="buy_form_{$Artikel->kArtikel}" action="navi.php" method="post" class="form form-basket evo-validate" data-toggle="basket-add">
        {$jtl_token}
        {block name="productlist-delivery-status"}
            <div class="delivery-status">
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
            </div>
        {/block}
		{if $Einstellungen.template.pdListing.listShowCart != 1}
        <div class="expandable{if $Einstellungen.template.pdListing.listShowCart == 2} floating-button preload{/if}{if $Einstellungen.template.pdListing.listShowAmountCart == 1} hide-qty{/if}">
            {block name="form-expandable"}
            <div>
                {block name="productlist-add-basket"}
                {if ($Artikel->inWarenkorbLegbar === 1 || ($Artikel->nErscheinendesProdukt === 1 && $Einstellungen.global.global_erscheinende_kaeuflich === 'Y')) &&
                    (($Artikel->nIstVater === 0 && $Artikel->Variationen|@count === 0) || $hasOnlyListableVariations === 1) && !$Artikel->bHasKonfig
                }
                    <div class="quantity-wrapper{if $Einstellungen.template.pdListing.listShowCart == 3} form-group{/if}">
                        {if $Artikel->nIstVater && $Artikel->kVaterArtikel == 0}
                        {else}
                                <div class="{if $Einstellungen.template.pdListing.listShowCart == 3 && $Einstellungen.template.pdListing.listShowAmountCart == 2}input-group input-group-sm small{/if}">
                                    <input type="number" min="0"
                                           {if $Artikel->fAbnahmeintervall > 0}step="{$Artikel->fAbnahmeintervall}"{/if} size="2"
                                           id="quantity{$Artikel->kArtikel}" class="quantity form-control text-right" name="anzahl"
                                           autocomplete="off"
                                           value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}{$Einstellungen.template.pdListing.listAmountCart}{/if}">

                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-primary sn-addBasket" id="submit{$Artikel->kArtikel}"
                                                title="{lang key="addToCart" section="global"}">
											{if $Einstellungen.template.pdListing.listShowCart == 2}
											<span class="image-content icon">
												<svg>
												  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-cart-simple-w"></use>
												</svg>
											</span>
											{elseif $Einstellungen.template.pdListing.listShowCart == 3}
                                            {lang key="addToCart" section="global"}
											{/if}
                                        </button>
                                    </span>
                                </div>
                        {/if}
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
            <input type="hidden" name="Sortierung" value="{if !empty($Suchergebnisse->Sortierung)}{$Suchergebnisse->Sortierung}{/if}" />
            {if isset($Suchergebnisse->Seitenzahlen) && $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}
                <input type="hidden" name="seite" value="{$Suchergebnisse->Seitenzahlen->AktuelleSeite}" />{/if}
            {if isset($NaviFilter->Kategorie) && $NaviFilter->Kategorie->kKategorie > 0}
                <input type="hidden" name="k" value="{$NaviFilter->Kategorie->kKategorie}" />{/if}
            {if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller > 0}
                <input type="hidden" name="h" value="{$NaviFilter->Hersteller->kHersteller}" />{/if}
            {if isset($NaviFilter->Suchanfrage) && $NaviFilter->Suchanfrage->kSuchanfrage > 0}
                <input type="hidden" name="l" value="{$NaviFilter->Suchanfrage->kSuchanfrage}" />{/if}
            {if isset($NaviFilter->MerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert > 0}
                <input type="hidden" name="m" value="{$NaviFilter->MerkmalWert->kMerkmalWert}" />{/if}
            {if isset($NaviFilter->Tag) && $NaviFilter->Tag->kTag > 0}<input type="hidden" name="t" value="{$NaviFilter->Tag->kTag}">{/if}
            {if isset($NaviFilter->KategorieFilter) && $NaviFilter->KategorieFilter->kKategorie > 0}
                <input type="hidden" name="kf" value="{$NaviFilter->KategorieFilter->kKategorie}" />{/if}
            {if isset($NaviFilter->HerstellerFilter) && $NaviFilter->HerstellerFilter->kHersteller > 0}
                <input type="hidden" name="hf" value="{$NaviFilter->HerstellerFilter->kHersteller}" />{/if}

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
        </div>
		{/if}
    </form>
</div>{* /product-cell *}
