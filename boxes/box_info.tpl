{if isset($linkgroups->Informationen)}
    <section class="panel panel-default box box-info" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{$linkgroups->Informationen->cLocalizedName|trans}</h5>
        </div>{* /panel-heading *}
        <div class="panel-body">
            <ul class="nav nav-list">
                {foreach name=Informationen from=$linkgroups->Informationen->Links item=Link}
                    <li>
                        <a href="{$Link->URL}"><span>{$Link->cLocalizedName|trans}</span></a>
                    </li>
                {/foreach}
            </ul>
        </div>
    </section>
{/if}