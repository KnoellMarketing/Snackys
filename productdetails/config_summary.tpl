{strip}
    <tr>
        <td colspan="2">{$Artikel->cName}</td>
        <td class="text-right no-wrap">{$Artikel->Preise->cVKLocalized[$NettoPreise]}</td>
    </tr>
    {if $oKonfig->oKonfig_arr|@count > 0}
        {$isIgnoreMultiplier = false}
        {foreach from=$oKonfig->oKonfig_arr item=oKonfiggruppe}
            {if $oKonfiggruppe->bAktiv}
                {foreach from=$oKonfiggruppe->oItem_arr item=oKonfigitem}
                    {if $oKonfigitem->bAktiv && !$oKonfigitem->ignoreMultiplier()}
                        <tr>
                            <td class="no-wrap">{$oKonfigitem->fAnzahl} &times;</td>
                            <td class="word-break">{$oKonfigitem->getName()}</td>
                            <td class="text-right no-wrap">{$oKonfigitem->getFullPriceLocalized(true, false, $oKonfig->fAnzahl)}</td>
                        </tr>
                    {elseif $oKonfigitem->bAktiv && $oKonfigitem->ignoreMultiplier()}
                        {$isIgnoreMultiplier = true}
                    {/if}
                {/foreach}
            {/if}
        {/foreach}
        {if $isIgnoreMultiplier}
            <tr>
                <td colspan="3" class="highlighted">{lang key="one-off" section="checkout"}</td>
            </tr>
            {foreach from=$oKonfig->oKonfig_arr item=oKonfiggruppe}
                {if $oKonfiggruppe->bAktiv}
                    {foreach from=$oKonfiggruppe->oItem_arr item=oKonfigitem}
                        {if $oKonfigitem->bAktiv && $oKonfigitem->ignoreMultiplier()}
                            <tr>
                                <td class="no-wrap">{$oKonfigitem->fAnzahl} &times;</td>
                                <td class="word-break">{$oKonfigitem->getName()}</td>
                                <td class="text-right">{$oKonfigitem->getFullPriceLocalized()}</td>
                            </tr>
                        {/if}
                    {/foreach}
                {/if}
            {/foreach}
        {/if}
    {/if}
{/strip}
