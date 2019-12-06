{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    {if isset($smarty.session.Zahlungsart->nWaehrendBestellung) && $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
        <h1>{lang key="orderCompletedPre" section="checkout"}</h1>
    {elseif $Bestellung->Zahlungsart->cModulId !== 'za_kreditkarte_jtl' && $Bestellung->Zahlungsart->cModulId !== 'za_lastschrift_jtl'}
        <h1>{lang key="orderCompletedPost" section="checkout"}</h1>
    {/if}
    

    {include file="snippets/extension.tpl"}
    
    <div class="order-completed">
        {include file='checkout/inc_paymentmodules.tpl'}
    
        {block name="order-completed"}
        {if !empty($oTrustedShopsBewertenButton->cPicURL)}
            <div>
                <a href="{$oTrustedShopsBewertenButton->cURL}" target="_blank"><img src="{$oTrustedShopsBewertenButton->cPicURL}" /></a>
            </div>
        {/if}
    
        {if isset($abschlussseite)}
            {include file='checkout/inc_order_completed.tpl'}
        {/if}
        {/block}
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}