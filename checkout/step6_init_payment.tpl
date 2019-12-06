{block name="header"}
    {include file='layout/header.tpl'}
{/block}

{block name="content"}
    <div id="content">
        {if $smarty.session.Zahlungsart->nWaehrendBestellung == 1}
            <h1>{lang key="orderCompletedPre" section="checkout"}</h1>
        {else}
            <h1>{lang key="orderCompletedPost" section="checkout"}</h1>
        {/if}
        <div class="order_process">
            {include file='checkout/inc_order_items.tpl' tplscope='init-payment'}
            {include file='checkout/inc_paymentmodules.tpl'}
        </div>
    </div>
{/block}

{block name="footer"}
    {include file='layout/footer.tpl'}
{/block}