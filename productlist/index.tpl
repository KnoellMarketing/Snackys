{snackysBasics}
{block name="header"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/header.tpl'}
    {/if}
{/block}

{block name="content"}
	{foreach name=navi from=$Brotnavi item=oItem}
		{if $smarty.foreach.navi.total == $smarty.foreach.navi.iteration}
			{assign var=cate value=$oItem->name}
		{/if}
	{/foreach}
    <div id="result-wrapper"
	gtag-type="start" gtag-event="view_item_list" gtag-p-value="{$Artikel->Preise->fVKNetto}" gtag-p-currency="{$smarty.session.Waehrung->cISO}" gtag-p-items='[{foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}{if !$smarty.foreach.artikel.first},{/if}{ldelim}"id":"{if $Einstellungen.template.analytics.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr}{/if}","category":"{$cate|escape}","name":"{$Artikel->cName|escape}","price":"{$Artikel->Preise->fVKNetto}"{rdelim}{/foreach}]'
	>
        
        {block name="productlist-header"}
        {include file='productlist/header.tpl'}
        {/block}
    
        {assign var='style' value='gallery'}

        {if isset($boxes.left) && !$bExclusive && !empty($boxes.left)}
            {assign var='grid' value='col-xs-6 col-lg-4'}
        {else}
            {assign var='grid' value='col-xs-6 col-md-4'}
        {/if}
        {*Prio: -> Funktionsattribut -> Benutzereingabe -> Standarddarstellung*}
        {if (!empty($AktuelleKategorie->categoryFunctionAttributes['darstellung']) &&
        $AktuelleKategorie->categoryFunctionAttributes['darstellung'] == 1) ||
        (empty($AktuelleKategorie->categoryFunctionAttributes['darstellung']) &&
        ((!empty($oErweiterteDarstellung->nDarstellung) &&
        isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung) &&
        $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung === 'Y' &&
        $oErweiterteDarstellung->nDarstellung == 1) ||
        (empty($oErweiterteDarstellung->nDarstellung) &&
        isset($Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht) &&
        $Einstellungen.artikeluebersicht.artikeluebersicht_erw_darstellung_stdansicht == 1)))}
            {assign var='style' value='gallery'}
            {assign var='grid' value='col-xs-12'}
        {/if}
        {if isset($Suchergebnisse->Fehler)}
            <p class="alert alert-danger">{$Suchergebnisse->Fehler}</p>
        {/if}
        
        {* Bestseller *}
        {if isset($oBestseller_arr) && $oBestseller_arr|@count > 0}
            {block name="productlist-bestseller"}
            {lang key='bestseller' section='global' assign='slidertitle'}
            {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$oBestseller_arr title=$slidertitle}
            {/block}
        {/if}
        
		{if $Einstellungen.template.pdListing.filterPos == 1}
		{block name="aside"}
		{has_boxes position='left' assign='hasLeftBox'}
		{if !$bExclusive && $hasLeftBox && isset($boxes) && !empty($boxes.left)}
			{block name="footer-sidepanel-left"}
				<aside id="sidepanel_left" class="hidden-print col-xs-12 show-above">
					<div class="inside">
						<div class="visible-xs visible-sm">
							<h3>{lang key="filterBy" setion="global"}</h3>
							<hr class="op0">
						</div>
						{block name="footer-sidepanel-left-content"}
						{$boxes.left}
						{/block}
					</div>
					<div class="visible-xs visible-sm overlay-bg"></div>
					<div class="visible-xs visible-sm close-sidebar"></div>
				</aside>
			{/block}
		{/if}
		{/block}
		{/if}
		
        {block name="productlist-results"}
		
        <div class="row {$style}" id="product-list" itemprop="mainEntity" itemscope itemtype="http://schema.org/ItemList">
			{if $Suchergebnisse->GesamtanzahlArtikel >= 20}
            <div id="nfity-scroll">
                <div class="nfy-placeholder"></div>
                <div class="nfy-scroller">
                    <a href="#top">
                        <span class="css-arrow css-arrow-up"></span>
                    </a>
                </div>
            </div>
			{/if}
			{if $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}
				<div class="endless-scrolling text-center block"><button id="view-prev" class="btn btn-xs" data-url="{$oNaviSeite_arr.zurueck->cURL}">Vorherige laden</button></div>
			{/if}
			<span class="pagination-url" data-url="{$smarty.server.REQUEST_URI}"></span>
            {foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}
                <div class="product-wrapper col-xs-6 col-sm-4 col-md-4 col-lg-3 preload" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
                    <meta itemprop="position" content="{$smarty.foreach.artikel.iteration}">
                    {if $style === 'list'}
                        {include file='productlist/item_box.tpl' tplscope=$style}
                    {else}
                        {include file='productlist/item_box.tpl' tplscope=$style class='thumbnail'}
                    {/if}
                </div>
            {/foreach}
			{if $Suchergebnisse->Seitenzahlen->AktuelleSeite < $Suchergebnisse->Seitenzahlen->maxSeite}
				<div class="endless-scrolling text-center block"><button id="view-next" class="btn btn-xs" data-url="{$oNaviSeite_arr.vor->cURL}">Weitere laden</button></div>
			{/if}
			
			
        </div>
        {/block}
        
        {block name="productlist-footer"}
        {include file='productlist/footer.tpl'}
        {/block}
    </div>
{/block}

{block name="footer"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/footer.tpl'}
    {/if}
{/block}