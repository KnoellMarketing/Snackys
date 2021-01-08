{assign var="is_dropdown" value=false}
{if ($Merkmal->cTyp === 'SELECTBOX') && $Merkmal->oMerkmalWerte_arr|@count > 1}
    {assign var="is_dropdown" value=true}
{/if}

<ul {if isset($class)}class="{$class}" {else}class="nav nav-list blanklist blanklist"{/if}>
    {foreach name=filter from=$Merkmal->oMerkmalWerte_arr item=MerkmalWert}
        {assign var=kMerkmalWert value=$MerkmalWert->kMerkmalWert}
        {if $MerkmalWert->nAktiv}
            <li class="active">
                <a rel="nofollow" href="{$NaviFilter->URL->cAlleMerkmalWerte[$MerkmalWert->kMerkmalWert]}"{if $Merkmal->cTyp === 'BILD'} title="{$MerkmalWert->cWert}"{/if}>
                    <span class="badge">{$MerkmalWert->nAnzahl}</span>
                        <span class="value">
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' &&
                        !empty($MerkmalWert->cBildpfadKlein) &&
                        $MerkmalWert->cBildpfadKlein !== $BILD_KEIN_MERKMALWERTBILD_VORHANDEN}
							<span class="img-ct icon">
                            	<img src="{$snackyConfig.preloadImage}" data-src="{$MerkmalWert->cBildpfadKlein}" alt="{$MerkmalWert->cWert|escape:'html'}" class="vmiddle" />
							</span>
                        {/if}
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                            <span class="word-break">{$MerkmalWert->cWert|escape:'html'}</span>
                        {/if}
                    </span>
                </a>
            </li>
        {else}
            <li>
                <a rel="nofollow" href="{$MerkmalWert->cURL}"{if $Merkmal->cTyp === 'BILD'} title="{$MerkmalWert->cWert|escape:'html'}"{/if}>
                    <span class="badge">{$MerkmalWert->nAnzahl}</span>
                    <span class="value">
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'T' &&
                        !empty($MerkmalWert->cBildpfadKlein) &&
                        $MerkmalWert->cBildpfadKlein !== $BILD_KEIN_MERKMALWERTBILD_VORHANDEN}
							<span class="img-ct icon">
                            	<img src="{$snackyConfig.preloadImage}" data-src="{$MerkmalWert->cBildpfadKlein}" alt="{$MerkmalWert->cWert|escape:'html'}" class="vmiddle" />
							</span>
                        {/if}
                        {if $Einstellungen.navigationsfilter.merkmal_anzeigen_als !== 'B'}
                            <span class="word-break">{$MerkmalWert->cWert|escape:'html'}</span>
                        {/if}
                    </span>
                </a>
            </li>
        {/if}
    {/foreach}
</ul>
