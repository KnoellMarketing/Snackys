{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}
{if isset($editRechnungsadresse) && $editRechnungsadresse === 1 && !empty($smarty.session.Kunde->kKunde)}
    {assign var="unreg_form" value=0}
    {assign var="unreg_step" value=$step}
{else}
    {assign var="unreg_form" value=1}
    {assign var="unreg_step" value="formular"}
{/if}
{if !empty($fehlendeAngaben) && !$hinweis}
    <div class="alert alert-danger">{lang key="yourDataDesc" section="account data"}</div>
{/if}
{if $hinweis}
    <div class="alert alert-danger">{$hinweis}</div>
{/if}
<div class="row">
    <div class="col-xs-12">
        {block name="checkout-proceed-as-guest"}
            <div id="order-proceed-as-guest">
                {block name="checkout-proceed-as-guest-body"}
                    <form id="neukunde" method="post" action="{get_static_route id='bestellvorgang.php'}" class="evo-validate">
                        <div class="panel-wrap">
                            {$jtl_token}
                            {include file='checkout/inc_billing_address_form.tpl' step=$unreg_step}
                            {include file='checkout/inc_shipping_address.tpl'}
                        </div>
                        <div class="text-right">
                            <input type="hidden" name="unreg_form" value="{$unreg_form}" />
                            <input type="hidden" name="editRechnungsadresse" value="{$editRechnungsadresse}" />
                            <input type="submit" class="btn btn-primary btn-lg submit submit_once" value="{lang key="sendCustomerData" section="account data"}" />
                        </div>
                    </form>
                {/block}
            </div>
        {/block}
    </div>
</div>