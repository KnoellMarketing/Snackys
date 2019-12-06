<section class="panel panel-default box box-manufacturers" id="sidebox{$oBox->kBox}">
    <div class="panel-heading">
        <h5 class="panel-title">{lang key="manufacturers" section="global"}</h5>
    </div>
    {if $oBox->manufacturers|@count > 10 && $Einstellungen.template.pdListing.filterPos != 1}
		<div class="box-body">
            <ul class="nav nav-list">
                {foreach name=hersteller from=$oBox->manufacturers item=hst}
                    <li><a href="{$hst->cSeo}" title="{$hst->cName|escape:"html"}">{$hst->cName|escape:"html"}</a></li>
					{if $smarty.foreach.hersteller.iteration == 10}
						<input type="radio" id="more-manufacturers{$smarty.foreach.hersteller.iteration}">
						<label for="more-manufacturers{$smarty.foreach.hersteller.iteration}" class="btn btn-xs">{lang key="showAll" section="global"}</label> 
					{/if}
                {/foreach}
            </ul>
        </div>
    {else}
        <div class="box-body">
            <ul class="nav nav-list">
                {foreach name=hersteller from=$oBox->manufacturers item=hst}
                    <li><a href="{$hst->cSeo}" title="{$hst->cName|escape:"html"}">{$hst->cName|escape:"html"}</a></li>
                {/foreach}
            </ul>
        </div>
    {/if}
</section>
