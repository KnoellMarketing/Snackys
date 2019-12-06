{if isset($abschlussseite) && $abschlussseite == 1}
    {include file='checkout/inc_trustedshops_excellence.tpl'}
{else}
    {assign var=cModulId value=$Bestellung->Zahlungsart->cModulId}
    {if (empty($oPlugin->oPluginZahlungsmethodeAssoc_arr[$cModulId]->cModulId) || $Bestellung->Zahlungsart->cModulId != $oPlugin->oPluginZahlungsmethodeAssoc_arr[$cModulId]->cModulId) && $Bestellung->Zahlungsart->cModulId|substr:0:10 !== 'za_billpay'
    && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
        {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
            <div class="alert alert-info">{lang key='orderConfirmationPre' section='checkout'}</div>
        {else}
            <div class="alert alert-info">{lang key='orderConfirmationPost' section='checkout'}</div>
        {/if}
    {/if}

    {if (empty($smarty.session.Zahlungsart->nWaehrendBestellung) || $smarty.session.Zahlungsart->nWaehrendBestellung != 1) && $Bestellung->Zahlungsart->cModulId|substr:0:10 !== 'za_billpay' && $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
        <div class="pament-method-during-order">
            <p>{lang key='yourOrderId' section='checkout'}: <strong>{$Bestellung->cBestellNr}</strong></p>
            <p>{lang key='yourChosenPaymentOption' section='checkout'}: <strong>{$Bestellung->cZahlungsartName}</strong></p>
        </div>
    {/if}
    <div class="payment-method-inner">
        {if $Bestellung->Zahlungsart->cModulId === 'za_rechnung_jtl'}
            {lang key='invoiceDesc' section='checkout'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_lastschrift_jtl'}
            {lang key='banktransferDesc' section='checkout'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_nachnahme_jtl'}
            {lang key='banktransferDesc' section='checkout'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_barzahlung_jtl'}
            {lang key='cashOnPickupDesc' section='checkout'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_paypal_jtl'}
            {include file='checkout/modules/paypal/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_kreditkarte_jtl'}
            {include file='account/retrospective_payment.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_eos_jtl'}
            {include file='checkout/modules/eos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_ut_stand_jtl'}
            {include file='checkout/modules/ut/bestellabschluss.tpl'}
        {elseif (substr($Bestellung->Zahlungsart->cModulId, 0, 8) === 'za_mbqc_')}
            {include file='checkout/modules/moneybookers_qc/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_wirecard_jtl'}
            {include file='checkout/modules/wirecard/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_postfinance_jtl'}
            {include file='checkout/modules/postfinance/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_paymentpartner_jtl'}
            {include file='checkout/modules/paymentpartner/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_cc_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_dd_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_gi_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_gi_self_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_invoice_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_prepaid_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_dd_self_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_ebank_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_uos_ebank_direct_jtl'}
            {include file='checkout/modules/uos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_eos_dd_jtl'}
            {include file='checkout/modules/eos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_eos_cc_jtl'}
            {include file='checkout/modules/eos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_eos_direct_jtl'}
            {include file='checkout/modules/eos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_eos_ewallet_jtl'}
            {include file='checkout/modules/eos/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_billpay_jtl'}
            {include file='checkout/modules/billpay/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_billpay_invoice_jtl'}
            {include file='checkout/modules/billpay/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_billpay_direct_debit_jtl'}
            {include file='checkout/modules/billpay/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_billpay_rate_payment_jtl'}
            {include file='checkout/modules/billpay/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_billpay_paylater_jtl'}
            {include file='checkout/modules/billpay/bestellabschluss.tpl'}
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_worldpay_jtl'}
            {lang key='worldpayDesc' section='checkout'}
            <br />
            {$worldpayform}
            <br />
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_moneybookers_jtl'}
            {lang key='moneybookersDesc' section='checkout'}
            <br />
            {$moneybookersform}
            <br />
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_ipayment_jtl'}
            {lang key='ipaymentDesc' section='checkout'}
            <br />
            {$ipaymentform}
            <br />
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_sofortueberweisung_jtl'}
            {lang key='sofortueberweisungDesc' section='checkout'}
            <br />
            {$sofortueberweisungform}
            <br />
        {elseif $Bestellung->Zahlungsart->cModulId === 'za_safetypay'}
            {lang key='safetypayDesc' section='checkout'}
            <br />
            {$safetypay_form}
            <br />
        {elseif !empty($oPlugin->oPluginZahlungsmethodeAssoc_arr[$cModulId]->cModulId) && $Bestellung->Zahlungsart->cModulId == $oPlugin->oPluginZahlungsmethodeAssoc_arr[$cModulId]->cModulId}
            {include file=$oPlugin->oPluginZahlungsmethodeAssoc_arr[$cModulId]->cTemplateFileURL}
        {/if}
        <br />
        {include file='checkout/inc_trustedshops_excellence.tpl'}
    </div>
{/if}

{include file='checkout/inc_conversion_tracking.tpl'}