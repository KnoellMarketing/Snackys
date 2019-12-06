{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
{if (isset($Boxen.Tagwolke->Tagbegriffe) && $Boxen.Tagwolke->Tagbegriffe|@count > 0) || (isset($oBox->Tagbegriffe) && $oBox->Tagbegriffe|@count > 0)}
    <section class="panel panel-default box box-tagcloud" id="sidebox{$oBox->kBox}">
        <div class="panel-heading">
            <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
				{lang key="tagcloud" section="global"}
				{include file="snippets/careticon.tpl"}
			</span>
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
{/if}