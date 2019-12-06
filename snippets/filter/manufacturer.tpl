{snackysBasics}
<ul class="{if isset($class)}{$class}{else}nav nav-list{/if}">
    {foreach name=herstellerauswahl from=$Suchergebnisse->Herstellerauswahl item=Hersteller}
        {if $Hersteller->nAnzahl >= 1}
            <li>
                <a rel="nofollow" href="{$Hersteller->cURL}">
                    <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Hersteller->nAnzahl}{/if}</span>
                    <span class="value">
                        {$Hersteller->cName|escape:'html'}
                    </span>
                </a>
            </li>
        {/if}
    {/foreach}
</ul>
