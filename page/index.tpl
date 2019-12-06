{if !empty($cFehler)}
    <div class="alert alert-danger">{$cFehler}</div>
{/if}
    {load_boxes_raw type='top' assign='arrBoxTop' array=true}
    {if isset($arrBoxTop) && count($arrBoxTop) > 0}
        <div id="start-boxes" class="mb-spacer">
            <div class="row">
                {foreach name=bottomBoxes from=$arrBoxTop item=box}
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
                {/foreach}
            </div>
        </div>
	{/if}

{include file="productwizard/index.tpl"}

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
{if $Einstellungen.template.homepage.manSlider == 0}
<section class="panel panel-default panel-slider mb-spacer" id="hersteller-slider">
	<div class="panel-heading">
		<div class="panel-title">
		   <h2 class="h2">{lang key="manufacturers" section="global"}</h2>
			<div class="right">
				<div class="arrow-container btn-group"></div>
			</div>
		</div>
	</div>
	<div class="panel-body">
		<div class="arrow-container-box"></div>
		<div class="row product-slider preload{if isset($isBox)} sidebar{/if}">
			{foreach name=hersteller from=$manufacturers item=hst}
				<div class="col-lg-2 product-cell">
					<div class="image-wrapper text-center">
						<a href="{$hst->cSeo}" class="image-content"><img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$hst->cBildpfadNormal}" class=image alt="{$hst->cName|escape:'html'}"></a>
					</div>
					<div class="caption">
						<h4 class="title"><a href="{$hst->cSeo}"><span>{$hst->cName}</span></a></h4>
					</div>
				</div>{* /category-wrapper *}
			{/foreach}
		</div>
	</div>
</section>
{/if}
{block name="index-additional"}
{if isset($oNews_arr) && $oNews_arr|@count > 0}
    <section class="panel-default mb-spacer" id="news-overview">
         <div class="panel-heading">
            <div class="panel-title">
                <h2>{lang key="news" section="news"}</h2>
                <a href="{get_static_route id='news.php'}" title="{lang key="news" section="news"}" class="btn btn-primary">
                    {lang key="showAll" section="global"}
                </a>
             </div>
        </div>
        <div class="row panel-body" id="newslist">
            {foreach name=news from=$oNews_arr item=oNewsUebersicht}
                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-4 preload">
                {include file="blog/preview.tpl"}
                </div>
            {/foreach}
        </div>
    </section>
{/if}
{/block}