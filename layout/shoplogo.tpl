{block name="logo"}
<span itemprop="name" class="hidden">{$meta_publisher}</span>
<meta itemprop="url" content="{$ShopURL}">
<meta itemprop="logo" content="{$ShopURL}/{$ShopLogoURL}">
<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded{if !empty($Einstellungen.template.header.mobileLogo)} hidden-xs{/if}">
	{if !empty($Einstellungen.template.header.svgLogo)}
		<img src="{$Einstellungen.template.header.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
	{else}
		{if isset($ShopLogoURL)}
			{* imagePreloadLogo src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive" *}
			{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
		{else}
			<span class="h2">{$Einstellungen.global.global_shopname}</span>
		{/if}
	{/if}
</a>
{if !empty($Einstellungen.template.header.mobileLogo)}
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded visible-xs">
		<img src="{$Einstellungen.template.header.mobileLogo}" alt="{$Einstellungen.global.global_shopname}">
	</a>
{/if}
{/block}