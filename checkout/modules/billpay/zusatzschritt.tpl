<script type="application/javascript">
{literal}
var bpyReq = {},
    appPath = '//widgetcdn.billpay.de/checkout/1.x.x/';
(function(win, doc, appPath, objectName) {
    bpyReq = {
        "deps": ['main'],
        "baseUrl": appPath,
        "skipDataMain": true,
        "callback": function() {}
    };
    win['BillPayCheckout'] = objectName;
    win[objectName] = win[objectName] || function() {
        (win[objectName].queue = win[objectName].queue || []).push(arguments)
    };
    var requireJs = doc.createElement('script');
    requireJs.src = appPath + 'require.js';
    doc.getElementsByTagName('head')[0].appendChild(requireJs);
})(window, document, appPath, 'billpayCheckout');
{/literal}
</script>

{if $billpay_message}
    <div class="alert alert-danger box_{$billpay_message->cType}">{$billpay_message->cCustomerMessage}</div>
{/if}

{if isset($cMissing_arr) && $cMissing_arr|@count > 0}
    <div class="alert alert-danger">
        <p>{lang key="fillOut"}</p>
    </div>
{/if}

<div id="paypal_container" bpy-pm="{$widgetType}">
    <noscript>Bitte aktivieren Sie Javascript</noscript>
</div>

<br />

{if $widgetOptionsJSON}
<script type="text/javascript">
    billpayCheckout('options', {$widgetOptionsJSON});
    billpayCheckout('run', {ldelim} "container": "#paypal_container" {rdelim});
</script>
{/if}