{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
<div class="panel-strap">{if $snackyConfig.optimize_content == "Y"}{eval var=$oBox->cInhalt|optimize}{else}{eval var=$oBox->cInhalt}{/if}</div>
{/if}