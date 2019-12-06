{**
 * @copyright (c) JTL-Software-GmbH
 * @license https://jtl-url.de/jtlshoplicense
 *}
{foreach $oNewsKategorie_arr as $oNewsKategorie}
    {if $selectedCat === $oNewsKategorie->getID()}{assign var='oCurNewsCat' value=$oNewsKategorie}{/if}
    <option value="{$oNewsKategorie->getID()}"
        {if isset($selectedCat)}
            {if is_array($selectedCat)}
                {foreach $selectedCat as $singleCat}
                    {if $singleCat->getID() === $oNewsKategorie->getID()} selected{/if}
                {/foreach}
            {elseif $selectedCat === $oNewsKategorie->getID()} selected{/if}
        {/if}>
        {for $j=1 to $i}-&nbsp;{/for}{$oNewsKategorie->getName()}
    </option>
    {if $oNewsKategorie->getChildren()->count() > 0}
        {include file='snippets/newscategories_recursive.tpl' i=$i+1 oNewsKategorie_arr=$oNewsKategorie->getChildren() selectedCat=$selectedCat}
    {/if}
{/foreach}
