{if isset($oBox->anzeigen) && $oBox->anzeigen === 'Y'}
    <section class="panel panel-default box box-trustedshops-reviews" id="sidebox{$oBox->kBox}">
        {if $oBox->ePosition != 'bottom'}
            <div class="panel-heading">
                <h5 class="panel-title">{lang key="trustedshopsRating" section="global"}</h5>
            </div>
        {/if}
        <div class="sidebox_content text-center">
            <a href="{$oBox->cBildPfadURL}" target="_blank"><img src="{$oBox->cBildPfad}" alt="Trusted-Shops-Kundenbewertung" /></a>
        </div>
        <span class="review-aggregate">
            <span class="rating">
                <span class="average">{$oBox->oStatistik->dDurchschnitt|string_format:"%.2f"}</span>
            </span>&nbsp;/&nbsp;<span class="best">{$oBox->oStatistik->dMaximum|string_format:"%.2f"}</span>
            &nbsp;von&nbsp;
            <span class="count">{$oBox->oStatistik->nAnzahl}</span>
            <a href="{$oBox->cBildPfadURL}" title="Bewertungen von {$Einstellungen.global.global_shopname}">Bewertungen
                von {$Einstellungen.global.global_shopname}
            </a>
        </span>
    </section>
{elseif isset($Boxen.TrustedShopsKundenbewertung) && $Boxen.TrustedShopsKundenbewertung->anzeigen === 'Y'}
    <section class="panel panel-default box box-trustedshops-reviews" id="sidebox{$oBox->kBox}">
        {if $oBox->ePosition != 'bottom'}
            <div class="panel-heading">
                <h5 class="panel-title">{lang key="trustedshopsRating" section="global"}</h5>
            </div>
        {/if}
        <div class="sidebox_content text-center">
            <a href="{$Boxen.TrustedShopsKundenbewertung->cBildPfadURL}" target="_blank"><img src="{$Boxen.TrustedShopsKundenbewertung->cBildPfad}" alt="Trusted-Shops-Kundenbewertung" /></a>
        </div>
        <span class="review-aggregate">
            <span class="rating">
                <span class="average">{$Boxen.TrustedShopsKundenbewertung->oStatistik->dDurchschnitt|string_format:"%.2f"}</span>
            </span>&nbsp;/&nbsp;<span class="best">{$Boxen.TrustedShopsKundenbewertung->oStatistik->dMaximum|string_format:"%.2f"}</span>
            &nbsp;von&nbsp;
            <span class="count">{$Boxen.TrustedShopsKundenbewertung->oStatistik->nAnzahl}</span>
            <a href="{$Boxen.TrustedShopsKundenbewertung->cBildPfadURL}" title="Bewertungen von {$Einstellungen.global.global_shopname}">Bewertungen
                von {$Einstellungen.global.global_shopname}</a></span>
    </section>
{/if}