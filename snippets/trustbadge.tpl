{if $Einstellungen.template.trustedshops.show_trustbadge === 'Y'}
    {ts_data assign=tsData}
    {if $tsData.tsId !== '' && $tsData.nAktiv == true}
        <script type="text/javascript">
            {literal}
            (function () {
                var _tsid = '{/literal}{$tsData.tsId}{literal}';
                _tsConfig = {
                    'yOffset': '{/literal}{$Einstellungen.template.trustedshops.trustbadge_yoffset}{literal}',
                    'variant': '{/literal}{$Einstellungen.template.trustedshops.trustbadge_variant}{literal}'
                };
                var _ts = document.createElement('script');
                _ts.type = 'text/javascript';
                _ts.async = true;
                _ts.charset = 'utf-8';
                _ts.src = '//widgets.trustedshops.com/js/' + _tsid + '.js';
                var __ts = document.getElementsByTagName('script')[0];
                __ts.parentNode.insertBefore(_ts, __ts);
            })();
            {/literal}
        </script>
        <noscript>
            <div>
                <a href="https://www.trustedshops.de/shop/certificate.php?shop_id={$tsData.tsId}"><img alt="Trusted-Shops-Trust-Badge" title=" Klicken Sie auf das G&uuml;tesiegel, um die G&uuml;ltigkeit zu pr&uuml;fen!" src="//widgets.trustedshops.com/images/badge.png" style="position:fixed;bottom:0;right:0;" /></a>
            </div>
        </noscript>
    {/if}
{/if}