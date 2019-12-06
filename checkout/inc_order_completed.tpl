<div id="order-confirmation" class="well well-sm">
    {block name="checkout-order-confirmation"}
        <div class="alert alert-info">{lang key="orderConfirmationPost" section="checkout"}</div>
        <p>{lang key="yourOrderId" section="checkout"}: {$Bestellung->cBestellNr}</p>
        <p>{lang key="yourChosenPaymentOption" section="checkout"}: {$Bestellung->cZahlungsartName}</p>
    {/block}
</div>

{include file='checkout/inc_conversion_tracking.tpl'}