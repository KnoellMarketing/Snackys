{include file="snippets/zonen.tpl" id="before_manufacturers" title="before_manufacturers"}
<div class="row row-eq-height sc-w clearfix row-multi" id="manu-row">
    {foreach name=hersteller from=$oHersteller_arr item=Hersteller}
        <div class="col-xs-6 col-md-4 col-lg-3">
			<div class="img-w mb-spacer mb-xs">
				<a href="{$Hersteller->cURL}" class="text-center im-w" title="{$Hersteller->cMetaTitle}"class="img-ct">
					<img src="{$Hersteller->cBildpfadNormal}" alt="{$Hersteller->cName}" />
				</a>
			</div>
			<div class="caption">
				<a href="{$Hersteller->cURL}" class="text-center im-w" title="{$Hersteller->cMetaTitle}">
					<span class="title h4 m0">
						{$Hersteller->cName}
					</span>
				</a>
			</div>
        </div>
    {/foreach}
</div>
