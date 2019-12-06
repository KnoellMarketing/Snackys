{counter assign=imgcounter print=0}
<div class="image-box">
    <div class="image-content{if isset($second)} has-second{/if}">
        <img alt="{$alt}" src="{$snackysTemplate}img/preload/1x1.png" data-src="{$src}" data-id="{$imgcounter}" />
		{if isset($second)}
		<div class="second-img">
			<img alt="{$alt}" src="{$snackysTemplate}img/preload/1x1.png" data-src="{$second}" data-id="{$imgcounter}" />
		</div>
		{/if}
        {if !empty($src)}
            <meta itemprop="image" content="{$ShopURL}/{$src}">
        {/if}
    </div>
</div>