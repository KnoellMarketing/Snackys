{strip}
{has_boxes position='left' assign='hasLeftBox'}
{if !empty($Brotnavi) && !$bExclusive && !$bAjaxRequest && $nSeitenTyp != 18 && $nSeitenTyp != 11 && $nSeitenTyp != 38}
<div id="breadcrumb-wrapper" class="hidden-xs">
	<ol id="breadcrumb" class="breadcrumb mw-container dpflex-a-center" itemprop="breadcrumb" itemscope itemtype="http://schema.org/BreadcrumbList">
		{foreach name=navi from=$Brotnavi item=oItem}
			{if $smarty.foreach.navi.first}
				{block name="breadcrumb-first-item"}
				   <li class="breadcrumb-item first preload" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
						<a itemprop="item" href="{$oItem->urlFull}" title="{$oItem->name|escape:'html'}">
							<span class="image-content icon">
								<svg>
								  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-home"></use>
								</svg>
							</span>
							<span itemprop="name" class="hidden">{$oItem->name|escape:'html'}</span>
						</a>
						<meta itemprop="url" content="{$oItem->urlFull}" />
						<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
					</li>
				{/block}
			{elseif $smarty.foreach.navi.last}
				{block name="breadcrumb-last-item"}
					<li class="separator">
						<span class="css-arrow css-arrow-right"></span>
					</li>
							{if $oItem->name !== null}
								<li class="breadcrumb-item last" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
									<a itemprop="item" href="{$oItem->urlFull}" title="{$oItem->name|escape:'html'}">
										<span itemprop="name">{$oItem->name}</span>
									</a>
									<meta itemprop="url" content="{$oItem->urlFull}" />
									<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
								</li>
							{elseif isset($Suchergebnisse->SuchausdruckWrite)}
								<li class="breadcrumb-item last">
									{$Suchergebnisse->SuchausdruckWrite}
								</li>
							{/if}
					</li>
				{/block}
			{else}
				{block name="breadcrumb-item"}              
					<li class="separator">
						<span class="css-arrow css-arrow-right"></span>
					</li>
					<li class="breadcrumb-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
						<a itemprop="item" href="{$oItem->urlFull}" title="{$oItem->name|escape:'html'}">
							<span itemprop="name">{$oItem->name}</span>
						</a>
						<meta itemprop="url" content="{$oItem->urlFull}" />
						<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
					</li>
				{/block}
			{/if}
		{/foreach}
	</ol>
</div>
{/if}
{/strip}