{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if isset($oBox->oLinkGruppe)}
    <section class="panel panel-default box box-linkgroup" id="box{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{$oBox->oLinkGruppe->cLocalizedName|trans}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>
        <div class="box-body nav-panel">
            <ul class="nav nav-list blanklist">
                {include file='snippets/linkgroup_recursive.tpl' linkgroupIdentifier=$oBox->oLinkGruppeTemplate dropdownSupport=true  tplscope='box'}
            </ul>
        </div>
    </section>
{/if}
{/if}