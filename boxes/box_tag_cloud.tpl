{if (isset($Boxen.Tagwolke->Tagbegriffe) && $Boxen.Tagwolke->Tagbegriffe|@count > 0) || (isset($oBox->Tagbegriffe) && $oBox->Tagbegriffe|@count > 0)}
    <section class="panel panel-default box box-tagcloud" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <h5 class="panel-title">{lang key="tagcloud" section="global"}</h5>
        </div>
        <div class="panel-body">
            <div class="tagbox">
                {if isset($oBox->Tagbegriffe)}
                    {assign var=from value=$oBox->Tagbegriffe}
                {else}
                    {assign var=from value=$Boxen.Tagwolke->Tagbegriffe}
                {/if}
                {foreach name=suchwolken from=$from item=Wolke}
                    <a href="{$Wolke->cURL}" class="tag{$Wolke->Klasse} btn btn-xs">{$Wolke->cName}</a>
                {/foreach}
            </div>
        </div>
    </section>
{/if}