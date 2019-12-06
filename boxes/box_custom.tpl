<section class="panel panel-default box box-custom" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <h5 class="panel-title">{$oBox->cTitel}</h5>
    </div>
    <div class="panel-body panel-strap">
		{if $Einstellungen.template.general.optimize_content == "Y"}{eval var=$oBox->cInhalt|optimize}{else}{eval var=$oBox->cInhalt}{/if}
        
    </div>
</section>