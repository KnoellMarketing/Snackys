{include file='snippets/extension.tpl'}

{if !empty($cNewsErr)}
    <div class="alert alert-danger">{lang key='newsRestricted' section='news'}</div>
{else}
    <article itemprop="mainEntity" itemscope itemtype="https://schema.org/BlogPosting">
        <meta itemprop="mainEntityOfPage" content="{$oNewsArchiv->getURL()}">
        <h1 itemprop="headline">
            {$oNewsArchiv->getTitle()}
        </h1>
        {if $oNewsArchiv->getPreviewImage() !== ''}
            <meta itemprop="image" content="{$imageBaseURL}{$oNewsArchiv->getPreviewImage()}">
        {/if}
        <p class="text-muted">
            {if empty($oNewsArchiv->getDateValidFrom())}
                {assign var=dDate value=$oNewsArchiv->getDateCreated()->format('Y-m-d H:i:s')}
            {else}
                {assign var=dDate value=$oNewsArchiv->getDateValidFrom()->format('Y-m-d H:i:s')}

                {/if}
            {if $oNewsArchiv->getAuthor() !== null}
                {include file="snippets/author.tpl" oAuthor=$oNewsArchiv->getAuthor() dDate=$dDate cDate=$oNewsArchiv->getDateValidFrom()->format('Y-m-d H:i:s')}
            {else}
                <div itemprop="author publisher" itemscope itemtype="http://schema.org/Organization" class="hidden">
                    <span itemprop="name">{$meta_publisher}</span>
                    <span itemprop="logo" itemscope itemtype="https://schema.org/ImageObject"><meta itemprop="url" content="{$ShopURL}/{$ShopLogoURL}"></span>
                </div>
            {/if}
            {if isset($oNewsArchiv->dErstellt)}<time itemprop="dateModified" class="hidden">{$oNewsArchiv->dErstellt}</time>{/if}
            <time itemprop="datePublished" datetime="{$dDate}" class="hidden">{$dDate}</time>
        </p>

        <div itemprop="articleBody" class="row">
            <div class="col-xs-12">
				{if $snackyConfig.optimize_news == "Y"}{$oNewsArchiv->getContent()|optimize}{else}{$oNewsArchiv->getContent()}{/if}
            </div>
        </div>

        {if isset($Einstellungen.news.news_kategorie_unternewsanzeigen) && $Einstellungen.news.news_kategorie_unternewsanzeigen === 'Y' && !empty($oNewsKategorie_arr)}
            <div class="top10 news-categorylist">
                {foreach name=newskategorie from=$oNewsKategorie_arr item=oNewsKategorie}
                    <a itemprop="articleSection" href="{$oNewsKategorie->cURLFull}" title="{$oNewsKategorie->cBeschreibung|strip_tags|escape:"html"|truncate:60}" class="badge btn btn-xs">{$oNewsKategorie->cName}</a>
                {/foreach}
            </div>
        {/if}

        {if isset($Einstellungen.news.news_kommentare_nutzen) && $Einstellungen.news.news_kommentare_nutzen === 'Y'}
            {if $comments|@count > 0}
                {if $oNewsArchiv->getURL() !== ''}
                    {assign var=articleURL value=$oNewsArchiv->getURL()}
                    {assign var=cParam_arr value=[]}
                {else}
                    {assign var=articleURL value='news.php'}
                    {assign var=cParam_arr value=['kNews'=>$oNewsArchiv->getID(),'n'=>$oNewsArchiv->getID()]}
                {/if}
                <div class="top10" id="comments">
                    <h3 class="section-heading">{lang key="newsComments" section="news"}<span itemprop="commentCount" class="hidden">{$comments|count}</span></h3>
                    {foreach name=kommentare from=$comments item=comment}
                        <blockquote class="news-comment m0">
                            <p itemprop="comment">
                                {$comment->getText()}
                            </p>
                            <small>{$comment->getName()}, {$comment->getDateCreated()->format('d.m.y H:i')}</small>
                        </blockquote>
                    {/foreach}
                </div>
                {include file='snippets/pagination.tpl' oPagination=$oPagiComments cThisUrl=$articleURL cParam_arr=$cParam_arr}
            {/if}

            {if $userCanComment === true}
                <hr>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel-wrap">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h4 class="panel-title">{lang key="newsCommentAdd" section="news"}</h4></div>
                                <div class="panel-body">
                                    <form method="post" action="{if !empty($oNewsArchiv->getSEO())}{$oNewsArchiv->getURL()}{else}{get_static_route id='news.php'}{/if}" class="form evo-validate" id="news-addcomment">
                                        {$jtl_token}
                                        <input type="hidden" name="kNews" value="{$oNewsArchiv->getID()}" />
                                        <input type="hidden" name="kommentar_einfuegen" value="1" />
                                        <input type="hidden" name="n" value="{$oNewsArchiv->getID()}" />

                                        <fieldset>
                                            {if $Einstellungen.news.news_kommentare_eingeloggt === 'N'}
                                                {if empty($smarty.session.Kunde->kKunde)}
                                                    <div class="row">
                                                        <div class="col-xs-12 col-md-6">
                                                            <div id="commentName" class="form-group float-label-control{if isset($nPlausiValue_arr.cName)} has-error{/if} required">
                                                                <label class="control-label commentForm" for="comment-name">{lang key="newsName" section="news"}</label>
                                                                <input class="form-control" required id="comment-name" name="cName" type="text" value="{if !empty($cPostVar_arr.cName)}{$cPostVar_arr.cName}{/if}" />
                                                                {if isset($nPlausiValue_arr.cName)}
                                                                    <div class="form-error-msg text-danger">
                                                                        {lang key="fillOut" section="global"}
                                                                    </div>
                                                                {/if}
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-12 col-md-6">
                                                            <div id="commentEmail" class="form-group float-label-control{if isset($nPlausiValue_arr.cEmail)} has-error{/if} required">
                                                                <label class="control-label commentForm" for="comment-email">{lang key="newsEmail" section="news"}</label>
                                                                <input class="form-control" required id="comment-email" name="cEmail" type="email" value="{if !empty($cPostVar_arr.cEmail)}{$cPostVar_arr.cEmail}{/if}" />
                                                                {if isset($nPlausiValue_arr.cEmail)}
                                                                    <div class="form-error-msg text-danger">
                                                                        {lang key="fillOut" section="global"}
                                                                    </div>
                                                                {/if}
                                                            </div>
                                                        </div>
                                                    </div>
                                                {/if}

                                                <div id="commentText" class="form-group float-label-control{if isset($nPlausiValue_arr.cKommentar)} has-error{/if} required">
                                                    <label class="control-label commentForm" for="comment-text">{lang key="newsComment" section="news"}</label>
                                                    <textarea id="comment-text" required class="form-control" name="cKommentar">{if !empty($cPostVar_arr.cKommentar)}{$cPostVar_arr.cKommentar}{/if}</textarea>
                                                    {if isset($nPlausiValue_arr.cKommentar)}
                                                        <div class="form-error-msg text-danger">
                                                            {lang key="fillOut" section="global"}
                                                        </div>
                                                    {/if}
                                                </div>

                                                <div class="form-group float-label-control">
                                                    {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
                                                        isset($Einstellungen.global.anti_spam_method) && $Einstellungen.global.anti_spam_method !== 'N' &&
                                                        isset($Einstellungen.news.news_sicherheitscode) && $Einstellungen.news.news_sicherheitscode !== 'N' && empty($smarty.session.Kunde->kKunde)}
                                                        <script src='https://www.google.com/recaptcha/api.js'></script>
                                                        <div class="g-recaptcha" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}" data-callback="captcha_filled"></div>
                                                        {if !empty($nPlausiValue_arr.captcha)}
                                                            <div class="form-error-msg text-danger">
                                                                {lang key="invalidToken" section="global"}
                                                            </div>
                                                        {/if}
                                                    {/if}
                                                </div>

                                                <input class="btn btn-primary" name="speichern" type="submit" value="{lang key="newsCommentSave" section="news"}" />
                                            {elseif $Einstellungen.news.news_kommentare_eingeloggt === 'Y' && !empty($smarty.session.Kunde->kKunde)}
                                                <div class="form-group float-label-control{if isset($nPlausiValue_arr.cKommentar)} has-error{/if} required">
                                                    <label class="control-label" for="comment-text"><strong>{lang key="newsComment" section="news"}</strong></label>
                                                    <textarea id="comment-text" class="form-control" name="cKommentar" required></textarea>
                                                    {if isset($nPlausiValue_arr.cKommentar)}
                                                        <div class="form-error-msg text-danger">
                                                            {lang key="fillOut" section="global"}
                                                        </div>
                                                    {/if}
                                                </div>
                                                <input class="btn btn-primary" name="speichern" type="submit" value="{lang key="newsCommentSave" section="news"}" />
                                            {/if}
                                        </fieldset>
                                    </form>
                                </div>
                            </div>{* /panel *}
                        </div>{* /well *}
                    </div>
                </div>
            {else}
                <hr>
                <div class="alert alert-danger">{lang key="newsLogin" section="news"}</div>
            {/if}
        {/if}
    </article>
{/if}
