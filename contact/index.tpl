{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
{snackysBasics}
{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {if !empty($Spezialcontent->titel)}
        <div class="title text-center">
            <h2>{$Spezialcontent->titel}</h2>
        </div>
    {/if}
    
    {include file="snippets/extension.tpl"}
    {if isset($step)}
        {if $step === 'formular'}
            {if !empty($Spezialcontent->oben)}
                <div class="custom_content">
                    {$Spezialcontent->oben}
                </div>
            {/if}
            <div class="panel-wrap">
                {if !empty($fehlendeAngaben)}
                    <div class="alert alert-danger alert-dismissible">
                        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                        {lang key="fillOut" section="global"}
                    </div>
                {/if}
                <form name="contact" action="{get_static_route id='kontakt.php'}" method="post" class="evo-validate">
                    {$jtl_token}
                    <fieldset>
                        <legend>{lang key="contact" section="global"}</legend>
                        <div class="row">
                            {if $Einstellungen.kontakt.kontakt_abfragen_anrede !== 'N'}
                                <div class="col-xs-12 col-md-6">
                                    <div class="form-group float-label-control">
                                        <label for="salutation" class="control-label">{lang key="salutation" section="account data"}</label>
                                        <select name="anrede" id="salutation" class="form-control" required>
                                            <option value="w"{if isset($Vorgaben->cAnrede) && $Vorgaben->cAnrede === 'w'} selected="selected"{/if}>{$Anrede_w}</option>
                                            <option value="m"{if isset($Vorgaben->cAnrede) && $Vorgaben->cAnrede === 'm'} selected="selected"{/if}>{$Anrede_m}</option>
                                        </select>
                                    </div>
                                </div>
                            {/if}
                        </div>
    
                        {if $Einstellungen.kontakt.kontakt_abfragen_vorname !== 'N' || $Einstellungen.kontakt.kontakt_abfragen_nachname !== 'N'}
                            <div class="row">
                                {if $Einstellungen.kontakt.kontakt_abfragen_vorname !== 'N'}
                                    <div class="col-xs-12 col-md-6">
                                        {include file="snippets/form_group_simple.tpl" options=["text", "firstName", "vorname", {$Vorgaben->cVorname}, {lang key="firstName" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_vorname}]}
                                    </div>
                                {/if}
                                {if $Einstellungen.kontakt.kontakt_abfragen_nachname !== 'N'}
                                    <div class="col-xs-12 col-md-6">
                                        {assign var='invalidReason' value=null}
                                        {if isset($fehlendeAngaben.nachname)}
                                            {if $fehlendeAngaben.nachname == 1}
                                                {lang assign="invalidReason" key="fillOut" section="global"}
                                            {elseif $fehlendeAngaben.nachname == 2}
                                                {lang assign="invalidReason" key="lastNameNotNumeric" section="account data"}
                                            {/if}
                                        {/if}
                                        {include file="snippets/form_group_simple.tpl" options=["text" , "lastName", "nachname", {$Vorgaben->cNachname}, {lang key="lastName" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_nachname}, {$invalidReason}]}
                                    </div>
                                {/if}
                            </div>
                        {/if}
    
                        {if $Einstellungen.kontakt.kontakt_abfragen_firma !== 'N'}
                            <div class="row">
                                <div class="col-xs-12 col-md-6">
                                    {include    file="snippets/form_group_simple.tpl"
                                        options=[ "text" , "firm", "firma", {$Vorgaben->cFirma}, {lang key="firm" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_firma}]}
                                </div>
                            </div>
                        {/if}
                        <div class="row">
                            <div class="col-xs-12 col-md-6">
                                {assign var='invalidReason' value=null}
                                {if isset($fehlendeAngaben.email)}
                                    {if $fehlendeAngaben.email == 1}{lang assign="invalidReason" key="fillOut" section="global"}
                                    {elseif $fehlendeAngaben.email == 2}{lang assign="invalidReason" key="invalidEmail" section="global"}
                                    {elseif $fehlendeAngaben.email == 3}{lang assign="invalidReason" key="blockedEmail" section="global"}
                                    {elseif $fehlendeAngaben.email == 4}{lang assign="invalidReason" key="noDnsEmail" section="account data"}
                                    {elseif $fehlendeAngaben.email == 5}{lang assign="invalidReason" key="emailNotAvailable" section="account data"}{/if}
                                {/if}
                                {include    file="snippets/form_group_simple.tpl"
                                    options=[ "email" , "email", "email", {$Vorgaben->cMail}, {lang key="email" section="account data"}, true, {$invalidReason}]}
                            </div>
                        </div>
                        {if $Einstellungen.kontakt.kontakt_abfragen_tel !== 'N' || $Einstellungen.kontakt.kontakt_abfragen_mobil !== 'N'}
                            <div class="row">
                                {if $Einstellungen.kontakt.kontakt_abfragen_tel !== 'N'}
                                    <div class="col-xs-12  col-md-6">
                                        {assign var='invalidReason' value=null}
                                        {if isset($fehlendeAngaben.tel) && $fehlendeAngaben.tel === 1}{lang assign="invalidReason" key="fillOut" section="global"}{elseif isset($fehlendeAngaben.tel) && $fehlendeAngaben.tel === 2}{lang assign="invalidReason" key="invalidTel" section="global"}{/if}
                                        {include file="snippets/form_group_simple.tpl" options=["tel" , "tel", "tel", {$Vorgaben->cTel}, {lang key="tel" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_tel}, {$invalidReason}]}
                                    </div>
                                {/if}
                                {if $Einstellungen.kontakt.kontakt_abfragen_mobil !== 'N'}
                                    <div class="col-xs-12 col-md-6">
                                        {assign var='invalidReason' value=null}
                                        {if isset($fehlendeAngaben.mobil) && $fehlendeAngaben.mobil === 1}{lang assign="invalidReason" key="fillOut" section="global"}{elseif isset($fehlendeAngaben.mobil) && $fehlendeAngaben.mobil === 2}{lang assign="invalidReason" key="invalidTel" section="global"}{/if}
                                        {include file="snippets/form_group_simple.tpl" options=["tel" , "mobile", "mobil", {$Vorgaben->cMobil}, {lang key="mobile" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_mobil}, {$invalidReason}]}
                                    </div>
                                {/if}
                            </div>
                        {/if}
    
                        {if $Einstellungen.kontakt.kontakt_abfragen_fax !== 'N'}
                            <div class="row">
                                <div class="col-xs-12 col-md-6">
                                    {assign var='invalidReason' value=null}
                                    {if !empty($fehlendeAngaben.fax) && $fehlendeAngaben.fax === 1}{lang assign="invalidReason" key="fillOut" section="global"}{elseif isset($fehlendeAngaben.fax) && $fehlendeAngaben.fax === 2}{lang assign="invalidReason" key="invalidTel" section="global"}{/if}
                                    {include file="snippets/form_group_simple.tpl" options=["tel" , "fax", "fax", {$Vorgaben->cFax}, {lang key="fax" section="account data"}, {$Einstellungen.kontakt.kontakt_abfragen_fax}, {$invalidReason}]}
                                </div>
                            </div>
                        {/if}
                        {if !isset($cPost_arr)}
                            {assign var=cPost_arr value=array()}
                        {/if}
                        {include file='snippets/checkbox.tpl' nAnzeigeOrt=$nAnzeigeOrt cPlausi_arr=$fehlendeAngaben cPost_arr=$cPost_arr}
    
                    </fieldset>
    
                    <fieldset>
                        <legend>{lang key="message" section="contact"}</legend>
                        {if $betreffs}
                            {if isset($fehlendeAngaben.betreff)}
                                <div class="alert alert-danger">
                                    {lang key="fillOut" section="global"}
                                </div>
                            {/if}
                            <div class="row">
                                <div class="col-xs-12 col-md-6">
                                    <div class="form-group float-label-control{if isset($fehlendeAngaben.subject)} has-error{/if} required">
                                        <label for="subject" class="control-label">{lang key="subject" section="contact"}</label>
                                        <select class="form-control" name="subject" id="subject" required>
                                            <option value="" selected disabled>{lang key="subject" section="contact"}</option>
                                            {foreach name=betreffs from=$betreffs item=betreff}
                                                <option value="{$betreff->kKontaktBetreff}" {if $Vorgaben->kKontaktBetreff==$betreff->kKontaktBetreff}selected{/if}>{$betreff->AngezeigterName}</option>
                                            {/foreach}
                                        </select>
                                        {if !empty($fehlendeAngaben.subject)}
                                            <div class="form-error-msg text-danger">
                                                {lang key="fillOut" section="global"}
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/if}
                        <div class="row">
                            <div class="col-xs-12 col-md-12">
                                <div class="form-group float-label-control{if isset($fehlendeAngaben.nachricht)} has-error{/if} required">
                                    <label for="message" class="control-label">{lang key="message" section="contact"}</label>
                                    <textarea name="nachricht" class="form-control" rows="10" id="message" required>{if isset($Vorgaben->cNachricht)}{$Vorgaben->cNachricht}{/if}</textarea>
                                    {if !empty($fehlendeAngaben.nachricht)}
                                        <div class="form-error-msg text-danger">
                                            {lang key="fillOut" section="global"}
                                        </div>
                                    {/if}
                                </div>
                            </div>
                        </div>
                    </fieldset>
                    {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
                        isset($Einstellungen.global.anti_spam_method) && $Einstellungen.global.anti_spam_method !== 'N' && 
                        isset($Einstellungen.kontakt.kontakt_abfragen_captcha) && $Einstellungen.kontakt.kontakt_abfragen_captcha !== 'N' && empty($smarty.session.Kunde->kKunde)}
                        <hr>
                        <div class="row">
                            <div class="col-xs-12 col-md-12">
                                <div class="g-recaptcha form-group" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}" data-callback="captcha_filled"></div>
                                {if !empty($fehlendeAngaben.captcha)}
                                    <div class="form-error-msg text-danger">{lang key="invalidToken" section="global"}</div>
                                {/if}
                                <hr>
                            </div>
                        </div>
                    {/if}
                    <input type="hidden" name="kontakt" value="1" />
                    <button type="submit" class="btn btn-primary">{lang key="sendMessage" section="contact"}</button>
                </form>
            </div>
            <br>
            {if !empty($Spezialcontent->unten)}
                <div class="custom_content">
                    {$Spezialcontent->unten}
                </div>
            {/if}
        {elseif $step === 'nachricht versendet'}
            <div class="alert alert-success">
                {lang key="messageSent" section="contact"}
            </div>
        {elseif $step === 'floodschutz'}
            <div class="alert alert-danger">
                {lang key="youSentUsAMessageShortTimeBefore" section="contact"}
            </div>
        {/if}
    {/if}

    {if (!isset($smarty.session.bAnti_spam_already_checked) || $smarty.session.bAnti_spam_already_checked !== true) &&
        isset($Einstellungen.global.anti_spam_method) && $Einstellungen.global.anti_spam_method !== 'N' && 
        isset($Einstellungen.kontakt.kontakt_abfragen_captcha) && $Einstellungen.kontakt.kontakt_abfragen_captcha !== 'N' && empty($smarty.session.Kunde->kKunde)}
        <script src='https://www.google.com/recaptcha/api.js'></script>
    {/if}
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}