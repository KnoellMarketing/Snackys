{strip}
{has_boxes position='left' assign='hasLeftBox'}
{if !empty($Brotnavi) && !$bExclusive && !$bAjaxRequest && $nSeitenTyp != 18 && $nSeitenTyp != 11 && $nSeitenTyp != 38}
<div id="bc-w" class="hidden-xs{if $snackyConfig.headerType == 7} small{/if}">
	<ol id="bc" class="bc mw-container dpflex-a-center" itemprop="bc" itemscope itemtype="http://schema.org/bcList">
		{foreach name=navi from=$Brotnavi item=oItem}
			{if $smarty.foreach.navi.first}
				{block name="bc-first-item"}
				   <li class="bc-item first pr" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
						<a itemprop="item" href="{$oItem->urlFull}" title="{$oItem->name|escape:'html'}">
							<span class="img-ct icon">
								<svg>
								  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-home"></use>
								</svg>
							</span>
							<span itemprop="name" class="hidden">{$oItem->name|escape:'html'}</span>
						</a>
						<meta itemprop="url" content="{$oItem->urlFull}" />
						<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
					</li>
				{/block}
			{elseif $smarty.foreach.navi.last}
				{block name="bc-last-item"}
					<li class="separator">
						<span class="ar ar-r"></span>
					</li>
							{if $oItem->name !== null}
								<li class="bc-item last" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
									<a itemprop="item" href="{$oItem->urlFull}" title="{$oItem->name|escape:'html'}">
										<span itemprop="name">{$oItem->name}</span>
									</a>
									<meta itemprop="url" content="{$oItem->urlFull}" />
									<meta itemprop="position" content="{$smarty.foreach.navi.iteration}" />
								</li>
							{elseif isset($Suchergebnisse->SuchausdruckWrite)}
								<li class="bc-item last">
									{$Suchergebnisse->SuchausdruckWrite}
								</li>
							{/if}
					</li>
				{/block}
			{else}
				{block name="bc-item"}              
					<li class="separator">
						<span class="ar ar-r"></span>
					</li>
					<li class="bc-item" itemprop="itemListElement" itemscope itemtype="http://schema.org/ListItem">
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