{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

<form id="form-payment-extra" class="form payment-extra" method="post" action="bestellab_again.php">
    {$jtl_token}
    <fieldset class="outer">
        <input type="hidden" name="zusatzschritt" value="1" />
        <input type="hidden" name="kBestellung" value="{$Bestellung->kBestellung}" />

        {include file=$Bestellung->Zahlungsart->cZusatzschrittTemplate}

        <p class="box_plain">
            <input type="submit" value="{lang key="completeOrder" section="shipping payment"}" class="submit" />
        </p>
    </fieldset>
</form>