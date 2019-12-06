{* template to display products in slider *}

<div class="product-cell {if isset($class)} {$class}{/if} thumbnail preload">
    <a class="image-wrapper" href="{$Artikel->cURL}">
        <span class="image-content">
        {if isset($Artikel->Bilder[0]->cAltAttribut)}
            {assign var="alt" value=$Artikel->Bilder[0]->cAltAttribut|strip_tags|truncate:60|escape:"html"}
        {else}
            {assign var="alt" value=$Artikel->cName}
        {/if}

        <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$Artikel->Bilder[0]->cPfadKlein}" alt="{$alt}" />
		{if isset($Artikel->Bilder[1])}
		<div class="second-img">
			<img data-src="{$Artikel->Bilder[1]->cPfadKlein}" src="{$snackysTemplate}img/preload/1x1.png" alt="{$alt}" />
		</div>
		{/if}
        {if isset($Artikel->oSuchspecialBild) && !isset($hideOverlays)}
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
        </span>
    </a>
    <div class="caption">
        <h4 class="title word-break">
            {if isset($showPartsList) && $showPartsList === true && isset($Artikel->fAnzahl_stueckliste)}
                <span class="article-bundle-info">
                    <span class="bundle-amount">{$Artikel->fAnzahl_stueckliste}</span> <span class="bundle-times">x</span>
                </span>
            {/if}
            <a href="{$Artikel->cURL}">{$Artikel->cKurzbezeichnung}</a>
        </h4>
        {* if $Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->fDurchschnittsBewertung > 0}<small>{include file='productdetails/rating.tpl' stars=$Artikel->fDurchschnittsBewertung}</small>{/if *}
        {if isset($Artikel->Preise->strPreisGrafik_Suche)}
            {include file="productdetails/price.tpl" Artikel=$Artikel price_image=$Artikel->Preise->strPreisGrafik_Suche tplscope=$tplscope}
        {else}
            {include file="productdetails/price.tpl" Artikel=$Artikel price_image=null tplscope=$tplscope}
        {/if}
    </div>
	<form action="navi.php" method="post" class="buy_form_{$Artikel->kArtikel} form form-basket evo-validate" data-toggle="basket-add">
        {$jtl_token}
        {block name="productlist-delivery-status"}
            <div class="delivery-status hidden">
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
                                           class="quantity form-control text-right" name="anzahl"
                                           autocomplete="off"
                                           value="{if $Artikel->fAbnahmeintervall > 0}{if $Artikel->fMindestbestellmenge > $Artikel->fAbnahmeintervall}{$Artikel->fMindestbestellmenge}{else}{$Artikel->fAbnahmeintervall}{/if}{else}{$Einstellungen.template.pdListing.listAmountCart}{/if}">

                                    <span class="input-group-btn">
                                        <button type="submit" class="btn btn-primary sn-addBasket"
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
