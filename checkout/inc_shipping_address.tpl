{if isset($fehlendeAngaben.shipping_address)}
    {assign var="fehlendeAngabenShipping" value=$fehlendeAngaben.shipping_address}
{else}
    {assign var="fehlendeAngabenShipping" value=null}
{/if}
{assign var="showShippingAddress" value=(isset($Lieferadresse) || !empty($kLieferadresse) || isset($forceDeliveryAddress))}
<div class="form-group checkbox control-toggle{if isset($forceDeliveryAddress)} hidden{/if}" id="checkout_register_shipping_address_div">
    <input type="hidden" name="shipping_address" value="1">
    <label for="checkout_register_shipping_address" class="btn-block{if isset($forceDeliveryAddress)} hidden{/if}" data-toggle="collapse" data-target="#select_shipping_address">
        <input id="checkout_register_shipping_address" class="radio-checkbox" type="checkbox" name="shipping_address" value="0"{if !$showShippingAddress} checked="checked"{/if} />
        <span class="control-label label-default">
            {lang key="shippingAdressEqualBillingAdress" section="account data"}
        </span>
    </label>
</div>
{block name="checkout-enter-shipping-address"}
<div id="select_shipping_address" class="" {if $showShippingAddress || $smarty.get.editLieferadresse} style="display:block;"{/if}>
    {block name="checkout-enter-shipping-address-body"}
    {if !empty($smarty.session.Kunde->kKunde) && isset($Lieferadressen) && $Lieferadressen|count > 0}
        <fieldset>
            <legend>{lang key="deviatingDeliveryAddress" section="account data"}</legend>
            <ul class="list-group form-group">
            {foreach name=lieferad from=$Lieferadressen item=adresse}
                {if $adresse->kLieferadresse>0}
                    <li class="list-group-item">
                        <div class="radio">
                            <label class="btn-block" for="delivery{$adresse->kLieferadresse}" data-toggle="collapse" data-target="#register_shipping_address.in">
                                <input class="radio-checkbox" type="radio" name="kLieferadresse" value="{$adresse->kLieferadresse}" id="delivery{$adresse->kLieferadresse}" {if $kLieferadresse == $adresse->kLieferadresse}checked{/if}>
                                <span class="control-label label-default">{if $adresse->cFirma}{$adresse->cFirma},{/if} {$adresse->cVorname} {$adresse->cNachname}
                                , {$adresse->cStrasse} {$adresse->cHausnummer}, {$adresse->cPLZ} {$adresse->cOrt}
                                    , {$adresse->angezeigtesLand}</span></label>
                        </div>
                    </li>
                {/if}
            {/foreach}
                <li class="list-group-item">
                    <div class="radio">
                        <label class="btn-block" for="delivery_new" data-toggle="collapse" data-target="#register_shipping_address:not(.in)">
                            <input class="radio-checkbox" type="radio" name="kLieferadresse" value="-1" id="delivery_new" {if $kLieferadresse == -1}checked{/if} required="required" aria-required="true">
                            <span class="control-label label-default">{lang key="createNewShippingAdress" section="account data"}</span>
                        </label>
                    </div>
                </li>
            </ul>
        </fieldset>
        <fieldset id="register_shipping_address" class="collapse collapse-non-validate{if $kLieferadresse != -1}} hidden{/if}" aria-expanded="{if $kLieferadresse == -1}}true{else}false{/if}">
            <legend>{lang key="createNewShippingAdress" section="account data"}</legend>
            {include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
            {include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
        </fieldset>
    {else}
        <fieldset>
            <legend>{lang key="createNewShippingAdress" section="account data"}</legend>
            {include file="checkout/customer_shipping_address.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
            {include file="checkout/customer_shipping_contact.tpl" prefix="register" fehlendeAngaben=$fehlendeAngabenShipping}
        </fieldset>
    {/if}
    {/block}
</div>
{/block}
{if isset($smarty.get.editLieferadresse) || $step === 'Lieferadresse'}
{literal}
    <script type="text/javascript">
        $(window).on('load', function () {
            $('#checkout_register_shipping_address').prop('checked', false);
            $('#select_shipping_address').addClass('in');
            $.evo.extended().smoothScrollToAnchor('#checkout_register_shipping_address');
        });
    </script>
{/literal}
{/if}