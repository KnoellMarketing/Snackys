<div id="comment{$oBewertung->kBewertung}" class="review-comment {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y' && isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde > 0 && $smarty.session.Kunde->kKunde != $oBewertung->kKunde}use_helpful{/if} {if isset($bMostUseful) && $bMostUseful}most_useful{/if}">
    {block name="productdetails-review-content"}
    <div class="top5" itemprop="review" itemscope itemtype="http://schema.org/Review">
        <span itemprop="name" class="hidden">{$oBewertung->cTitel}</span>

        <span itemprop="reviewRating" itemscope itemtype="http://schema.org/Rating">
            <span class="">
                {include file='productdetails/rating.tpl' stars=$oBewertung->nSterne}
                <small class="hide">
                    <span itemprop="ratingValue">{$oBewertung->nSterne}</span> {lang key="from" section="global"}
                    <span itemprop="bestRating">5</span>
                    <meta itemprop="worstRating" content="1">
                </small>
            </span>
            <strong>{$oBewertung->cTitel}</strong>
            {if $Einstellungen.bewertung.bewertung_hilfreich_anzeigen === 'Y'}
                {if isset($smarty.session.Kunde) && $smarty.session.Kunde->kKunde > 0 && $smarty.session.Kunde->kKunde != $oBewertung->kKunde}
                    <span class="review-helpful vmiddle" id="help{$oBewertung->kBewertung}">
                        <button class="helpful btn btn-blank pr" title="{lang key="yes"}" name="hilfreich_{$oBewertung->kBewertung}" type="submit">
                            <div class="img-ct icon">
								<svg width="16">
								  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-thumb-up"></use>
								</svg>
                            </div>
                        </button>
                        <button class="not_helpful btn btn-blank pr" title="{lang key="no"}" name="nichthilfreich_{$oBewertung->kBewertung}" type="submit">
                            <div class="img-ct icon">
								<svg width="16">
								  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-thumb-down"></use>
								</svg>
                            </div>
                        </button>
                    </span>
                {/if}
            {/if}
        </span>
        {if $oBewertung->nHilfreich > 0}
        {block name="productdetails-review-helpful"}
        <div class="review-helpful-total">
            <small class="text-muted">
                {if $oBewertung->nHilfreich > 0}
                    {$oBewertung->nHilfreich}
                {else}
                    {lang key="nobody" section="product rating"}
                {/if}
                {lang key="from" section="product rating"} {$oBewertung->nAnzahlHilfreich}
                {if $oBewertung->nAnzahlHilfreich > 1}
                    {lang key="ratingHelpfulCount" section="product rating"}
                {else}
                    {lang key="ratingHelpfulCountExt" section="product rating"}
                {/if}
            </small>
        </div>
        {/block}
        {/if}
        <blockquote>
            <p itemprop="reviewBody">{$oBewertung->cText|nl2br}</p>
            <small>
                <cite><span itemprop="author" itemscope itemtype="http://schema.org/Person"><span itemprop="name">{$oBewertung->cName}</span></span>.</cite>,
                <meta itemprop="datePublished" content="{$oBewertung->dDatum}" />{$oBewertung->Datum}
            </small>
        </blockquote>
        <img itemprop="image" src="{$Artikel->cVorschaubild}" alt="{$oBewertung->cTitel}" class="hidden" />
        {if !empty($oBewertung->cAntwort)}
            <div class="review-reply">
                <strong>{lang key='reply' section='product rating'} {$cShopName}:</strong>
                <blockquote>
                    <p>{$oBewertung->cAntwort}</p>
                    <small>{$oBewertung->AntwortDatum}</small>
                </blockquote>
            </div>
        {/if}
    </div>
    {/block}
</div>