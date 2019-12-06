{if $Suchergebnisse->Artikel->elemente|@count > 0}
    {if $Einstellungen.navigationsfilter.allgemein_tagfilter_benutzen === 'Y'}
        {if $Suchergebnisse->Tags|@count > 0 && $Suchergebnisse->TagsJSON}
            <div class="panel panel-default tags tags-list">
                <div class="panel-heading"><h3 class="panel-title">{lang key="productsTaggedAs" section="productOverview"}</h3></div>
                <div class="panel-body">
                    {foreach name=tagfilter from=$Suchergebnisse->Tags item=oTag}
                        <a href="{$oTag->cURL}" class="btn btn-xs badge tag{$oTag->Klasse}">{$oTag->cName}</a>
                    {/foreach}
                </div>
            </div>
        {/if}
    {/if}

    {if $Einstellungen.navigationsfilter.suchtrefferfilter_nutzen === 'Y'}
        {if $Suchergebnisse->SuchFilter|@count > 0 && $Suchergebnisse->SuchFilterJSON}
            {if empty($NaviFilter->SuchFilter->kSuchanfrage)}
                <div class="panel panel-default tags tags-list">
                    <div class="panel-heading"><h3 class="panel-title">{lang key="productsSearchTerm" section="productOverview"}</h3></div>
                    <div class="panel-body">
                        {foreach name=suchfilter from=$Suchergebnisse->SuchFilter item=oSuchFilter}
                            <a href="{$oSuchFilter->cURL}" class="btn btn-xs badge tag{$oSuchFilter->Klasse}">{$oSuchFilter->cSuche}</a>
                        {/foreach}
                    </div>
                </div>
            {/if}
        {/if}
    {/if}
{/if}

{if $Suchergebnisse->Seitenzahlen->maxSeite > 1 && !empty($oNaviSeite_arr) && $oNaviSeite_arr|@count > 0}
    <div class="row">
        <div class="col-xs-12">
            <ul class="pagination pagination-ajax">
                {if $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}
                    <li class="prev">
                        <a href="{$oNaviSeite_arr.zurueck->cURL}">&laquo; {lang key="previous" section="productOverview"}</a>
                    </li>
                {/if}

                {foreach name=seite from=$oNaviSeite_arr item=oNaviSeite}
                    {if !isset($oNaviSeite->nBTN)}
                        <li class="page {if !isset($oNaviSeite->cURL) || $oNaviSeite->cURL|strlen === 0}active{/if}">
                            {if !empty($oNaviSeite->cURL)}
                                <a href="{$oNaviSeite->cURL}">{$oNaviSeite->nSeite}</a>
                            {else}
                                <a href="#" onclick="return false;">{$oNaviSeite->nSeite}</a>
                            {/if}
                        </li>
                    {/if}
                {/foreach}

                {if $Suchergebnisse->Seitenzahlen->AktuelleSeite < $Suchergebnisse->Seitenzahlen->maxSeite}
                    {*
                    <li>
                        .. {lang key="of" section="productOverview"} {$Suchergebnisse->Seitenzahlen->MaxSeiten}
                    </li>
                    *}
                    <li class="next">
                        <a href="{$oNaviSeite_arr.vor->cURL}">{lang key="next" section="productOverview"} &raquo;</a>
                    </li>
                {/if}
            </ul>
        </div>
        <div class="col-xs-6 col-md-4 col-lg-3 text-right">
            <form action="navi.php" method="get" class="form-inline pagination">
                {$jtl_token}
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
                    <input type="hidden" name="t" value="{$NaviFilter->Tag->kTag}" />
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
                {if !empty($NaviFilter->TagFilter)}
                    {foreach name=tagfilter from=$NaviFilter->TagFilter item=tag}
                        <input type="hidden" name="tf{$smarty.foreach.tagfilter.iteration}" value="{$tag->kTag}" />
                    {/foreach}
                {/if}
                {*<div class="dropdown">
                    <button class="btn btn-default dropdown-toggle" type="button" id="pagination-dropdown" data-toggle="dropdown" aria-expanded="true">
                        {lang key="goToPage" section="productOverview"}
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu pagination-ajax" role="menu" aria-labelledby="pagination-dropdown">
                        {foreach name=seite from=$oNaviSeite_arr item=oNaviSeite}
                            {if !isset($oNaviSeite->nBTN)}
                                {if $oNaviSeite->nSeite == $Suchergebnisse->Seitenzahlen->AktuelleSeite}
                                    <li class="active">
                                        <a role="menuitem" class="disabled" href="{$oNaviSeite->cURL}">{$oNaviSeite->nSeite}</a>
                                    </li>
                                {else}
                                    <li>
                                        <a role="menuitem" tabindex="-1" href="{$oNaviSeite->cURL}">{$oNaviSeite->nSeite}</a>
                                    </li>
                                {/if}
                            {/if}
                        {/foreach}
                    </ul>
                </div>*}
            </form>
        </div>
    </div>
{/if}



{if isset($oNavigationsinfo->oKategorie->categoryAttributes.seo_longtext)}
	<div class="item_desc custom_content">
		{if $snackyConfig.optimize_kategorie == "Y"}{$oNavigationsinfo->oKategorie->categoryAttributes.seo_longtext->cWert|optimize}{else}{$oNavigationsinfo->oKategorie->categoryAttributes.seo_longtext->cWert}{/if}
	</div>
{/if}