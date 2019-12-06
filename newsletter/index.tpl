{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{snackysBasics}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {if !empty($hinweis)}
        <div class="alert alert-success">
            {$hinweis}
        </div>
    {/if}
    {if !empty($fehler)}
        <div class="alert alert-danger">
            {$fehler}
        </div>
    {/if}
    
    {include file="snippets/extension.tpl"}
    {if !isset($cPost_arr)}
        {assign var=cPost_arr value=array()}
    {/if}
    {if $cOption === 'eintragen'}
        {if empty($bBereitsAbonnent)}
            {block name="newsletter-subscribe"}
            <div id="newsletter-subscribe" class="panel-wrap">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{block name="newsletter-subscribe-title"}{lang key="newsletterSubscribe" section="newsletter"}{/block}</h3>
                    </div>
                    <div class="panel-body">
                        {block name="newsletter-subscribe-body"}
                        <p>{lang key="newsletterSubscribeDesc" section="newsletter"}</p>
    
                        <form method="post" action="{get_static_route id='newsletter.php'}" role="form" class="evo-validate">
                            <fieldset>
                                <div class="form-group float-label-control">
                                    <label for="newslettertitle" class="control-label">{lang key="newslettertitle" section="newsletter"}</label>
                                    <select id="newslettertitle" name="cAnrede" class="form-control">
                                        <option value="w"{if (isset($oKunde->cAnrede) && $oKunde->cAnrede === 'w')} selected="selected"{/if}>{$Anrede_w}</option>
                                        <option value="m"{if (isset($oKunde->cAnrede) && $oKunde->cAnrede === 'm')} selected="selected"{/if}>{$Anrede_m}</option>
                                    </select>
                                </div>
                                <div class="form-group float-label-control">
                                    <label for="newsletterfirstname" class="control-label">{lang key="newsletterfirstname" section="newsletter"}</label>
                                    <input type="text" name="cVorname" class="form-control" value="{if !empty($oPlausi->cPost_arr.cVorname)}{$oPlausi->cPost_arr.cVorname}{elseif !empty($oKunde->cVorname)}{$oKunde->cVorname}{/if}" id="newsletterfirstname" />
                                    {if !empty($oPlausi->nPlausi_arr.cVorname)}
                                        <div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
                                    {/if}
                                </div>
                                <div class="form-group float-label-control">
                                    <label for="lastName" class="control-label">{lang key="newsletterlastname" section="newsletter"}</label>
                                    <input type="text" name="cNachname" class="form-control" value="{if !empty($oPlausi->cPost_arr.cNachname)}{$oPlausi->cPost_arr.cNachname}{elseif !empty($oKunde->cNachname)}{$oKunde->cNachname}{/if}" id="lastName" />
                                    {if !empty($oPlausi->nPlausi_arr.cNachname)}
                                        <div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
                                    {/if}
                                </div>
                                <div class="form-group float-label-control{if !empty($oPlausi->nPlausi_arr.cEmail)} has-error{/if} required">
                                    <label for="email" class="control-label">{lang key="newsletteremail" section="newsletter"}</label>
                                    <input type="email" name="cEmail" class="form-control" required value="{if !empty($oPlausi->cPost_arr.cEmail)}{$oPlausi->cPost_arr.cEmail}{elseif !empty($oKunde->cMail)}{$oKunde->cMail}{/if}" id="email" />
                                    {if !empty($oPlausi->nPlausi_arr.cEmail)}
                                        <div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
                                    {/if}
                                </div>
                                {if isset($oPlausi->nPlausi_arr)}
                                    {assign var=plausiArr value=$oPlausi->nPlausi_arr}
                                {else}
                                    {assign var=plausiArr value=array()}
                                {/if}
                                {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
                                    isset($Einstellungen.global.anti_spam_method) && $Einstellungen.global.anti_spam_method !== 'N' &&
                                    isset($Einstellungen.newsletter.newsletter_sicherheitscode) && $Einstellungen.newsletter.newsletter_sicherheitscode !== 'N' && empty($smarty.session.Kunde->kKunde)}
                                    <script src='https://www.google.com/recaptcha/api.js'></script>
                                <hr>
                                    <div class="g-recaptcha form-group" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}" data-callback="captcha_filled"></div>
                                    {if !empty($plausiArr.captcha) && $plausiArr.captcha === true}
                                        <div class="form-error-msg text-danger"> {lang key="invalidToken" section="global"}</div>
                                    {/if}
                                    <hr>
                                {/if}
                                {hasCheckBoxForLocation nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr bReturn="bHasCheckbox"}
                                {if $bHasCheckbox}
                                    <hr>
                                    {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$plausiArr cPost_arr=$cPost_arr}
                                    <hr>
                                {/if}
    
                                <div class="form-group">
                                    {$jtl_token}
                                        <input type="hidden" name="abonnieren" value="1" />
                                        <button type="submit" class="btn btn-primary submit">
                                            <span>{lang key="newsletterSendSubscribe" section="newsletter"}</span>
                                        </button>
                                        <p class="info small">
                                            {lang key="unsubscribeAnytime" section="newsletter"}
                                        </p>
                                </div>
                            </fieldset>
                        </form>
                        {/block}
                    </div>
                </div>
            </div>
            {/block}
        {/if}
        
        {block name="newsletter-unsubscribe"}
        <div id="newsletter-unsubscribe" class="panel-wrap top15">
            <div class="panel panel-default">
                <div class="panel-heading">
                <h3 class="panel-title">{block name="newsletter-unsubscribe-title"}{lang key="newsletterUnsubscribe" section="newsletter"}{/block}</h3></div>
                <div class="panel-body">
                    {block name="newsletter-unsubscribe-body"}
                    <p>{lang key="newsletterUnsubscribeDesc" section="newsletter"}</p>
    
                    <form method="post" action="{get_static_route id='newsletter.php'}" name="newsletterabmelden">
                        <fieldset>
                            <div class="form-group float-label-control required{if !empty($oFehlendeAngaben->cUnsubscribeEmail)} has-error{/if}">
                                <label for="checkOut" class="control-label">{lang key="newsletteremail" section="newsletter"}</label>
                                <input type="email" class="form-control" required name="cEmail" value="{if !empty($oKunde->cMail)}{$oKunde->cMail}{/if}" id="checkOut" />
                                {if !empty($oFehlendeAngaben->cUnsubscribeEmail)}
                                    <div class="form-error-msg text-danger"> {lang key="fillOut" section="global"}</div>
                                {/if}
                            </div>
                            {$jtl_token}
                            <input type="hidden" name="abmelden" value="1" />
                            <button type="submit" class="submit btn btn-default">
                                <span>{lang key="newsletterSendUnsubscribe" section="newsletter"}</span>
                            </button>
                        </fieldset>
                    </form>
                    {/block}
                </div>
            </div>
        </div>
        {/block}
    {elseif $cOption === 'anzeigen'}
        {if isset($oNewsletterHistory) && $oNewsletterHistory->kNewsletterHistory > 0}
            {block name="newsletter-history"}
            <h2>{lang key="newsletterhistory" section="global"}</h2>
            <div id="newsletterContent">
                <div class="newsletter">
                    <p class="newsletterSubject">
                        <strong>{lang key="newsletterdraftsubject" section="newsletter"}:</strong> {$oNewsletterHistory->cBetreff}
                    </p>
                    <p class="newsletterReference smallfont">
                        {lang key="newsletterdraftdate" section="newsletter"}: {$oNewsletterHistory->Datum}
                    </p>
                </div>
    
                <fieldset id="newsletterHtml">
                    <legend>{lang key="newsletterHtml" section="newsletter"}</legend>
                    {$oNewsletterHistory->cHTMLStatic|replace:'src="http://':'src="//'}
                </fieldset>
            </div>
            {/block}
        {else}
            <div class="alert alert-danger">{lang key="noEntriesAvailable" section="global"}</div>
        {/if}
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}