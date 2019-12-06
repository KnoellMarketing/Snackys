{if empty($conversion_tracked)}
    {assign var="conversion_tracked" value=1}
	{assign var="coupon" value=""}
	{strip}
		<div id="conversiontracking"
		gtag-type="start" gtag-event="purchase" 
		gtag-p-value="{$Bestellung->fWarensummeNetto}"
		gtag-p-currency="{$smarty.session.Waehrung->cISO}" 
		gtag-p-transaction_id="{$Bestellung->cBestellNr}"
		gtag-p-currency="{$smarty.session.Waehrung->cISO}" 
		gtag-p-tax="{$Bestellung->fSteuern}"
		gtag-p-shipping="{$Bestellung->fVersandNetto}"
		gtag-p-items='[{foreach name=artikel from=$Bestellung->Positionen item=Artikel}
			{if !$smarty.foreach.artikel.first},{/if}
			{if $Artikel->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}{ldelim}"id":"{if $Einstellungen.template.analytics.artnr == "id"}{$Artikel->Artikel->kArtikel}{else}{$Artikel->Artikel->cArtNr}{/if}","name":"{$Artikel->Artikel->cName|escape}","price":"{$Artikel->Artikel->Preise->fVKNetto}","quantity":"{$Artikel->nAnzahl}"{rdelim}
			{else}{if $Artikel->nPosTyp==3}{assign var="coupon" value=$Artikel->cName|trans|htmlspecialchars}{/if}{ldelim}"id":"PosTyp_{$Artikel->nPosTyp}","name":"PosTyp{$Artikel->nPosTyp}:{$Artikel->cName|escape}","price":"{$Artikel->fPreis}","quantity":"{$Artikel->nAnzahl}"{rdelim}{/if}

		{/foreach}]'
		{if $coupon!=""}gtag-p-coupon="{$coupon}"{/if}
		>
	{/strip}
        {block name="checkout-conversion-tracking"}
        {* Google Analytics E-Commerce Tracking - deprecated, used by gtag (see code above) *}
        {* if !empty($Einstellungen.global.global_google_analytics_id)}
            <script type="text/javascript">
                var _gaq = _gaq || [];
                _gaq.push(['_setAccount', '{$Einstellungen.global.global_google_analytics_id}']);
                _gaq.push(['_gat._anonymizeIp']);
                _gaq.push(['_trackPageview']);

                (function () {ldelim}
                    var ga = document.createElement('script');
                    ga.type = 'text/javascript';
                    ga.async = true;
                    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
                    var s = document.getElementsByTagName('script')[0];
                    s.parentNode.insertBefore(ga, s);
                {rdelim})();

                {if $Einstellungen.global.global_google_ecommerce == 1}
                _gaq.push(['_addTrans',
                    '{$Bestellung->cBestellNr}',
                    '{if $Einstellungen.global.global_shopname}{$Einstellungen.global.global_shopname}{else}{$Firma->cName}{/if}',
                    '{$Bestellung->fWarensummeNetto}',
                    '{$Bestellung->fSteuern}',
                    '{$Bestellung->fVersandNetto}',
                    '{$smarty.session.Kunde->cOrt}',
                    '{$smarty.session.Kunde->cBundesland}',
                    '{$smarty.session.Kunde->cLand}'
                ]);

                {foreach name=Bestell item=order from=$Bestellung->Positionen}
                {if $order->nPosTyp == 1}
                _gaq.push(['_addItem',
                    '{$Bestellung->cBestellNr}',
                    '{$order->cArtNr}',
                    '{$order->cName}',
                    '{$order->Category}',
                    '{$order->fPreis}',
                    '{$order->nAnzahl|replace:",":"."}'
                ]);
                {/if}
                {/foreach}

                _gaq.push(['_trackTrans']);
                {/if}
            </script>
        {/if *}
        {/block}
    </div>
	
	{assign var="sekundenAdd" value=$Bestellung->oEstimatedDelivery->longestMax*86400}
	{assign var="deliveryDate" value=$smarty.now+$sekundenAdd}
	
	{* Trusted Shops Checkout *}
	{if $Einstellungen.template.trustedShops.showTrusted == 0 && !empty($Einstellungen.template.trustedShops.trustedID) && $Einstellungen.template.trustedShops.showTrusted}
		<div id="trustedShopsCheckout" style="display: none;">
			<span id="tsCheckoutOrderNr">{$Bestellung->cBestellNr}</span>
			<span id="tsCheckoutBuyerEmail">{$Kunde->cMail}</span>
			<span id="tsCheckoutOrderAmount">{$Bestellung->fGesamtsummeKundenwaehrung}</span>
			<span id="tsCheckoutOrderCurrency">{$Bestellung->Waehrung->cISO}</span>
			<span id="tsCheckoutOrderPaymentType">{$Bestellung->cZahlungsartName}</span>
			<span id="tsCheckoutOrderEstDeliveryDate">{$deliveryDate|date_format:"%Y-%m-%d"}</span>
		</div> 
	{/if}
{/if}