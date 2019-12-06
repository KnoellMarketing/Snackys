{include file="snippets/zonen.tpl" id="start-under-slider" title="Startseite: Unter dem Slider"}

{if !empty($cFehler)}
    <div class="alert alert-danger">{$cFehler}</div>
{/if}
	{if $isShopFive}
		{getBoxesByPosition position='top' assign='arrBoxTop'}
	{else}
		{load_boxes_raw type='top' assign='arrBoxTop' array=true}
	{/if}
    {if isset($arrBoxTop) && count($arrBoxTop) > 0}
        <div id="start-boxes" class="mb-spacer">
            <div class="row">
                {foreach name=bottomBoxes from=$arrBoxTop item=box}
					{if $isShopFive}
						<div class="{block name='footer-boxes-class'}col-xs-6 col-sm-6 col-md-3 col-lg-4{/block}">
							{$box->getRenderedContent()}
						</div>
					{else}
						{if ($box.obj->kBoxvorlage != 0 && $box.obj->anzeigen === 'Y' ) ||
						($box.obj->kBoxvorlage == 0 && !empty($box.obj->oContainer_arr))}
							<div class="{block name="footer-boxes-class"}col-xs-6 col-sm-6 col-md-3 col-lg-4{/block}">
								{if isset($box.obj) && isset($box.tpl)}
									{if $smarty.foreach.bottomBoxes.iteration < 10}
										{assign var=oBox value=$box.obj}
										{include file=$box.tpl}
									{/if}
								{/if}
							</div>
						{/if}
					{/if}
                {/foreach}
            </div>
        </div>
	{/if}

{include file="productwizard/index.tpl"}

{include file="snippets/zonen.tpl" id="before_boxes" title="Startseite: Vor den Artikelslidern"}
{if isset($StartseiteBoxen) && $StartseiteBoxen|@count > 0}
    {assign var='moreLink' value=null}
    {assign var='moreTitle' value=null}
    {foreach name=startboxen from=$StartseiteBoxen item=Box}
        {if isset($Box->Artikel->elemente) && count($Box->Artikel->elemente)>0 && isset($Box->cURL)}
            {if $Box->name === 'TopAngebot'}
                {lang key="topOffer" section="global" assign='title'}
                {lang key='showAllTopOffers' section='global' assign='moreTitle'}
            {elseif $Box->name === 'Sonderangebote'}
                {lang key="specialOffer" section="global" assign='title'}
                {lang key='showAllSpecialOffers' section='global' assign='moreTitle'}
            {elseif $Box->name === 'NeuImSortiment'}
                {lang key="newProducts" section="global" assign='title'}
                {lang key='showAllNewProducts' section='global' assign='moreTitle'}
            {elseif $Box->name === 'Bestseller'}
                {lang key="bestsellers" section="global" assign='title'}
                {lang key='showAllBestsellers' section='global' assign='moreTitle'}
            {/if}
            {assign var='moreLink' value=$Box->cURL}
            {include file='snippets/product_slider.tpl' productlist=$Box->Artikel->elemente title=$title hideOverlays=true moreLink=$moreLink moreTitle=$moreTitle}
        {/if}
    {/foreach}
{/if}
{if $snackyConfig.manSlider == 0}
<section class="panel panel-default panel-slider mb-spacer" id="man-sl">
	<div class="panel-heading">
		<div class="panel-title dpflex-a-center dpflex-j-between mb-spacer mb-small">
		   <span class="h2 m0 block">{lang key="manufacturers" section="global"}</span>
			<div class="right">
				{if !$device->isMobile()}
					<div class="ar-ct btn-group{if $manufacturers|@count > 8} show-xl{/if}{if $manufacturers|@count > 6} show-lg{/if}{if $manufacturers|@count > 4} show-md{/if}{if $manufacturers|@count > 4} show-sm{/if}{if $manufacturers|@count > 3} show-xs{/if}{if $manufacturers|@count > 2} show-xxs{/if}">
						<span class="sl-ar sl-pr btn inactive">
							<span class="ar ar-l"></span>
						</span>
						<span class="sl-ar sl-nx btn">
							<span class="ar ar-r"></span>
						</span>
					</div>
				{/if}
			</div>
		</div>
	</div>
	<div class="panel-body">
		{if $device->isMobile() || $tplscope === 'box'}
		<div class="row ar-ct-m">
			<div class="col-xs-12 ar-ct{if $manufacturers|@count > 8} show-xl{/if}{if $manufacturers|@count > 6} show-lg{/if}{if $manufacturers|@count > 4} show-md{/if}{if $manufacturers|@count > 4} show-sm{/if}{if $manufacturers|@count > 3} show-xs{/if}{if $manufacturers|@count > 2} show-xxs{/if}">
				<span class="sl-ar sl-pr btn inactive">
					<span class="ar ar-l"></span>
				</span>
				<span class="sl-ar sl-nx btn">
					<span class="ar ar-r"></span>
				</span>
			</div>
		</div>
		{/if}
		<div class="row p-sl no-scrollbar dpflex-nowrap">
			{foreach name=hersteller from=$manufacturers item=hst}
				<div class="col-lg-2 p-w">
					<div class="p-c">
						<div class="img-w text-center">
							<a href="{$hst->cSeo}" class="img-ct"><img src="{$snackyConfig.preloadImage}" data-src="{$hst->cBildpfadNormal}" class=image alt="{$hst->cName|escape:'html'}"></a>
						</div>
						{if !$device->isMobile()}
						<div class="caption h5 text-center">
							<a href="{$hst->cSeo}"><span>{$hst->cName}</span></a>
						</div>
						{/if}
					</div>{* /category-wrapper *}
				</div>
			{/foreach}
		</div>
	</div>
</section>{* /panel *}
{/if}
{block name="index-additional"}
{if isset($oNews_arr) && $oNews_arr|@count > 0}
{include file="snippets/zonen.tpl" id="before_news" title="Startseite: Vor den News"}
    <section class="panel-default mb-spacer" id="news-overview">
         <div class="panel-heading">
            <div class="panel-title dpflex-a-center dpflex-j-between mb-spacer mb-small">
                <span class="block h2 m0">{lang key="news" section="news"}</span>
                <a href="{get_static_route id='news.php'}" title="{lang key="news" section="news"}" class="btn btn-primary">
                    {lang key="showAll" section="global"}
                </a>
             </div>
        </div>
        <div class="row panel-body" id="newslist">
            {foreach name=news from=$oNews_arr item=oNewsUebersicht}
                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-4 pr">
                {include file="blog/preview.tpl"}
                </div>
            {/foreach}
        </div>
    </section>
{/if}
{/block}