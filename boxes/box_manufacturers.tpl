{if ($oBox->ePosition == 'left' && !$device->isMobile()) || $oBox->ePosition != 'left'}
<section class="panel panel-default box box-manufacturers" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
			{lang key="manufacturers" section="global"}
			{include file="snippets/careticon.tpl"}
		</span>
    </div>
    {if $oBox->manufacturers|@count > 3 && $snackyConfig.filterPos != 1 && $oBox->ePosition == 'left'}
		<div class="box-body">
            <ul class="nav nav-list blanklist">
                {foreach name=hersteller from=$oBox->manufacturers item=hst}
                    <li><a href="{$hst->cSeo}" title="{$hst->cName|escape:"html"}">{$hst->cName|escape:"html"}</a></li>
					{if $smarty.foreach.hersteller.iteration == 3}
						<input type="radio" id="more-manufacturers{$smarty.foreach.hersteller.iteration}">
						<label for="more-manufacturers{$smarty.foreach.hersteller.iteration}" class="btn btn-xs">{lang key="showAll" section="global"}</label> 
					{/if}
                {/foreach}
            </ul>
        </div>
    {else}
        <div class="box-body">
            <ul class="nav nav-list blanklist">
                {foreach name=hersteller from=$oBox->manufacturers item=hst}
                    <li><a href="{$hst->cSeo}" title="{$hst->cName|escape:"html"}">{$hst->cName|escape:"html"}</a></li>
                {/foreach}
            </ul>
        </div>
    {/if}
</section>
{/if}
