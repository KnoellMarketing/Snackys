{block name="header-branding-content"}
<header class="hidden-print" id="shop-nav">
	<div class="mw-container dpflex-a-center dpflex-wrap">
		<div class="col-xs-4 visible-xs">
			{include file="snippets/mobilenav-toggle.tpl"}
			<div id="mobile-search-toggle" class="preload">
				<span class="image-content icon">
					<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
					  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-search"></use>
					</svg>
				</span>
				<span class="close"></span>
			</div>
		</div>
		<div id="search" class="col-xs-12 col-sm-4">
			{include file="snippets/header-search.tpl"}
		</div>
		<div class="col-xs-4" id="logo" itemprop="publisher" itemscope itemtype="http://schema.org/Organization" itemid="">
			{include file='layout/shoplogo.tpl'}
		</div>
		{block name="header-branding-shop-nav"}
			<div class="col-xs-4">
				{include file='layout/header_shop_nav.tpl'}
			</div>
		{/block}
	</div>
</header>
{/block}

{if $nSeitenTyp !== 11}
	<div id="category-nav-wrapper">
		{include file="layout/header_category_nav.tpl"}
	</div>{* /category-nav *}

	{include file='layout/breadcrumb.tpl'}
{/if}