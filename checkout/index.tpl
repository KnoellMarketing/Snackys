{block name="header"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/header-min.tpl'}
    {/if}
{/block}

{block name="content"}
    
            {include file="snippets/extension.tpl"}
    <div id="result-wrapper">
        <div id="checkout">
            {include file="checkout/inc_steps.tpl"}
            {if $step === 'accountwahl'}
                {include file='checkout/step0_login_or_register.tpl'}{*bestellvorgang_accountwahl.tpl*}
            {elseif $step === 'edit_customer_address' || $step === 'Lieferadresse'}
                {include file='checkout/step1_edit_customer_address.tpl'}{*bestellvorgang_unregistriert_formular.tpl*}
            {elseif $step === 'Versand' || $step === 'Zahlung'}
                {include file='checkout/step3_shipping_options.tpl'}{*bestellvorgang_versand.tpl*}
            {elseif $step === 'ZahlungZusatzschritt'}
                {include file='checkout/step4_payment_additional.tpl'}{*bestellvorgang_zahlung_zusatzschritt*}
            {elseif $step === 'Bestaetigung'}
                {include file='checkout/step5_confirmation.tpl'}{*bestellvorgang_bestaetigung*}
            {/if}
            
            {include file="checkout/inc_steps_next.tpl"}
        </div>
    </div>
    
    {if (isset($nWarenkorb2PersMerge) && $nWarenkorb2PersMerge === 1)}
	<div class="modal-dialog modal-lg">  <div class="modal-content">   <div class="modal-header"><h4 class="modal-title">{lang key="basket" section="global"}</h4></div>  <section class="tmp-modal-content">
	<div class="modal-body">
		{lang key="basket2PersMerge" section="login"}<div class="answer"><a href="{get_static_route id='bestellvorgang.php'}?basket2Pers=1">{lang key="yes" section="global"}</a><a href="javascript:void();" class="x">{lang key="no" section="global"}</a></div>
	</div>
	</section></div> </div>
    {/if}
    
    <script type="text/javascript">
        if (top.location !== self.location) {ldelim}
            top.location = self.location.href;
        {rdelim}
    </script>
{/block}

{block name="footer"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/footer-min.tpl'}
    {/if}
{/block}