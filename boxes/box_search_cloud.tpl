{if (isset($Boxen) && isset($Boxen.Suchwolke) && $Boxen.Suchwolke->Suchbegriffe|@count > 0) || (isset($oBox->Suchbegriffe) && $oBox->Suchbegriffe|@count > 0)}
    <section class="panel panel-default box box-searchcloud" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{lang key="searchcloud" section="global"}</h5>
        </div>
        <div class="panel-body">
            <div class="tagbox">
                {if isset($oBox->Suchbegriffe)}{*4.00*}
                    {assign var=from value=$oBox->Suchbegriffe}
                {else}{*3.19*}
                    {assign var=from value=$Boxen.Suchwolke->Suchbegriffe}
                {/if}
                {foreach name=suchwolken from=$from item=Suchwolken}
                    <a href="{$Suchwolken->cURL}" class="tag{$Suchwolken->Klasse}">{$Suchwolken->cSuche}</a>
                {/foreach}
            </div>
        </div>
    </section>
{/if}