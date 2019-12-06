{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{if $Einstellungen.global.global_wunschliste_freunde_aktiv === 'Y'}
    <h1>{lang key="wishlistViaEmail" section="login"}</h1>
    {if !empty($hinweis)}
        <p class="alert alert-info">{$hinweis}</p>
    {/if}
    <div class="row">
        <div class="col-xs-12">
            {block name="wishlist-email-form"}
            <div class="panel-wrap">
                <div class="panel panel-default">
                    <div class="panel-heading"><h3 class="panel-title">{block name="wishlist-email-form-title"}{$CWunschliste->cName}{/block}</h3></div>
                    <div class="panel-body">
                        {block name="wishlist-email-form-body"}
                        <form method="post" action="{get_static_route id='jtl.php'}" name="Wunschliste">
                            {$jtl_token}
                            <input type="hidden" name="wlvm" value="1" />
                            <input type="hidden" name="wl" value="{$CWunschliste->kWunschliste}" />
                            <input type="hidden" name="send" value="1" />
                            <label for="wishlist-email">{lang key="wishlistEmails" section="login"}{if $Einstellungen.global.global_wunschliste_max_email > 0} | {lang key="wishlistEmailCount" section="login"}: {$Einstellungen.global.global_wunschliste_max_email}{/if}</label>
                            <textarea id="wishlist-email" name="email" rows="5" style="width:100%" class="form-control"></textarea>
                            <hr>
                            <div class="row">
                                <div class="col-xs-12">
                                    <input name="abschicken" type="submit" value="{lang key="wishlistSend" section="login"}" class="btn btn-primary">
                                </div>
                            </div>
                        </form>
                        {/block}
                    </div>
                </div>
            </div>
            {/block}
        </div>
    </div>
{/if}