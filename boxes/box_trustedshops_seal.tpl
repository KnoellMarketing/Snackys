{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if isset($oBox->anzeigen) && $oBox->anzeigen === 'Y' && $oBox->cLogoURL|strlen > 0}
    <section class="panel panel-default box box-trustedshops-seal" id="sidebox{$oBox->kBox}">
        {if $oBox->ePosition != 'bottom'}
            <div class="panel-heading">
                <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
					{lang key="safety" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
        {/if}
        <div class="panel-body text-center">
            <p><a href="{$oBox->cLogoURL}"><img src="{$oBox->cBild}" alt="{lang key="ts_signtitle" section="global"}" /></a></p>
            <small class="description">
                <a title="{lang key='ts_info_classic_title' section='global'} {$cShopName}" href="{$oBox->cLogoSiegelBoxURL}">{$cShopName} {lang key="ts_classic_text" section="global"}</a>
            </small>
        </div>
    </section>
{elseif isset($Boxen.TrustedShopsSiegelbox) && $Boxen.TrustedShopsSiegelbox->anzeigen === 'Y' && $Boxen.TrustedShopsSiegelbox->cLogoURL|strlen > 0}
    <section class="panel panel-default box box-trustedshops-seal" id="sidebox{$oBox->kBox}">
        {if $oBox->ePosition != 'bottom'}
            <div class="panel-heading">
                <span class="panel-title h5 dpflex-a-center dpflex-j-between">
					{lang key="safety" section="global"}
					{include file="snippets/careticon.tpl"}
				</span>
            </div>
        {/if}
        <div class="panel-body text-center">
            <p><a href="{$oBox->cLogoURL}"><img src="{$oBox->cBild}" alt="{lang key="ts_signtitle" section="global"}" /></a></p>
            <small class="description">
                <a title="{lang key='ts_info_classic_title' section='global'} {$cShopName}" href="{$oBox->cLogoSiegelBoxURL}">{$cShopName} {lang key="ts_classic_text" section="global"}</a>
            </small>
        </div>
    </section>
{/if}
{/if}