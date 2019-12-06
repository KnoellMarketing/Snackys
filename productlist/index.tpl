{block name="header"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/header.tpl'}
    {/if}
{/block}

{if !isset($smarty.get.sidebar)}
{block name="content"}
	{assign var="viewportImages" value=0 scope="global"}
	{foreach name=navi from=$Brotnavi item=oItem}
		{if $smarty.foreach.navi.total == $smarty.foreach.navi.iteration}
			{assign var=cate value=$oItem->name}
		{/if}
	{/foreach}
    <div id="result-wrapper"
	data-track-type="start" data-track-event="view_item_list" data-track-p-value="{$Artikel->Preise->fVKNetto}" data-track-p-currency="{$smarty.session.Waehrung->cISO}" data-track-p-items='[{foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}{if !$smarty.foreach.artikel.first},{/if}{ldelim}"id":"{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr}{/if}","category":"{$cate|escape}","name":"{$Artikel->cName|escape}","price":"{$Artikel->Preise->fVKNetto}"{rdelim}{/foreach}]'
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
			{include file="snippets/zonen.tpl" id="before_bestseller" title="before_bestseller"}
            {block name="productlist-bestseller"}
            {lang key='bestseller' section='global' assign='slidertitle'}
            {include file='snippets/product_slider.tpl' id='slider-top-products' productlist=$oBestseller_arr title=$slidertitle}
            {/block}
        {/if}
        
		{if $snackyConfig.filterPos == 1}
		{block name="aside"}
		{has_boxes position='left' assign='hasLeftBox'}
		{if !$bExclusive && $hasLeftBox && isset($boxes) && !empty($boxes.left) && $snackyConfig.sidepanelEverywhere == 'N'}
			{block name="footer-sidepanel-left"}
				<aside id="sp-l" class="hidden-print col-xs-12 show-above{if $snackyConfig.scrollSidebox == 'Y'} scrollBoxes{/if}">
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
					<div class="visible-xs visible-sm close-sidebar close-btn"></div>
				</aside>
			{/block}
		{/if}
		{/block}
		{/if}
		
        {block name="productlist-results"}
		{include file="snippets/zonen.tpl" id="before_products" title="before_products"}
		
        <div class="row row-multi {$style}" id="p-l" itemprop="mainEntity" itemscope itemtype="http://schema.org/ItemList">
			{if $Suchergebnisse->GesamtanzahlArtikel >= 20}
            <div id="nfity-scroll">
                <div class="nfy-placeholder"></div>
                <div class="nfy-scroller">
                    <a href="#top">
                        <span class="ar ar-u"></span>
                    </a>
                </div>
            </div>
			{/if}
			{if $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}
				<div class="endless-scrolling text-center block"><button id="view-prev" class="btn btn-xs" data-url="{$oNaviSeite_arr.zurueck->cURL}">Vorherige laden</button></div>
			{/if}
			<span class="pagination-url" data-url="{$smarty.server.REQUEST_URI}"></span>
            {foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}
                <div class="p-w col-xs-6 col-sm-4 col-md-4 col-lg-3 pr{if $snackyConfig.hover_productlist === 'Y' && !$device->isMobile()} hv-e{/if}" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
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
{else}
	{include file="layout/sidebar.tpl"}
{/if}

{block name="footer"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/footer.tpl'}
    {/if}
{/block}