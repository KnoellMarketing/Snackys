<root>
	<url>
		{if $smarty.post.paging=='prev'}
			{if $Suchergebnisse->Seitenzahlen->AktuelleSeite > 1}{$oNaviSeite_arr.zurueck->cURL}{else}false{/if}
		{else}
			{if $Suchergebnisse->Seitenzahlen->AktuelleSeite < $Suchergebnisse->Seitenzahlen->maxSeite}{$oNaviSeite_arr.vor->cURL}{else}false{/if}
		{/if}
	</url>
	<html>{foreach name=artikel from=$Suchergebnisse->Artikel->elemente item=Artikel}
		&lt;div class="p-w col-xs-6 col-sm-4 col-md-4 col-lg-3 pr{if $snackyConfig.hover_productlist === 'Y' && !$device->isMobile()} hv-e{/if}" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem"&gt;
			{include file='productlist/item_box.tpl' tplscope='gallery' class='thumbnail' assign="item_box"}{$item_box|htmlspecialchars}
		&lt;/div&gt;
	{/foreach}</html>
</root>