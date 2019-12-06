{block name="logo"}
<span itemprop="name" class="hidden">{$meta_publisher}</span>
<meta itemprop="url" content="{$ShopURL}">
<meta itemprop="logo" content="{$ShopURL}/{$ShopLogoURL}">
<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded{if !empty($snackyConfig.mobileLogo)} hidden-xs{/if}">
	{if !empty($snackyConfig.svgLogo)}
		<img src="{$snackyConfig.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
	{else}
		{if isset($ShopLogoURL)}
			{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
		{else}
			<span class="h2">{$Einstellungen.global.global_shopname}</span>
		{/if}
	{/if}
</a>
{if !empty($snackyConfig.mobileLogo)}
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="loaded visible-xs">
		<img src="{$snackyConfig.mobileLogo}" alt="{$Einstellungen.global.global_shopname}">
	</a>
{/if}
{/block}