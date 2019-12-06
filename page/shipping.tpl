{if !empty($hinweis)}
    <div class="alert alert-info">
        {$hinweis}
    </div>
{/if}
{if !empty($fehler)}
    <div class="alert alert-danger">
        {$fehler}
    </div>
{/if}

{if isset($Einstellungen.global.global_versandermittlung_anzeigen) && $Einstellungen.global.global_versandermittlung_anzeigen === 'Y' && isset($smarty.session.Warenkorb->PositionenArr) && $smarty.session.Warenkorb->PositionenArr|@count > 0}
    <form method="post" action="{if !empty($linkgroups->Link_Versandseite.$lang)}{$ShopURL}/{$linkgroups->Link_Versandseite.$lang}{else}navi.php{/if}{if $bExclusive}?exclusive_content=1{/if}" class="form form-inline evo-validate" id="shipping-calculator-form">
        {$jtl_token}
        <input type="hidden" name="s" value="{$Link->kLink}" />
        {include file='snippets/shipping_calculator.tpl' checkout=false}
    </form>
{else}
    {lang key="estimateShippingCostsNote" section="global"}
{/if}