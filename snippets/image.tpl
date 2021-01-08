{counter assign=imgcounter print=0}
<div class="image-box">
    <div class="img-ct{if isset($second)} has-second{/if}">
		{if isset($noLazy) && $noLazy==1}
			<img alt="{$alt}" src="{$src}" data-id="{$imgcounter}" />
		{else}
			<img alt="{$alt}" src="{$snackyConfig.preloadImage}" data-src="{$src}" data-id="{$imgcounter}" />
		{/if}
		{if isset($second) && !$device->isMobile()}
		<span class="second-img block">
			<img alt="{$alt}" src="{$snackyConfig.preloadImage}" data-hover="{$second}" data-id="{$imgcounter}" />
		</span>
		{/if}
        {if !empty($src)}
            <meta itemprop="image" content="{$ShopURL}/{$src}">
        {/if}
    </div>
</div>