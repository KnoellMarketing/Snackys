
{foreach  name=kategorieauswahl from=$Suchergebnisse->Kategorieauswahl item=Kategorie}
	{if $Kategorie->nAnzahl >= 1}
		<li>
			<a rel="nofollow" href="{$Kategorie->cURL}">
				<span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Kategorie->nAnzahl}{/if}</span>
				<span class="value">
					{$Kategorie->cName|escape:'html'}
				</span>
			</a>
		</li>
	{/if}
{/foreach}
