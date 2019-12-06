{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
<section class="panel panel-default box box-custom" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
			{$oBox->cTitel}
			{include file="snippets/careticon.tpl"}
		</span>
    </div>
    <div class="panel-body panel-strap">
		{if $snackyConfig.optimize_content == "Y"}{eval var=$oBox->cInhalt|optimize}{else}{eval var=$oBox->cInhalt}{/if}
        
    </div>
</section>
{/if}