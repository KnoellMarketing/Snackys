{**
 * @copyright (c) 2006-2015 JTL-Software-GmbH, all rights reserved
 * @author JTL-Software-GmbH (www.jtl-software.de)
 *
 * use is subject to license terms
 * http://jtl-software.de/jtlshop3license.html
 *}

{if !isset($checkout)}
    {include file='register/inc_vcard_upload.tpl' id='registrieren.php'}
{/if}

<form method="post" action="{get_static_route id='registrieren.php'}" class="evo-validate">
    {$jtl_token}
    {include file='register/form/customer_account.tpl'}
    <hr>
    {if isset($checkout)}
        {include file='checkout/inc_shipping_address.tpl'}
    {/if}
    <input type="hidden" name="checkout" value="{if isset($checkout)}{$checkout}{/if}">
    <input type="hidden" name="form" value="1">
    <input type="hidden" name="editRechnungsadresse" value="{$editRechnungsadresse}">
    <input type="submit" class="btn btn-primary btn-lg pull-right submit submit_once" value="{lang key="sendCustomerData" section="account data"}">
</form>