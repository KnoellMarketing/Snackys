{if !isset($oNavigationsinfo) || isset($Suchergebnisse) && isset($oNavigationsinfo) && empty($oNavigationsinfo->cName)}
<div class="title dpflex-a-center dpflex-j-between mb-spacer mb-small">
    <h1 class="m0">{$Suchergebnisse->SuchausdruckWrite}</h1>
	
        <div class="right dpflex-a-center">
            {if count($Suchergebnisse->Artikel->elemente) > 0}
                <form id="improve_search" action="navi.php" method="get" class="form-inline clearfix">
                    {if isset($NaviFilter->Kategorie->kKategorie) && $NaviFilter->Kategorie->kKategorie > 0}
                        <input type="hidden" name="k" value="{$NaviFilter->Kategorie->kKategorie}" />{/if}
                    {if isset($NaviFilter->Hersteller->kHersteller) && $NaviFilter->Hersteller->kHersteller > 0}
                        <input type="hidden" name="h" value="{$NaviFilter->Hersteller->kHersteller}" />{/if}
                    {if isset($NaviFilter->Suchanfrage->kSuchanfrage) && $NaviFilter->Suchanfrage->kSuchanfrage > 0}
                        <input type="hidden" name="l" value="{$NaviFilter->Suchanfrage->kSuchanfrage}" />{/if}
                    {if isset($NaviFilter->MerkmalWert->kMerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert > 0}
                        <input type="hidden" name="m" value="{$NaviFilter->MerkmalWert->kMerkmalWert}" />{/if}
                    {if isset($NaviFilter->Suchspecial->kKey) && $NaviFilter->Suchspecial->kKey > 0}
                        <input type="hidden" name="q" value="{$NaviFilter->Suchspecial->kKey}" />{/if}
                    {if isset($NaviFilter->Suche->cSuche) && $NaviFilter->Suche->cSuche|strlen > 0}
                        <input type="hidden" name="suche" value="{$NaviFilter->Suche->cSuche|escape:'htmlall'}" />{/if}
                    {if isset($NaviFilter->Tag->kTag) && $NaviFilter->Tag->kTag > 0}
                        <input type="hidden" name="t" value="{$NaviFilter->Tag->kTag}" />{/if}
                    {*Suchergebnisfilter*}
                    {if isset($NaviFilter->KategorieFilter->kKategorie) && $NaviFilter->KategorieFilter->kKategorie > 0}
                        <input type="hidden" name="kf" value="{$NaviFilter->KategorieFilter->kKategorie}" />{/if}
                    {if isset($NaviFilter->HerstellerFilter->kHersteller) && $NaviFilter->HerstellerFilter->kHersteller > 0}
                        <input type="hidden" name="hf" value="{$NaviFilter->HerstellerFilter->kHersteller}" />{/if}
                    {if isset($NaviFilter->SuchspecialFilter->kKey) && $NaviFilter->SuchspecialFilter->kKey > 0}
                        <input type="hidden" name="qf" value="{$NaviFilter->SuchspecialFilter->kKey}" />{/if}
                    {if isset($NaviFilter->BewertungFilter->nSterne) && $NaviFilter->BewertungFilter->nSterne > 0}
                        <input type="hidden" name="bf" value="{$NaviFilter->BewertungFilter->nSterne}" />{/if}
                    {if !empty($NaviFilter->PreisspannenFilter->cWert)}
                        <input type="hidden" name="pf" value="{$NaviFilter->PreisspannenFilter->cWert}" />{/if}
                    {if isset($NaviFilter->MerkmalFilter) && is_array($NaviFilter->MerkmalFilter)}
                        {foreach name=merkmalfilter from=$NaviFilter->MerkmalFilter item=mmfilter}
                            <input type="hidden" name="mf{$smarty.foreach.merkmalfilter.iteration}" value="{$mmfilter->kMerkmalWert}" />
                        {/foreach}
                    {/if}
                    {if isset($cJTLSearchStatedFilter_arr) && is_array($cJTLSearchStatedFilter_arr)}
                        {foreach name=jtlsearchstatedfilter from=$cJTLSearchStatedFilter_arr key=key item=cJTLSearchStatedFilter}
                            <input name="fq{$key}" type="hidden" value="{$cJTLSearchStatedFilter}" />
                        {/foreach}
                    {/if}
                    {if isset($NaviFilter->TagFilter) && is_array($NaviFilter->TagFilter)}
                        {foreach name=tagfilter from=$NaviFilter->TagFilter item=tag}
                            <input type="hidden" name="tf{$smarty.foreach.tagfilter.iteration}" value="{$tag->kTag}" />
                        {/foreach}
                    {/if}
                    {if isset($NaviFilter->SuchFilter) && is_array($NaviFilter->SuchFilter)}
                        {foreach name=suchfilter from=$NaviFilter->SuchFilter item=oSuche}
                            <input type="hidden" name="sf{$smarty.foreach.suchfilter.iteration}" value="{$oSuche->kSuchanfrage}" />
                        {/foreach}
                    {/if}
                    {include file='productlist/result_options.tpl'}
                </form>
            {/if}
		{if $hasFilters == "true"}
        <div class="visible-xs visible-sm pr" id="ftr-tg">
			<div class="img-ct icon">
				<svg class="{if isset($darkHead) && isset($darkMode) && ($darkHead == 'true' || $darkMode == 'true')}icon-darkmode{/if}">
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-filter"></use>
				</svg>
			</div>
		</div>
		{/if}
        </div> 
</div>
{/if}

{if !empty($hinweis)}
    <div class="alert alert-success">{$hinweis}</div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">{$fehler}</div>
{/if}

{if isset($Suchergebnisse->SucheErfolglos) && $Suchergebnisse->SucheErfolglos == 1}
	{include file="snippets/zonen.tpl" id="before_no_results" title="before_no_results"}
    <div class="alert alert-info">{lang key="noResults" section="productOverview"}</div>
    <form id="suche2" action="navi.php" method="get" class="form mb-spacer mb-small">
        <fieldset>
            <div class="form-group">
                <label for="searchkey">{lang key="searchText" section="global"}</label>
                <div class="dpflex">
                    <input type="search" class="form-control" name="suchausdruck" value="{if isset($Suchergebnisse->cSuche)}{$Suchergebnisse->cSuche|escape:'htmlall'}{/if}" id="searchkey" minlength="{$Einstellungen.artikeluebersicht.suche_min_zeichen}" />
                    <input type="submit" value="{lang key="searchAgain" section="productOverview"}" class="submit btn btn-primary" />
                </div>
            </div>
        </fieldset>
    </form>
{/if}

{include file="snippets/extension.tpl"}
{block name="productlist-header"}
{if isset($oNavigationsinfo->cName) && $oNavigationsinfo->cName !== '' || isset($oNavigationsinfo->cBildURL) && !empty($oNavigationsinfo->cBildURL)}
    <div class="title dpflex-a-center dpflex-j-between mb-spacer mb-small">
		{if isset($oNavigationsinfo->oKategorie->categoryAttributes.seo_name)}<h1>{$oNavigationsinfo->oKategorie->categoryAttributes.seo_name->cWert}</h1>
        {elseif $oNavigationsinfo->cName}<h1 class="m0">{$oNavigationsinfo->cName}</h1>{/if}
        <div class="right dpflex-a-center">
            {if count($Suchergebnisse->Artikel->elemente) > 0}
                <form id="improve_search" action="navi.php" method="get" class="form-inline clearfix">
                    {if isset($NaviFilter->Kategorie->kKategorie) && $NaviFilter->Kategorie->kKategorie > 0}
                        <input type="hidden" name="k" value="{$NaviFilter->Kategorie->kKategorie}" />{/if}
                    {if isset($NaviFilter->Hersteller->kHersteller) && $NaviFilter->Hersteller->kHersteller > 0}
                        <input type="hidden" name="h" value="{$NaviFilter->Hersteller->kHersteller}" />{/if}
                    {if isset($NaviFilter->Suchanfrage->kSuchanfrage) && $NaviFilter->Suchanfrage->kSuchanfrage > 0}
                        <input type="hidden" name="l" value="{$NaviFilter->Suchanfrage->kSuchanfrage}" />{/if}
                    {if isset($NaviFilter->MerkmalWert->kMerkmalWert) && $NaviFilter->MerkmalWert->kMerkmalWert > 0}
                        <input type="hidden" name="m" value="{$NaviFilter->MerkmalWert->kMerkmalWert}" />{/if}
                    {if isset($NaviFilter->Suchspecial->kKey) && $NaviFilter->Suchspecial->kKey > 0}
                        <input type="hidden" name="q" value="{$NaviFilter->Suchspecial->kKey}" />{/if}
                    {if isset($NaviFilter->Suche->cSuche) && $NaviFilter->Suche->cSuche|strlen > 0}
                        <input type="hidden" name="suche" value="{$NaviFilter->Suche->cSuche|escape:'htmlall'}" />{/if}
                    {if isset($NaviFilter->Tag->kTag) && $NaviFilter->Tag->kTag > 0}
                        <input type="hidden" name="t" value="{$NaviFilter->Tag->kTag}" />{/if}
                    {*Suchergebnisfilter*}
                    {if isset($NaviFilter->KategorieFilter->kKategorie) && $NaviFilter->KategorieFilter->kKategorie > 0}
                        <input type="hidden" name="kf" value="{$NaviFilter->KategorieFilter->kKategorie}" />{/if}
                    {if isset($NaviFilter->HerstellerFilter->kHersteller) && $NaviFilter->HerstellerFilter->kHersteller > 0}
                        <input type="hidden" name="hf" value="{$NaviFilter->HerstellerFilter->kHersteller}" />{/if}
                    {if isset($NaviFilter->SuchspecialFilter->kKey) && $NaviFilter->SuchspecialFilter->kKey > 0}
                        <input type="hidden" name="qf" value="{$NaviFilter->SuchspecialFilter->kKey}" />{/if}
                    {if isset($NaviFilter->BewertungFilter->nSterne) && $NaviFilter->BewertungFilter->nSterne > 0}
                        <input type="hidden" name="bf" value="{$NaviFilter->BewertungFilter->nSterne}" />{/if}
                    {if !empty($NaviFilter->PreisspannenFilter->cWert)}
                        <input type="hidden" name="pf" value="{$NaviFilter->PreisspannenFilter->cWert}" />{/if}
                    {if isset($NaviFilter->MerkmalFilter) && is_array($NaviFilter->MerkmalFilter)}
                        {foreach name=merkmalfilter from=$NaviFilter->MerkmalFilter item=mmfilter}
                            <input type="hidden" name="mf{$smarty.foreach.merkmalfilter.iteration}" value="{$mmfilter->kMerkmalWert}" />
                        {/foreach}
                    {/if}
                    {if isset($cJTLSearchStatedFilter_arr) && is_array($cJTLSearchStatedFilter_arr)}
                        {foreach name=jtlsearchstatedfilter from=$cJTLSearchStatedFilter_arr key=key item=cJTLSearchStatedFilter}
                            <input name="fq{$key}" type="hidden" value="{$cJTLSearchStatedFilter}" />
                        {/foreach}
                    {/if}
                    {if isset($NaviFilter->TagFilter) && is_array($NaviFilter->TagFilter)}
                        {foreach name=tagfilter from=$NaviFilter->TagFilter item=tag}
                            <input type="hidden" name="tf{$smarty.foreach.tagfilter.iteration}" value="{$tag->kTag}" />
                        {/foreach}
                    {/if}
                    {if isset($NaviFilter->SuchFilter) && is_array($NaviFilter->SuchFilter)}
                        {foreach name=suchfilter from=$NaviFilter->SuchFilter item=oSuche}
                            <input type="hidden" name="sf{$smarty.foreach.suchfilter.iteration}" value="{$oSuche->kSuchanfrage}" />
                        {/foreach}
                    {/if}
                    {include file='productlist/result_options.tpl'}
                </form>
            {/if}
		{if $hasFilters == "true"}
        <div class="visible-xs visible-sm pr" id="ftr-tg">
			<div class="img-ct icon">
				<svg class="{if isset($darkHead) && isset($darkMode) && ($darkHead == 'true' || $darkMode == 'true')}icon-darkmode{/if}">
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-filter"></use>
				</svg>
			</div>
		</div>
		{/if}
        </div> 
    </div>
    <div class="desc text-lg clearfix mb-spacer mb-small{if !empty($oNavigationsinfo->cBildURL) && $oNavigationsinfo->cBildURL !== 'gfx/keinBild.gif' && $oNavigationsinfo->cBildURL !== 'gfx/keinBild_kl.gif'} row{/if}">
        {if !empty($oNavigationsinfo->cBildURL) && $oNavigationsinfo->cBildURL !== 'gfx/keinBild.gif' && $oNavigationsinfo->cBildURL !== 'gfx/keinBild_kl.gif'}
		<div class="col-xs-6 col-sm-3 col-md-4 col-lg-2 product-border">
          <div class="img-ct">
            <img class="img-responsive" data-src="{$oNavigationsinfo->cBildURL}" src="{$snackyConfig.preloadImage}" alt="{if isset($oNavigationsinfo->oKategorie->cBeschreibung)}{$oNavigationsinfo->oKategorie->cBeschreibung|strip_tags|truncate:40|escape:"html"}{elseif isset($oNavigationsinfo->oHersteller->cBeschreibung)}{$oNavigationsinfo->oHersteller->cBeschreibung|strip_tags|truncate:40|escape:"html"}{/if}" />
          </div>
		</div>
        {/if}
		{if !empty($oNavigationsinfo->cBildURL) && $oNavigationsinfo->cBildURL !== 'gfx/keinBild.gif' && $oNavigationsinfo->cBildURL !== 'gfx/keinBild_kl.gif'}
		<div class="col-xs-12 col-sm-9 col-md-8 col-lg-10">
		{/if}
        {if $Einstellungen.navigationsfilter.kategorie_beschreibung_anzeigen === 'Y'
            && isset($oNavigationsinfo->oKategorie) && $oNavigationsinfo->oKategorie->cBeschreibung|strlen > 0
            && $Einstellungen.navigationsfilter.kategorie_bild_anzeigen !== 'B'}
            <div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->oKategorie->cBeschreibung|optimize}{else}{$oNavigationsinfo->oKategorie->cBeschreibung}{/if}</div>
        {/if}
        {if $Einstellungen.navigationsfilter.hersteller_beschreibung_anzeigen === 'Y'
            && isset($oNavigationsinfo->oHersteller) && $oNavigationsinfo->oHersteller->cBeschreibung|strlen > 0
            && $Einstellungen.navigationsfilter.hersteller_bild_anzeigen !== 'B'}
            <div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->oHersteller->cBeschreibung|optimize}{else}{$oNavigationsinfo->oHersteller->cBeschreibung}{/if}</div>
        {/if}
        {if $Einstellungen.navigationsfilter.merkmalwert_beschreibung_anzeigen === 'Y'
            && isset($oNavigationsinfo->oMerkmalWert) && $oNavigationsinfo->oMerkmalWert->cBeschreibung|strlen > 0
            && $Einstellungen.navigationsfilter.merkmalwert_bild_anzeigen !== 'B'}
            <div class="item_desc custom_content">{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->oMerkmalWert->cBeschreibung|optimize}{else}{$oNavigationsinfo->oMerkmalWert->cBeschreibung}{/if}</div>
        {/if}
		{if !empty($oNavigationsinfo->cBildURL) && $oNavigationsinfo->cBildURL !== 'gfx/keinBild.gif' && $oNavigationsinfo->cBildURL !== 'gfx/keinBild_kl.gif'}
		</div>
		{/if}
    </div>
{/if}
{/block}

{block name="productlist-subcategories"}
{if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'N' && $oUnterKategorien_arr|@count > 0}
	{include file="snippets/zonen.tpl" id="before_subcategories" title="before_subcategories"}
    <div class="row row-multi sc-w mb-spacer mb-small">
        {foreach name=unterkats from=$oUnterKategorien_arr item=Unterkat}
            <div class="col-xs-6 col-sm-4 col-md-4 col-lg-3 col-xl-2">
                <div class="thumbnail">
                    {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'Y'}
                    <a href="{$Unterkat->cURL}" class="block img-w">
                            <div class="img-ct">
							{if $viewportImages < 4}
								<img src="{$Unterkat->cBildURL}" alt="{$Unterkat->cName}"/>
								{assign var=viewportImages value=$viewportImages+1 scope="global"}
							{else}
								<img src="{$snackyConfig.preloadImage}" data-src="{$Unterkat->cBildURL}" alt="{$Unterkat->cName}"/>
							{/if}
                            </div>
                    </a>
                    {/if}
                    {if $Einstellungen.navigationsfilter.artikeluebersicht_bild_anzeigen !== 'B'}
                        <a href="{$Unterkat->cURL}" class="h5 m0 title">
                            {$Unterkat->cName}
                        </a>
                    {/if}
                    {if $Einstellungen.navigationsfilter.unterkategorien_beschreibung_anzeigen === 'Y' && !empty($Unterkat->cBeschreibung)}
                        <p class="item_desc small text-muted">{$Unterkat->cBeschreibung|strip_tags|truncate:68}</p>
                    {/if}
                    {if $Einstellungen.navigationsfilter.unterkategorien_lvl2_anzeigen === 'Y'}
                        {if isset($Unterkat->Unterkategorien) && $Unterkat->Unterkategorien|@count > 0}
                            <hr class="hr-sm">
                            <ul class="blanklist">
                                {foreach from=$Unterkat->Unterkategorien item=UnterUnterKat}
                                    <li>
                                        <a href="{$UnterUnterKat->cURL}" title="{$UnterUnterKat->cName}" class="defaultlink">{$UnterUnterKat->cName}</a>
                                    </li>
                                {/foreach}
                            </ul>
                        {/if}
                    {/if}
                </div>
            </div>
        {/foreach}
    </div>
{/if}
{/block}

{include file="productwizard/index.tpl"}



{* if $Suchergebnisse->GesamtanzahlArtikel > 0}
    <div class="row list-pageinfo top10 visible-xs">
        <div class="col-xs-6 col-sm-4 page-current">
            <strong>{lang key="page" section="productOverview"} {$Suchergebnisse->Seitenzahlen->AktuelleSeite}</strong> {lang key="of" section="productOverview"} {$Suchergebnisse->Seitenzahlen->MaxSeiten}
        </div>
        <div class="col-xs-6 col-sm-8 page-total text-right">
            {lang key="products" section="global"} {$Suchergebnisse->ArtikelVon} - {$Suchergebnisse->ArtikelBis} {lang key="of" section="productOverview"} {$Suchergebnisse->GesamtanzahlArtikel}
        </div>
    </div>
{/if *}
