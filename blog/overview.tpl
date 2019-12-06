<h1>{lang key='news' section='news'}</h1>

{if !empty($hinweis)}
    <div class="alert alert-info">{$hinweis}</div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">{$fehler}</div>
{/if}

{include file='snippets/extension.tpl'}

<div class="well well-sm">
    <form id="frm_filter" name="frm_filter" action="{get_static_route id='news.php'}" method="post" class="form-inline text-center">
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
        <select name="nNewsKat" onchange="this.form.submit();" class="form-control form-group" aria-label="{lang key='newsCategorie' section='news'}">
            <option value="-1"{if $nNewsKat == -1} selected{/if}>{lang key='newsCategorie' section='news'}</option>
            {if !empty($oNewsKategorie_arr)}
                {foreach name="newskats" from=$oNewsKategorie_arr item=oNewsKategorie}
                    {if $nNewsKat == $oNewsKategorie->kNewsKategorie}{assign var='oCurNewsCat' value=$oNewsKategorie}{/if}
                    <option value="{$oNewsKategorie->kNewsKategorie}"{if $nNewsKat == $oNewsKategorie->kNewsKategorie} selected{/if}>{$oNewsKategorie->cName}</option>
                {/foreach}
            {/if}
        </select>

        <select class="form-control form-group" name="{$oPagination->getId()}_nItemsPerPage" id="{$oPagination->getId()}_nItemsPerPage"
                onchange="this.form.submit();" aria-label="{lang key='newsPerSite' section='news'}">
            <option value="0" {if $oPagination->getItemsPerPage() == 0} selected{/if}>
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

{if isset($noarchiv) && $noarchiv}
    <div class="alert alert-info">{lang key='noNewsArchiv' section='news'}.</div>
{elseif !empty($oNewsUebersicht_arr)}
    <div id="newsContent" itemprop="mainEntity" itemscope itemtype="https://schema.org/Blog">
        {if !empty($oCurNewsCat)}
            <h2>{$oCurNewsCat->cName}</h2>
            <div class="row">
                {if !empty($oCurNewsCat->cPreviewImage)}
                    <div class="col-sm-8 col-xs-12">{if $Einstellungen.template.general.optimize_news == "Y"}{$oCurNewsCat->cBeschreibung|optimize}{else}{$oCurNewsCat->cBeschreibung}{/if}</div>
                    <div class="col-sm-4 col-xs-12 preload"><div class="image-content"><img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$oCurNewsCat->cPreviewImage}" class="img-responsive center-block"></div></div>
                {else}
                    <div class="col-sm-12">{if $Einstellungen.template.general.optimize_news == "Y"}{$oCurNewsCat->cBeschreibung|optimize}{else}{$oCurNewsCat->cBeschreibung}{/if}</div>
                {/if}
            </div>
            <hr>
            {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['label']}
        {/if}
        <div class="row">
        {foreach name=uebersicht from=$oNewsUebersicht_arr item=oNewsUebersicht}
            <div class="col-xs-12 col-sm-6 col-lg-4">
                {include file='blog/preview.tpl'}
            </div>
        {/foreach}
        </div>
    </div>
    {include file='snippets/pagination.tpl' oPagination=$oPagination cThisUrl='news.php' parts=['pagi']}
{/if}