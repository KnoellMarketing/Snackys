<ul class="{if isset($class)}{$class}{else}nav nav-list blanklist{/if}">
    {if !empty($Suchergebnisse->Suchspecialauswahl[1]) && $Suchergebnisse->Suchspecialauswahl[1]->nAnzahl > 0}
        <li>
            <a href="{$Suchergebnisse->Suchspecialauswahl[1]->cURL}" rel="nofollow">
                <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Suchergebnisse->Suchspecialauswahl[1]->nAnzahl}{/if}</span>
                <span class="value">
                    {lang key="bestsellers" section="global"}
                </span>
            </a>
        </li>
    {/if}
    {if !empty($Suchergebnisse->Suchspecialauswahl[2]) && $Suchergebnisse->Suchspecialauswahl[2]->nAnzahl > 0}
        <li>
            <a href="{$Suchergebnisse->Suchspecialauswahl[2]->cURL}" rel="nofollow">
                <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Suchergebnisse->Suchspecialauswahl[2]->nAnzahl}{/if}</span>
                <span class="value">
                    {lang key="specialOffer" section="global"}
                </span>
            </a>
        </li>
    {/if}
    {if !empty($Suchergebnisse->Suchspecialauswahl[3]) && $Suchergebnisse->Suchspecialauswahl[3]->nAnzahl > 0}
        <li>
            <a href="{$Suchergebnisse->Suchspecialauswahl[3]->cURL}" rel="nofollow">
                <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) ||! $nMaxAnzahlArtikel}{$Suchergebnisse->Suchspecialauswahl[3]->nAnzahl}{/if}</span>
                <span class="value">
                    {lang key="newProducts" section="global"}
                </span>
            </a>
        </li>
    {/if}
    {if !empty($Suchergebnisse->Suchspecialauswahl[4]) && $Suchergebnisse->Suchspecialauswahl[4]->nAnzahl > 0}
        <li>
            <a href="{$Suchergebnisse->Suchspecialauswahl[4]->cURL}" rel="nofollow">
                <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Suchergebnisse->Suchspecialauswahl[4]->nAnzahl}{/if}</span>
                <span class="value">
                    {lang key="topOffer" section="global"}
                </span>
            </a>
        </li>
    {/if}
    {if !empty($Suchergebnisse->Suchspecialauswahl[5]) && $Suchergebnisse->Suchspecialauswahl[5]->nAnzahl > 0}
        <li>
            <a href="{$Suchergebnisse->Suchspecialauswahl[5]->cURL}" rel="nofollow">
                <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Suchergebnisse->Suchspecialauswahl[5]->nAnzahl}{/if}</span>
                <span class="value">
                    {lang key="upcomingProducts" section="global"}
                </span>
            </a>
        </li>
    {/if}
    {if !empty($Suchergebnisse->Suchspecialauswahl[6]) && $Suchergebnisse->Suchspecialauswahl[6]->nAnzahl > 0}
        <li>
            <a href="{$Suchergebnisse->Suchspecialauswahl[6]->cURL}" rel="nofollow">
                <span class="badge pull-right">{if !isset($nMaxAnzahlArtikel) || !$nMaxAnzahlArtikel}{$Suchergebnisse->Suchspecialauswahl[6]->nAnzahl}{/if}</span>
                <span class="value">
                    {lang key="topReviews" section="global"}
                </span>
            </a>
        </li>
    {/if}
</ul>
