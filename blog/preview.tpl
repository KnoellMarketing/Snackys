<div itemprop="blogPost" itemscope itemtype="https://schema.org/BlogPosting" class="panel panel-default">    
    {if !empty($oNewsUebersicht->cPreviewImageFull)}
        <div class="img-w">
            <a href="{$oNewsUebersicht->cURLFull}" title="{$oNewsUebersicht->cBetreff}">
                <span class="img-ct">
                    <img src="{$snackyConfig.preloadImage}" data-src="{$ShopURL}/{$oNewsUebersicht->cPreviewImage}" alt="{$oNewsUebersicht->cBetreff}" class="img-responsive center-block"/>
                </span>
                <meta itemprop="image" content="{$ShopURL}/{$oNewsUebersicht->cPreviewImage}">
            </a>
        </div>
    {/if}
    <div class="panel-heading hide-overflow">
        <div class="panel-title">
            <a itemprop="url" href="{$oNewsUebersicht->cURL}" class="title">
                <span itemprop="headline" class="block h4 m0">{$oNewsUebersicht->cBetreff}</span>
            </a>
            <meta itemprop="mainEntityOfPage" content="{$ShopURL}/{$oNewsUebersicht->cURL}">
            <div class="text-muted small dpflex-a-center v-box">
                {if empty($oNewsUebersicht->dGueltigVon)}
                    {assign var="dDate" value=$oNewsUebersicht->dErstellt}
                {else}
                    {assign var="dDate" value=$oNewsUebersicht->dGueltigVon}
                {/if}
                {if isset($oNewsUebersicht->oAuthor)}
                    <div class="hidden-xs">{include file="snippets/author.tpl" oAuthor=$oNewsUebersicht->oAuthor}</div>
                {else}
                    <div itemprop="author publisher" itemscope itemtype="http://schema.org/Organization" class="hidden">
                        <span itemprop="name">{$meta_publisher}</span>
                        <meta itemprop="url" content="{$ShopURL}">
                        <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject"><meta itemprop="url" content="{$ShopURL}/{$ShopLogoURL}"></span>
                    </div>
                {/if}
                {if isset($oNewsUebersicht->dErstellt)}<time itemprop="dateModified" class="hidden">{$oNewsUebersicht->dErstellt}</time>{/if}
                <time itemprop="datePublished" datetime="{$dDate}" class="hidden">{$dDate}</time>
                <span class="block">{$oNewsUebersicht->dErstellt_de}</span>
                {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
                    <span class="separator">|</span>
                    <a class="dpflex-a-center" href="{$oNewsUebersicht->cURL}#comments" title="{lang key="readComments" section="news"}">
                        <span class="img-ct icon">
							<svg>
							  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-comment"></use>
							</svg>
						</span>
                        <span class="sr-only hidden">
                            {if $oNewsUebersicht->nNewsKommentarAnzahl == 1}
                                {lang key="newsComment" section="news"}
                            {else}
                                {lang key="newsComments" section="news"}
                            {/if}
                        </span>
                        <span itemprop="commentCount">{$oNewsUebersicht->nNewsKommentarAnzahl}</span>
                    </a>
                {/if}
            </div>
        </div>
    </div>
    <div class="panel-body">
        {if $oNewsUebersicht->cVorschauText|strip_tags|count_characters > 0}
            <div itemprop="description">
                {if $oNewsUebersicht->cText|strip_tags|count_characters < 200}
                    {$oNewsUebersicht->cVorschauText}
                {else}
                    {$oNewsUebersicht->cText|strip_tags|truncate:200:""}
                {/if}
            </div>
        {/if}
    </div>
    <a class="block title" href="{$oNewsUebersicht->cURLFull}">
        <strong>{lang key='moreLink' section='news'}</strong>
        </a>
    </span>
</div>