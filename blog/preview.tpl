<div itemprop="blogPost" itemscope itemtype="https://schema.org/BlogPosting" class="panel panel-default">    
    {if !empty($oNewsUebersicht->cPreviewImageFull)}
        <div class="image-wrapper preload">
            <a href="{$oNewsUebersicht->cURLFull}" title="{$oNewsUebersicht->cBetreff}">
                <span class="image-content">
                    <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$ShopURL}/{$oNewsUebersicht->cPreviewImage}" alt="" class="img-responsive center-block"/>
                </span>
                <meta itemprop="image" content="{$ShopURL}/{$oNewsUebersicht->cPreviewImage}">
            </a>
        </div>
    {/if}
    <div class="panel-heading hide-overflow">
        <div class="panel-title">
            <a itemprop="url" href="{$oNewsUebersicht->cURL}">
                <h4 class="m0"><span itemprop="headline">{$oNewsUebersicht->cBetreff}</span></h4>
            </a>
            <meta itemprop="mainEntityOfPage" content="{$ShopURL}/{$oNewsUebersicht->cURL}">
            <div class="text-muted v-box preload">
                {if empty($oNewsUebersicht->dGueltigVon)}
                    {assign var="dDate" value=$oNewsUebersicht->dErstellt}
                {else}
                    {assign var="dDate" value=$oNewsUebersicht->dGueltigVon}
                {/if}
                {if (isset($oNewsUebersicht->oAuthor))}
                    <div class="hidden-xs v-box">{include file="snippets/author.tpl" oAuthor=$oNewsUebersicht->oAuthor}</div>
                {else}
                    <div itemprop="author publisher" itemscope itemtype="http://schema.org/Organization" class="hidden">
                        <span itemprop="name">{$meta_publisher}</span>
                        <meta itemprop="url" content="{$ShopURL}">
                        <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject"><meta itemprop="url" content="{$ShopURL}/{$ShopLogoURL}"></span>
                    </div>
                {/if}
                {if isset($oNewsUebersicht->dErstellt)}<time itemprop="dateModified" class="hidden">{$oNewsUebersicht->dErstellt}</time>{/if}
                <time itemprop="datePublished" datetime="{$dDate}" class="hidden">{$dDate}</time><span class="v-box">{$oNewsUebersicht->dErstellt_de}</span>
                {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
                    <span class="separator">|</span>
                    <a class="v-box" href="{$oNewsUebersicht->cURL}#comments" title="{lang key="readComments" section="news"}">
                        <span class="image-content icon">
							<svg>
							  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-comment"></use>
							</svg>
						</span>
                        <span class="sr-only hidden">
                            {if $oNewsUebersicht->nNewsKommentarAnzahl == 1}
                                {lang key="newsComment" section="news"}
                            {else}
                                {lang key="newsComments" section="news"}
                            {/if}
                        </span>
                        <em itemprop="commentCount">{$oNewsUebersicht->nNewsKommentarAnzahl}</em>
                    </a>
                {/if}
            </div>
        </div>
    </div>
    <div class="panel-body">
        <div class=" row">
            {if $oNewsUebersicht->cVorschauText|strip_tags|count_characters > 0}
                <div itemprop="description" class="col-xs-12">
                    {if $oNewsUebersicht->cText|strip_tags|count_characters < 200}
                        {$oNewsUebersicht->cVorschauText}
                    {else}
                        {$oNewsUebersicht->cText|strip_tags|truncate:200:""}
                    {/if}
                    <span class="more-link-container top17">
                        <a class="news-more-link" href="{$oNewsUebersicht->cURLFull}">{lang key='moreLink' section='news'}</a>
                    </span>
                </div>
            {/if}
        </div>
    </div>
</div>