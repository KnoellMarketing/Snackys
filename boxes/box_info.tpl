{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if isset($linkgroups->Informationen)}
    <section class="panel panel-default box box-info" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{$linkgroups->Informationen->cLocalizedName|trans}
				{include file="snippets/careticon.tpl"}
			</span>
        </div>{* /panel-heading *}
        <div class="panel-body">
            <ul class="nav nav-list blanklist">
                {foreach name=Informationen from=$linkgroups->Informationen->Links item=Link}
                    <li>
                        <a href="{$Link->URL}"><span>{$Link->cLocalizedName|trans}</span></a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}
{/if}