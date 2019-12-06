{if !empty($hinweis)}
    <div class="alert alert-info">{$hinweis}</div>
{/if}
{if !empty($fehlendeAngaben) && !$hinweis}
    <div class="alert alert-danger">{lang key="yourDataDesc" section="account data"}</div>
{/if}
{if isset($fehlendeAngaben.email_vorhanden) && $fehlendeAngaben.email_vorhanden == 1}
    <div class="alert alert-danger">{lang key="emailAlreadyExists" section="account data"}</div>
{/if}
{if isset($fehlendeAngaben.formular_zeit) && $fehlendeAngaben.formular_zeit == 1}
    <div class="alert alert-danger">{lang key="formToFast" section="account data"}</div>
{/if}
{if isset($boxes.left) && !$bExclusive && !empty($boxes.left)}
    {assign var="withSidebar" value=1}
{else}
    {assign var="withSidebar" value=0}
{/if}

{if $snackyConfig.checkoutPosTabs == '0'}
	{assign var="loginClass" value="first"}
	{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
		{assign var="guestClass" value="last"}
	{else}
		{assign var="regClass" value="last"}
	{/if}
{elseif $snackyConfig.checkoutPosTabs == '1'}
	{assign var="loginClass" value="first"}
	{assign var="regClass" value="last"}
{elseif $snackyConfig.checkoutPosTabs == '2'}
	{assign var="regClass" value="first"}
	{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
		{assign var="guestClass" value="last"}
	{else}
		{assign var="loginClass" value="last"}
	{/if}
{elseif $snackyConfig.checkoutPosTabs == '3'}
	{assign var="regClass" value="first"}
	{assign var="loginClass" value="last"}
{elseif $snackyConfig.checkoutPosTabs == '4'}
	{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
		{assign var="guestClass" value="first"}
	{else}
		{assign var="loginClass" value="first"}
	{/if}
	{assign var="regClass" value="last"}
{elseif $snackyConfig.checkoutPosTabs == '5'}
	{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
		{assign var="guestClass" value="first"}
	{else}
		{assign var="regClass" value="first"}
	{/if}
	{assign var="loginClass" value="last"}
{/if}

<div id="register-customer" class="row">
	<div class="col-xs-12" id="choose-way">
		<div class="row pr">
			<div class="col-xs-4 step-box login {$loginClass}{if $loginClass == 'first'} active{/if}">
				<span class="img-ct">
					<svg>
					  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user-reg"></use>
					</svg>
				</span>
				<span>{lang key="COlogin" section="custom"}</span>
			</div>
			<div class="col-xs-4 step-box nouser reg {$regClass}{if $regClass == 'first' || !empty($hinweis) || !empty($fehlendeAngaben)} active{/if}">
				<span class="img-ct">
					<svg>
					  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user-new"></use>
					</svg>
				</span>
				<span>{lang key="COreg" section="custom"}</span>
			</div>
			{if $Einstellungen.kaufabwicklung.bestellvorgang_unregistriert === 'Y'}
			<div class="col-xs-4 step-box nouser guest {$guestClass}{if $guestClass == 'first'} active{/if}" id="checkout-guest-btn">
				<span class="img-ct">
					<svg>
					  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user-guest"></use>
					</svg>
				</span>
				<span>{lang key="COguest" section="custom"}</span>
			</div>
			{/if}
		</div>
	</div>
    <div id="existing-customer" class="col-xs-12{if $loginClass != 'first'} hidden{/if}"">
        <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form evo-validate" id="order_register_or_login">
            {block name="checkout-login"}
                <div class="panel-wrap">
                    {block name="checkout-login-body"}
                    <fieldset>
                        {$jtl_token}
                        <legend>{block name="checkout-login-title"}{lang key="alreadyCustomer" section="global"}{/block}</legend>
                        {include file="register/form/customer_login.tpl" withSidebar=$withSidebar}
                    </fieldset>
                    {/block}
                </div>
            {/block}
        </form>
    </div>
    <div id="customer" class="col-xs-12{if $loginClass == 'first'} hidden{/if}">
        <div>
            {include file='register/inc_vcard_upload.tpl' id='bestellvorgang.php'}
            <form method="post" action="{get_static_route id='bestellvorgang.php'}" class="form evo-validate" id="form-register">
                {block name="checkout-register"}
                    <div class="panel-wrap">
                        {block name="checkout-register-body"}
                            {$jtl_token}
                            {include file='register/form/customer_account.tpl' checkout=1 step="formular"}
                            <hr/>
                            {include file='checkout/inc_shipping_address.tpl'}
                        {/block}
                    </div>
                {/block}
                <div class="text-right">
                    <input type="hidden" name="checkout" value="1">
                    <input type="hidden" name="form" value="1">
                    <input type="hidden" name="editRechnungsadresse" value="0">
                    <input type="submit" class="btn btn-primary btn-lg submit submit_once" value="{lang key="sendCustomerData" section="account data"}">
                </div>
            </form>
        </div>
    </div>
</div>