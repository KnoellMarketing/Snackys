{assign var="tDir" value=$currentTemplateDir}
{if isset($parentTemplateDir)}
	{if !file_exists('{$currentTemplateDir}/layout/footer.tpl')}
		{assign var="tDir" value=$parentTemplateDir}
	{/if}
{/if}
{extends file="{$tDir}/layout/footer.tpl"}

{block name="footer-sidepanel-left"}
{/block}

{block name="footer-boxes"}
	{getLink nLinkart=12 cAssign="linkdatenschutz"}
	{getLink nLinkart=27 cAssign="linkimpressum"}
	{if $linkimpressum || $linkdatenschutz}
		<div class="mw-container text-center small">
			{if $linkdatenschutz}<a href="{$linkdatenschutz->Sprache->cSeo}" rel="nofollow">{$linkdatenschutz->Sprache->cName}</a>{/if}
			{if $linkimpressum && $linkdatenschutz} - {/if}
			{if $linkimpressum}<a href="{$linkimpressum->Sprache->cSeo}" rel="nofollow">{$linkimpressum->Sprache->cName}</a>{/if}
		</div>
	{/if}
{/block}

{block name="footer-additional"}
{/block}{* /footer-additional *}

{block name="main-wrapper-closingtag"}
</div> {* /mainwrapper *}
{* Checkout Sidebar Cart *}
{if $device->isMobile() && !$device->isTablet()}
{else}
<div class="col-md-4 col-lg-3" id="checkout-cart">
    {*<div class="items-list">
    {include file="checkout/inc_order_items.tpl" isCheckout="1"}</div>
    <div id="checkout-total-sum">
        {if $NettoPreise}
            <div class="total-net">
                <span class="price_label"><strong>{lang key="totalSum" section="global"} ({lang key="net" section="global"}):</strong></span>
                <strong class="price total-sum">{$WarensummeLocalized[$NettoPreise]}</strong>
            </div>
        {/if}

        {if $Einstellungen.global.global_steuerpos_anzeigen !== 'N' && $Steuerpositionen|@count > 0}
            {foreach name=steuerpositionen from=$Steuerpositionen item=Steuerposition}
                <div class="tax">
                    {if $Einstellungen.kaufabwicklung.warenkorb_produktbilder_anzeigen === 'Y'}
                        <td class="hidden-xs"></td>
                    {/if}
                    <span class="tax_label">{$Steuerposition->cName}:</span>
                    <span class="tax_label">{$Steuerposition->cPreisLocalized}</span>
                </div>
            {/foreach}
        {/if}

        {if isset($smarty.session.Bestellung->GuthabenNutzen) && $smarty.session.Bestellung->GuthabenNutzen == 1}
             <div class="customer-credit">
                 <span>{lang key="useCredit" section="account data"}</span>
                  <span>{$smarty.session.Bestellung->GutscheinLocalized}</span>
             </div>
        {/if}

        <div class="total info">
            <span class="price_label"><strong>{lang key="totalSum" section="global"}:</strong></span>
            <strong class="price total-sum">{$WarensummeLocalized[0]}</strong>
        </div>
    </div>*}
    {include file="basket/cart_dropdown_checkout.tpl"}
</div>
{/if}
{block name="footer-language"}
{/block}

{block name="aside"}{/block}
            
{block name="footer-currency"}
{/block}
{/block}