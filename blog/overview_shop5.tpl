<h1>{lang key='news' section='news'}</h1>

{include file='snippets/extension.tpl'}

<div class="well well-sm">
	{get_static_route id='news.php' assign=routeURL}
    <form id="frm_filter" name="frm_filter" action="{$cCanonicalURL|default:$routeURL}" method="post" class="form-inline text-center">
        {$jtl_token}

        <select name="nSort" onchange="this.form.submit();" class="form-control form-group" aria-label="{lang key='newsSort' section='news'}">
            <option value="-1"{if $nSort == -1} selected{/if}>{lang key='newsSort' section='news'}</option>
            <option value="1"{if $nSort == 1} selected{/if}>{lang key='newsSortDateDESC' section='news'}</option>
            <option value="2"{if $nSort == 2} selected{/if}>{lang key='newsSortDateASC' section='news'}</option>
            <option value="3"{if $nSort == 3} selected{/if}>{lang key='newsSortHeadlineASC' section='news'}</option>
            <option value="4"{if $nSort == 4} selected{/if}>{lang key='newsSortHeadlineDESC' section='news'}</option>
            <option value="5"{if $nSort == 5} selected{/if}>{lang key='newsSortCommentsDESC' section='news'}</option>
            <option value="6"{if $nSort == 6} selected{/if}>{lang key='newsSortCommentsASC' section='news'}</option>
        </select>

        <select name="cDatum" onchange="this.form.submit();" class="form-control form-group" aria-label="{lang key='newsDateFilter' section='news'}">
            <option value="-1"{if $cDatum == -1} selected{/if}>{lang key='newsDateFilter' section='news'}</option>
            {if !empty($oDatum_arr)}
                {foreach name="datum" from=$oDatum_arr item=oDatum}
                    <option value="{$oDatum->cWert}"{if $cDatum == $oDatum->cWert} selected{/if}>{$oDatum->cName}</option>
                {/foreach}
            {/if}
        </select>

        {lang key='newsCategorie' section='news' assign='cCurrentKategorie'}
        {if $oNewsCat->getID() > 0}
            {assign var='kNewsKategorie' value=$oNewsCat->getID()}
        {else}
            {assign var='kNewsKategorie' value=$kNewsKategorie|default:0}
        {/if}
        <select name="nNewsKat" onchange="this.form.submit();" class="form-control form-group" aria-label="{lang key='newsCategorie' section='news'}">
            <option value="-1"{if $kNewsKategorie === -1} selected{/if}>{lang key='newsCategorie' section='news'}</option>
            {if !empty($oNewsKategorie_arr)}
                {assign var='selectedCat' value=$kNewsKategorie}
                {include file='snippets/newscategories_recursive.tpl' i=0 selectedCat=$selectedCat}
            {/if}
        </select>
        <select class="form-control form-group" name="{$oPagination->getId()}_nItemsPerPage" id="{$oPagination->getId()}_nItemsPerPage"
                onchange="this.form.submit();" aria-label="{lang key='newsPerSite' section='news'}">
            <option value="-1" {if $oPagination->getItemsPerPage() == 0} selected{/if}>
                {lang key='newsPerSite' section='news'}
            </option>
            {foreach $oPagination->getItemsPerPageOptions() as $nItemsPerPageOption}
                <option value="{$nItemsPerPageOption}"{if $oPagination->getItemsPerPage() == $nItemsPerPageOption} selected{/if}>
                    {$nItemsPerPageOption}
                </option>
            {/foreach}
        </select>

        <button name="submitGo" type="submit" value="{lang key='filterGo'}" class="btn btn-default">{lang key='filterGo'}</button>
    </form>
</div>

{if $noarchiv === 1}
    <div class="alert alert-info">{lang key='noNewsArchiv' section='news'}.</div>
{elseif !empty($newsItems)}
    <div id="news-c" itemprop="mainEntity" itemscope itemtype="https://schema.org/Blog">
        {if $oNewsCat->getID() > 0}
			{include file="snippets/zonen.tpl" id="before_news_category_heading" title="before_news_category_heading"}
            <h2>{$oNewsCat->getName()}</h2>
            <div class="row">
                {if !empty($oNewsCat->getPreviewImage())}
                    <div class="col-sm-8 col-xs-12">{if $snackyConfig.optimize_news == "Y"}{$oNewsCat->getDescription()|optimize}{else}{$oNewsCat->getDescription()}{/if}</div>
                    <div class="col-sm-4 col-xs-12 pr"><div class="img-ct"><img src="{$snackyConfig.preloadImage}" data-src="{$oNewsCat->getPreviewImage()}" class="img-responsive center-block"></div></div>
                {else}
                    <div class="col-sm-12">{if $snackyConfig.optimize_news == "Y"}{$oNewsCat->getDescription()|optimize}{else}{$oNewsCat->getDescription()}{/if}</div>
                {/if}
            </div>
            <hr>
            {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['label']}
        {/if}
		{include file="snippets/zonen.tpl" id="before_news_list" title="before_news_list"}
        <div class="row">
        {foreach $newsItems as $oNewsUebersicht}
            <div class="col-xs-12 col-sm-6 col-lg-4">
				{include file='blog/preview.tpl'}
            </div>
        {/foreach}
        </div>
		{include file="snippets/zonen.tpl" id="after_news_list" title="after_news_list"}
    </div>
    {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['pagi']}
{/if}