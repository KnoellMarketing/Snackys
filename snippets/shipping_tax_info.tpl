{block name="vat-info"}
    {strip}
    {if !empty($taxdata.text)}
        {$taxdata.text}
    {else}
        {if $Einstellungen.global.global_ust_auszeichnung === 'auto'}
            {if $taxdata.net}
                {lang key='excl' section='productDetails'}
            {else}
                {lang key='incl' section='productDetails'}
            {/if}
            &nbsp;{$taxdata.tax}% {lang key='vat' section='productDetails'}
        {elseif $Einstellungen.global.global_ust_auszeichnung === 'endpreis'}
            {lang key='finalprice' section='productDetails'}
        {/if}
    {/if}
    {/strip}
    {if $Einstellungen.global.global_versandhinweis === 'zzgl'}
    ,
        {if $Einstellungen.global.global_versandfrei_anzeigen === 'Y' && $taxdata.shippingFreeCountries}
            {if $Einstellungen.global.global_versandkostenfrei_darstellung === 'D'}
                {lang key='noShippingcostsTo' section='global'} {lang key='noShippingCostsAtExtended' section='basket' printf=' ::: '}
                {foreach item=country key=cISO from=$taxdata.countries}
                    <abbr title="{$country}">{$cISO}</abbr>
                {/foreach}, <a href="{if isset($linkgroups->Link_Versandseite)}{$linkgroups->Link_Versandseite|trans}{else}{$smarty.session.Link_Versandseite|trans}{/if}" rel="nofollow" class="shipment popup">
                    {lang key='shipping' section='basket'}</a>
            {else}
                <a href="{$smarty.session.Link_Versandseite|trans}"
                   rel="nofollow" class="shipment popup"
                   data-toggle="tooltip" data-placement="left"
                   title="{$taxdata.shippingFreeCountries}, {lang key='else' section='global'} {lang key='plus' section='basket'} {lang key='shipping' section='basket'}">
                    {lang key='noShippingcostsTo' section='global'}
                </a>
            {/if}
        {elseif isset($smarty.session.cISOSprache) && ((isset($linkgroups->Link_Versandseite) && $linkgroups->Link_Versandseite|has_trans) || (isset($smarty.session.Link_Versandseite) && $smarty.session.Link_Versandseite|has_trans))}
            {lang key='plus' section='basket'} <a href="{if isset($linkgroups->Link_Versandseite)}{$linkgroups->Link_Versandseite|trans}{else}{$smarty.session.Link_Versandseite|trans}{/if}" rel="nofollow" class="shipment popup">
                {lang key='shipping' section='basket'}
            </a>
        {/if}
    {elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
        , {lang key='incl' section='productDetails'} <a href="{if isset($linkgroups->Link_Versandseite)}{$linkgroups->Link_Versandseite|trans}{else}{$smarty.session.Link_Versandseite|trans}{/if}" rel="nofollow" class="shipment">{lang key='shipping' section='basket'}</a>
    {/if}
{/block}

{block name="shipping-class"}
    {if !empty($taxdata.shippingClass) && $taxdata.shippingClass !== 'standard' && $Einstellungen.global.global_versandklasse_anzeigen === 'Y'}
        ({$taxdata.shippingClass})
    {/if}
{/block}