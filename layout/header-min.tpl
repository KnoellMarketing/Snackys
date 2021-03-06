{assign var="tDir" value=$currentTemplateDir}
{if isset($parentTemplateDir)}
	{if !file_exists('{$currentTemplateDir}/layout/header.tpl')}
		{assign var="tDir" value=$parentTemplateDir}
	{/if}
{/if}
{extends file="{$tDir}/layout/header.tpl"}
{block name="main-wrapper-starttag"}
<div id="main-wrapper" class="main-wrapper{if $bExclusive} exclusive{/if}{if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout === 'boxed'} boxed{else} fluid{/if}{if $hasLeftPanel} aside-active{/if}">
{/block}

{block name="header-branding-top-bar"}
{/block}

{block name="header-branding-content"}
    <div id="shop-nav">
		<div class="mw-container dpflex-a-center dpflex-wrap">
			<div class="col-xs-6 col-lg-4 xs-order-1">
				<a href="{get_static_route id='warenkorb.php'}" title="{lang key="backToBasket" section="checkout"}" class="visible-xs pr">
					<span class="img-ct icon">
						<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
						  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-logout"></use>
						</svg>
					</span>
				</a>
				<a href="{get_static_route id='warenkorb.php'}" title="{lang key="backToBasket" section="checkout"}" class="btn text-muted hidden-xs">{lang key="backToBasket" section="checkout"}</a>
			</div>
			<div class="col-xs-6 col-lg-4" id="logo" itemprop="publisher" itemscope itemtype="http://schema.org/Organization" itemid="">
				{block name="logo"}
				<span itemprop="name" class="hidden">{$meta_publisher}</span>
				<meta itemprop="url" content="{$ShopURL}">
				<meta itemprop="logo" content="{$ShopURL}/{$ShopLogoURL}">
				<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="pr">
					{if !empty($snackyConfig.svgLogo)}
						<img src="{$snackyConfig.preloadImage}" data-src="{$snackyConfig.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
					{else}
						{if isset($ShopLogoURL)}
							{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
						{else}
							<span class="h2">{$Einstellungen.global.global_shopname}</span>
						{/if}
					{/if}
				</a>
				{/block}
			</div>
			{block name="header-branding-shop-nav"}
			{/block}
		</div>
    </div>
{/block}

{block name="header-category-nav"}
{/block}

{block name="header-bc"}
{/block}

{block name="content-starttag"}
    <div id="content" class="col-xs-12">
{/block}