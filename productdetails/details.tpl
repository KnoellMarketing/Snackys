{if isset($boxes)}{* only available in shop versions > 3.19 *}
    {has_boxes position='left' assign='hasLeftBox'}
{/if}
{if !empty($hinweis)}
    {if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
        {include file='productdetails/pushed_success.tpl'}
    {else}
        <div class="alert alert-success">
            {$hinweis}
        </div>
    {/if}
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">
        {$fehler}
    </div>
{/if}
{if !empty($ProdukttagHinweis)}
    <div class="alert alert-success">
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
        {$ProdukttagHinweis}
    </div>
{/if}
{if isset($PositiveFeedback) && count($PositiveFeedback) > 0}
    {foreach name=feedback from=$PositiveFeedback item=Feedback}
        <div class="alert alert-success">{$Feedback}</div>
    {/foreach}
{/if}
{if isset($Artikelhinweise) && count($Artikelhinweise) > 0}
    {foreach name=hinweise from=$Artikelhinweise item=Artikelhinweis}
        <div class="alert alert-danger">{$Artikelhinweis}</div>
    {/foreach}
{/if}


{block name="product-pagination"}
	{if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern)}
		<div id="prevNextRow" class="pr hidden-xs">
			<div class="visible-lg product-pagination previous">
				{if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}
					<a href="{$NavigationBlaettern->vorherigerArtikel->cURL}" title="{$NavigationBlaettern->vorherigerArtikel->cName}">
						<span class="button">
							<span class="ar ar-l"></span>
						</span>
						<span class="img-ct">
							<img src="{$snackyConfig.preloadImage}" data-src="{$NavigationBlaettern->vorherigerArtikel->Bilder[0]->cPfadNormal}" alt="{$NavigationBlaettern->vorherigerArtikel->cName}">
					 	</span>	
					</a>
				{/if}
			</div>
			<h1 class="fn product-title text-center" itemprop="name">{$Artikel->cName}</h1>
			<div class="visible-lg product-pagination next">
				{if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}
					<a href="{$NavigationBlaettern->naechsterArtikel->cURL}" title="{$NavigationBlaettern->naechsterArtikel->cName}">
						<span class="img-ct">
							<img src="{$snackyConfig.preloadImage}" data-src="{$NavigationBlaettern->naechsterArtikel->Bilder[0]->cPfadNormal}" alt="{$NavigationBlaettern->naechsterArtikel->cName}">
						</span>
						<span class="button">
							<span class="ar ar-r"></span>
						</span>
					</a>
				{/if}
			</div>
		</div>
	{/if}
{/block}


{foreach name=navi from=$Brotnavi item=oItem}
	{if $smarty.foreach.navi.total-1 == $smarty.foreach.navi.iteration}
		{assign var=cate value=$oItem->name}
	{/if}
{/foreach}
{include file="snippets/zonen.tpl" id="before_buy_form" title="before_buy_form"}
<form id="buy_form" method="post" action="{$Artikel->cURLFull}" class="evo-validate"
data-track-type="start" data-track-event="view_item" data-track-p-items='[{ldelim}"id":"{if $snackyConfig.artnr == "id"}{$Artikel->kArtikel}{else}{$Artikel->cArtNr}{/if}","category":"{$cate|escape}","name":"{$Artikel->cName|escape}","price":"{$Artikel->Preise->fVKNetto}"{rdelim}]'
>
    {$jtl_token}
    <div class="row product-primary" id="product-offer">
        <div class="product-gallery{if $hasLeftBox} col-sm-5{else} col-sm-6{/if}">
			{include file="snippets/zonen.tpl" id="before_gallery" title="before_gallery"}
            {include file="productdetails/image.tpl"}
			{include file="snippets/zonen.tpl" id="after_gallery" title="after_gallery"}
        </div>
        <div class="product-info{if $hasLeftBox} col-sm-7{else} col-sm-6{/if}">
            {block name="productdetails-info"}
					
				{if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern !== 'Y' && !isset($NavigationBlaettern)}
                <div class="product-headline">
                    {block name="productdetails-info-product-title"}
                    <h1 class="fn product-title" itemprop="name">{$Artikel->cName}</h1>
                    {/block}
                </div>
				{else}
				<div class="product-headline visible-xs">
					<span class="fn product-title h1 block" itemprop="name">{$Artikel->cName}</span>
				</div>
				{/if}

                {block name="productdetails-info-essential-wrapper"}
                {if ($Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0) || isset($Artikel->cArtNr) || ($Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y')}
                    <div class="info-essential row">
                        <div class="col-xs-12 col-sm-12 col-md-8 col-lg-6">
                        {block name="productdetails-info-essential"}
                        {if isset($Artikel->cArtNr) || isset($Artikel->dMHD)}
                            <div class="">
                                <p class="product-sku"><strong>{lang key="sortProductno" section="global"}:</strong> <span itemprop="sku">{$Artikel->cArtNr}</span></p>
                                {if isset($Artikel->dMHD) && isset($Artikel->dMHD_de)}
                                    <p title="{lang key='productMHDTool' section='global'}" class="best-before"><strong>{lang key="productMHD" section="global"}:</strong> <span itemprop="best-before">{$Artikel->dMHD_de}</span></p>
                                {/if}
                            </div>
                        {/if}
						{if isset($Artikel->cBarcode) && !empty($Artikel->cBarcode)}
							{if $Artikel->cBarcode|count_characters == 8}
								<meta itemprop="gtin8" content="{$Artikel->cBarcode}">
							{else if $Artikel->cBarcode|count_characters == 12}
								<meta itemprop="gtin12" content="{$Artikel->cBarcode}">
							{else if $Artikel->cBarcode|count_characters == 13}
								<meta itemprop="gtin13" content="{$Artikel->cBarcode}">
							{/if}
						{/if}

                        {block name="productdetails-info-category-wrapper"}
                        {if $Einstellungen.artikeldetails.artikeldetails_kategorie_anzeigen === 'Y'}
                            {block name="productdetails-info-category"}
                            <p class="product-category word-break">
                                <strong>{lang key="category" section="global"}: </strong>
                                {assign var=i_kat value=$Brotnavi|@count}{assign var=i_kat value=$i_kat-2}
                                <a href="{$Brotnavi[$i_kat]->url}" itemprop="category">{$Brotnavi[$i_kat]->name}</a>
                            </p>
                            {/block}
                        {/if}
                        {/block}   

                        {if ($Einstellungen.bewertung.bewertung_anzeigen === 'Y' && $Artikel->Bewertungen->oBewertungGesamt->nAnzahl > 0)}
                            {block name="productdetails-info-rating-wrapper"}
                            <div class="rating-wrapper" itemprop="aggregateRating" itemscope itemtype="http://schema.org/AggregateRating">
                            <span itemprop="ratingValue"
                                  class="hidden">{$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}</span>
                            <span itemprop="bestRating" class="hidden">5</span>
                            <span itemprop="worstRating" class="hidden">1</span>
                            <span itemprop="reviewCount" class="hidden">{$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}</span>    
                            <strong>{lang key="rating" section="global"}:</strong>
                            <a href="{$Artikel->cURLFull}#tab-votes" id="jump-to-votes-tab" class="hidden-print">
                                {include file='productdetails/rating.tpl' stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt total=$Artikel->Bewertungen->oBewertungGesamt->nAnzahl}
                            </a>
                            </div>{* /rating-wrapper*}
                            {/block}
                        {/if}
                        {/block}
                        </div>
                        <div class="hidden-xs hidden-sm col-md-4 col-lg-6">
                                {block name="productdetails-info-manufacturer-wrapper"}
                                {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'N' && isset($Artikel->cHersteller)}
									<meta itemprop="brand" content="{$Artikel->cHersteller}">
                                    {block name="product-info-manufacturer"}
                                    <div class="manufacturer-row text-right small" itemprop="manufacturer" itemscope itemtype="http://schema.org/Organization">
                                        <a href="{$Artikel->cHerstellerSeo}"{if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'} data-toggle="tooltip" data-placement="left" title="{$Artikel->cHersteller}"{/if} itemprop="url">
                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'Y' && (!empty($Artikel->cBildpfad_thersteller) || $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen === 'B') && isset($Artikel->cHerstellerBildKlein)}
                                                <img src="{$Artikel->cHerstellerBildKlein}" alt="{$Artikel->cHersteller}" class="img-sm">
                                                <meta itemprop="image" content="{$ShopURL}/{$Artikel->cHerstellerBildKlein}">
                                                <meta itemprop="url" content="{$ShopURL}/{$Artikel->cHerstellerSeo}">
                                            {/if}
                                            {if $Einstellungen.artikeldetails.artikeldetails_hersteller_anzeigen !== 'B'}
                                                <span itemprop="name">{$Artikel->cHersteller}</span>
                                            {/if}
                                        </a>
                                    </div>
                                    {/block}
                                {/if}
                                {/block}
                        </div>
                    </div>
                {/if}
                {/block}

                {block name="productdetails-info-description-wrapper"}
                {if $Einstellungen.artikeldetails.artikeldetails_kurzbeschreibung_anzeigen === 'Y' && $Artikel->cKurzBeschreibung}
                    {block name="productdetails-info-description"}
					{include file="snippets/zonen.tpl" id="before_short_desc" title="before_short_desc"}
                    <div class="shortdesc" itemprop="description">
						{if $snackyConfig.optimize_artikel == "Y"}{$Artikel->cKurzBeschreibung|optimize}{else}{$Artikel->cKurzBeschreibung}{/if}
                    </div>
					{include file="snippets/zonen.tpl" id="after_short_desc" title="after_short_desc"}
                    {/block}
                    <div class="clearfix top10"></div>
                {/if}
                {/block}

                <div class="product-offer" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                    <link itemprop="businessFunction" href="http://purl.org/goodrelations/v1#Sell" />
                    {block name="productdetails-info-hidden"}
                    {if !($Artikel->nIstVater)}
                        <link itemprop="url" href="{$Artikel->cURLFull}" />
                    {/if}
                    <input type="submit" name="inWarenkorb" value="1" class="hidden" />
                    {if $Artikel->kArtikelVariKombi > 0}
                        <input type="hidden" name="aK" value="{$Artikel->kArtikelVariKombi}" />
                    {/if}
                    {if isset($Artikel->kVariKindArtikel)}
                        <input type="hidden" name="VariKindArtikel" value="{$Artikel->kVariKindArtikel}" />
                    {/if}
                    {if isset($smarty.get.ek)}
                        <input type="hidden" name="ek" value="{$smarty.get.ek|intval}" />
                    {/if}
                    <input type="hidden" id="AktuellerkArtikel" class="current_article" name="a" value="{$Artikel->kArtikel}" />
                    <input type="hidden" name="wke" value="1" />
                    <input type="hidden" name="show" value="1" />
                    <input type="hidden" name="kKundengruppe" value="{$smarty.session.Kundengruppe->kKundengruppe}" />
                    <input type="hidden" name="kSprache" value="{$smarty.session.kSprache}" />
                    {/block}
                    {block name="productdetails-info-variation"}
                    <!-- VARIATIONEN -->
                    {include file="productdetails/variation.tpl" simple=$Artikel->isSimpleVariation showMatrix=$showMatrix}
                    {/block}
                    <hr>
                    <div class="row buy-wrapper">
                        {block name="productdetails-info-price"}
                        <div class="col-xs-12 col-lg-6">
                            {if isset($Artikel->Preise->strPreisGrafik_Detail)}
                                {assign var=priceImage value=$Artikel->Preise->strPreisGrafik_Detail}
                            {else}
                                {assign var=priceImage value=null}
                            {/if}
                            {include file="productdetails/price.tpl" Artikel=$Artikel price_image=$priceImage tplscope="detail"}

                            <div class="small">
                            {block name="productdetails-info-stock"}
                                {include file="productdetails/stock.tpl"}
                            {/block}
                            </div>
                        </div>
                        <div class="col-xs-12 col-lg-6">
                        {/block}
                            {*WARENKORB anzeigen wenn keine variationen mehr auf lager sind?!*}
                            {include file="productdetails/basket.tpl"}
                        </div>
                    </div>
                    {if isset($varKombiJSON) && $varKombiJSON!= ''}
                    <script id="varKombiArr" type="application/json">{$varKombiJSON}</script>
                    {/if}
                    <hr>
                </div>

                {if !($Artikel->nIstVater && $Artikel->kVaterArtikel == 0)}
                    {include file="productdetails/actions.tpl"}
                {/if}
            {/block}{* productdetails-info *}
			{include file="snippets/zonen.tpl" id="after_product_info" title="after_product_info"}
			
			
			{block name="details-matrix"}
			{include file="productdetails/matrix.tpl"}
			{/block}
        </div>{* /col *}
        {if $Artikel->bHasKonfig}
            {block name="productdetails-config"}
            <div id="product-configurator" class="col-sm-12">
                <div class="product-config top10">
                    {*KONFIGURATOR*}
                    {if isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELKONFIG_TPL]) && file_exists("tpl_inc/{$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELKONFIG_TPL]}")}
                        {include file='tpl_inc/'|cat:$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELKONFIG_TPL]}
                    {else}
                        {include file="productdetails/config.tpl"}
                    {/if}
                </div>
            </div>
            {/block}
        {/if}
    </div>{* /row *}
</form>
	{if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
		<div class="modal fade" id="pp-question_on_item" tabindex="-1" role="dialog" aria-labelledby="pp-question_on_item-label" aria-hidden="true">
		  <div class="modal-dialog" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<h5 class="modal-title" id="pp-question_on_item-label">{lang key='productQuestion' section='productDetails'}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				</button>
			  </div>
			  <div class="modal-body">
				{include file='productdetails/question_on_item.tpl'}
			  </div>
			</div>
		  </div>
		</div>
	{/if}
	{if ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y' && $Artikel->cLagerKleinerNull !== 'Y'}
		<div class="modal fade" id="pp-availability_notification" tabindex="-1" role="dialog" aria-labelledby="pp-availability_notification-label" aria-hidden="true">
		  <div class="modal-dialog" role="document">
			<div class="modal-content">
			  <div class="modal-header">
				<h5 class="modal-title" id="pp-availability_notification-label">{lang key='requestNotification'}</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
				</button>
			  </div>
			  <div class="modal-body">
				{include file='productdetails/availability_notification_form.tpl'}
			  </div>
			</div>
		  </div>
		</div>
	{/if}
{if !isset($smarty.get.quickView) || $smarty.get.quickView != 1}
    <div class="clearfix"></div>

    {block name="details-tabs"}
	{$tabanzeige = $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen !== 'N'}
	{if $tabanzeige}
    	{include file="productdetails/tabs.tpl"}
	{else}	
    	{include file="productdetails/tabs_blank.tpl"}
	{/if}
    {/block}

    <div class="clearfix"></div>

    {*SLIDERS*}
    {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0
        || isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen == 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0
        || isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0
        || isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0
        || isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
        <hr>
        {if isset($Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen) && $Einstellungen.artikeldetails.artikeldetails_stueckliste_anzeigen === 'Y' && isset($Artikel->oStueckliste_arr) && $Artikel->oStueckliste_arr|@count > 0}
            <div class="partslist">
				<hr class="invisible">
                {lang key='listOfItems' section='global' assign='slidertitle'}
                {include file='productdetails/stueckliste.tpl' id='slider-partslist' productlist=$Artikel->oStueckliste_arr title=$slidertitle showPartsList=true}
            </div>
        {/if}

        {if isset($Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen) && $Einstellungen.artikeldetails.artikeldetails_produktbundle_nutzen == 'Y' && isset($Artikel->oProduktBundle_arr) && $Artikel->oProduktBundle_arr|@count > 0}
            <div class="bundle">
                {include file="productdetails/bundle.tpl" ProductKey=$Artikel->kArtikel Products=$Artikel->oProduktBundle_arr ProduktBundle=$Artikel->oProduktBundlePrice ProductMain=$Artikel->oProduktBundleMain}
            </div>
        {/if}

        {if isset($Xselling->Standard) || isset($Xselling->Kauf) || isset($oAehnlicheArtikel_arr)}
            <div class="recommendations hidden-print">
                
            {block name="productdetails-recommendations"}
            {if isset($Xselling->Standard->XSellGruppen) && count($Xselling->Standard->XSellGruppen) > 0}
                {foreach name=Xsell_gruppen from=$Xselling->Standard->XSellGruppen item=Gruppe}
                    {include file='snippets/product_slider.tpl' class='x-supplies' id='slider-xsell-group-'|cat:$smarty.foreach.Xsell_gruppen.iteration productlist=$Gruppe->Artikel title=$Gruppe->Name}
                {/foreach}
            {/if}

            {if isset($Xselling->Kauf->Artikel) && count($Xselling->Kauf->Artikel) > 0}
                {lang key='customerWhoBoughtXBoughtAlsoY' section='productDetails' assign='slidertitle'}
                {include file='snippets/product_slider.tpl' class='x-sell' id='slider-xsell' productlist=$Xselling->Kauf->Artikel title=$slidertitle}
            {/if}
            {/block}
            </div>
        {/if}
    {/if}
    <div id="article_popups">
        {include file='productdetails/popups.tpl'}
    </div>
{/if}