{**
 * @copyright (c) 2006-2010 JTL-Software-GmbH, all rights reserved
 * @author JTL-Software-GmbH (www.jtl-software.de)
 *
 * use is subject to license terms
 * http://jtl-software.de/jtlshop3license.html
 *}

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