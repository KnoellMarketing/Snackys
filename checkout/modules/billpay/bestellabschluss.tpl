{if $billpay_message}
    <div class="alert alert-danger box_{$billpay_message->cType}">{$billpay_message->cCustomerMessage}</div>
{/if}

{if isset($nPaymentType)}
    <div class="form">
        <fieldset id="billpay_form" class="final">
            {if $nState == 1}
                <div class="alert alert-info">
                    {if $nPaymentType == 1}
                        <p><strong>Bitte &uuml;berweisen Sie den Gesamtbetrag auf folgendes Konto</strong></p>
                        <table class="table table-striped">
                            <tbody>
                                <tr>
                                    <td>{lang key="accountHolder" section="checkout"}:</td><td>{$oPaymentInfo->cInhaber}</td>
                                </tr>
                                <tr>
                                    <td>{lang key="bank" section="checkout"}:</td><td>{$oPaymentInfo->cBankName}</td>
                                </tr>
                                <tr>
                                    <td>IBAN:</td><td>{$oPaymentInfo->cIBAN}</td>
                                </tr>
                                <tr>
                                    <td>BIC:</td><td>{$oPaymentInfo->cBIC}</td>
                                </tr>
                                <tr>
                                    <td>{lang key="purpose" section="checkout"}:</td><td>{$oPaymentInfo->cVerwendungszweck}</td>
                                </tr>
                            </tbody>
                        </table>
                    {elseif $nPaymentType == 2}
                        <p>
                            Vielen Dank, dass Sie sich f&uuml;r die Zahlung per Lastschrift mit BillPay entschieden haben. Wir buchen den f&auml;lligen Betrag in den n&auml;chsten Tagen von dem bei der Bestellung angegebenen Konto ab. 
                        </p>
                    {elseif $nPaymentType == 3}
                        <p>
                            Vielen Dank, dass Sie sich f&uuml;r den BillPay Ratenkauf entschieden haben. Sie bekommen in K&uuml;rze einen Ratenplan von uns zugesendet.
                        </p>
                    {elseif $nPaymentType == 4}
                        <p>
                            Vielen Dank, dass Sie sich f&uuml;r die Zahlung mit PayLater entschieden haben. Die f&auml;lligen Betr&auml;ge werden von dem bei der Bestellung angegebenen Konto abgebucht. Zus&auml;tzlich zu dieser Rechnung bekommen Sie von BillPay in K&uuml;rze einen Teilzahlungsplan mit detaillierten Informationen &uuml;ber Ihre Teilzahlung. 
                        </p>
                    {/if}
                </div>
            {elseif $nState == 2}
                <div class="row">
                    <div class="col-xs-12">
                        <div class="panel-wrap">
                            <div class="panel panel-default">
                                <div class="panel-heading"><h3 class="panel-title">Anzahlung</h3></div>
                                <div class="panel-body">
                                    {$oPaymentEx->cCampaignText}
                                    <p>Sehen Sie hier die angepassten <a href="{$oPaymentEx->cRateUrl}">Zahlungsdetails</a> nach erfolgreicher Anzahlung.</p>
                                    <a href="{$oPaymentEx->cRedirectUrl}" class="btn btn-primary btn-lg pull-right submit submit_once">Weiter zu giropay</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/if}
        </fieldset>
    </div>
{/if}
