<section class="panel panel-default box box-login" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <h5 class="panel-title">{if empty($smarty.session.Kunde)}{lang key='login'}{else}{lang key='hello'}, {$smarty.session.Kunde->cVorname} {$smarty.session.Kunde->cNachname}{/if}</h5>
    </div>
    <div class="panel-body">
        {if empty($smarty.session.Kunde->kKunde)}
            <form action="{get_static_route id='jtl.php' secure=true}" method="post" class="form box_login evo-validate">
                <input type="hidden" name="login" value="1" />
                {$jtl_token}
                <div class="form-group required">
                    <label for="email-box-login" class="control-label">{lang key='emailadress'}</label>
                    <input type="email" name="email" id="email-box-login" class="form-control" placeholder="{lang key='emailadress'}" required />
                </div>
                <div class="form-group required">
                    <label for="password-box-login" class="control-label">{lang key='password' section='account data'}</label>
                    <input type="password" name="passwort" id="password-box-login" class="form-control" placeholder="{lang key='password' section='account data'}" required />
                </div>

                {if isset($showLoginCaptcha) && $showLoginCaptcha}
                    <div class="form-group text-center float-label-control">
                        <div class="g-recaptcha" data-sitekey="{$Einstellungen.global.global_google_recaptcha_public}" data-callback="captcha_filled"></div>
                    </div>
                {/if}

                <div class="form-group">
                    {if !empty($oRedirect->cURL)}
                        {foreach name=parameter from=$oRedirect->oParameter_arr item=oParameter}
                            <input type="hidden" name="{$oParameter->Name}" value="{$oParameter->Wert}" />
                        {/foreach}
                        <input type="hidden" name="r" value="{$oRedirect->nRedirect}" />
                        <input type="hidden" name="cURL" value="{$oRedirect->cURL}" />
                    {/if}
                    <input type="submit" value="{lang key='login' section='checkout'}" class="btn btn-primary btn-block submit" />
                </div>
                <ul class="register-or-resetpw nav">
                    <li>
                        <a class="resetpw pull-left btn-block" href="{get_static_route id='pass.php' secure=true}">
                            {lang key='forgotPassword'}
                        </a>
                    </li>
                    <li>
                        <a class="register pull-left btn-block" href="{get_static_route id='registrieren.php'}">
                            {lang key='newHere'} {lang key='registerNow'}
                        </a>
                    </li>
                </ul>
            </form>
        {else}
            <a href="{get_static_route id='jtl.php'}" class="btn btn-default btn-block btn-sm btn-account">{lang key='myAccount'}</a>
            <a href="{get_static_route id='jtl.php'}?logout=1&token={$smarty.session.jtl_token}" class="btn btn-block btn-sm btn-warning btn-logout">{lang key='logOut'}</a>
        {/if}
    </div>
</section>