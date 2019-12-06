{if empty($conversion_tracked)}
    {assign var="conversion_tracked" value=1}
	{assign var="coupon" value=""}
	{strip}
		<div id="conversiontracking"
		data-track-type="start" data-track-event="purchase" 
		data-track-p-value="{$Bestellung->fWarensummeNetto}"
		data-track-p-total="{$Bestellung->fGesamtsummeNetto}"
		data-track-p-currency="{$smarty.session.Waehrung->cISO}" 
		data-track-p-transaction_id="{$Bestellung->cBestellNr}"
		data-track-p-currency="{$smarty.session.Waehrung->cISO}" 
		data-track-p-tax="{$Bestellung->fSteuern}"
		data-track-p-shipping="{$Bestellung->fVersandNetto}"
		data-track-p-items='[{foreach name=artikel from=$Bestellung->Positionen item=Artikel}
			{if !$smarty.foreach.artikel.first},{/if}
			{if $Artikel->nPosTyp == $C_WARENKORBPOS_TYP_ARTIKEL}{ldelim}"id":"{if $snackyConfig.artnr == "id"}{$Artikel->Artikel->kArtikel}{else}{$Artikel->Artikel->cArtNr}{/if}","name":"{$Artikel->Artikel->cName|escape}","price":"{$Artikel->Artikel->Preise->fVKNetto}","quantity":"{$Artikel->nAnzahl}"{rdelim}
			{else}{if $Artikel->nPosTyp==3}{assign var="coupon" value=$Artikel->cName|trans|htmlspecialchars}{/if}{ldelim}"id":"PosTyp_{$Artikel->nPosTyp}","name":"PosTyp{$Artikel->nPosTyp}:{$Artikel->cName|escape}","price":"{$Artikel->fPreis}","quantity":"{$Artikel->nAnzahl}"{rdelim}{/if}

		{/foreach}]'
		{if $coupon!=""}data-track-p-coupon="{$coupon}"{/if}
		>
	{/strip}
        {block name="checkout-conversion-tracking"}
        {/block}
    </div>
	
	{assign var="sekundenAdd" value=$Bestellung->oEstimatedDelivery->longestMax*86400}
	{assign var="deliveryDate" value=$smarty.now+$sekundenAdd}
	
	{* Trusted Shops Checkout *}
	{if $snackyConfig.showTrusted == 0 && !empty($snackyConfig.trustedID)}
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