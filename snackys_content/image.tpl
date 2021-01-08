<div class="image  {$entry->cClass}">
	{if $entry->cLink != ""}<a href="{$entry->cLink}">{/if}
	<span class="img-ct">
		<img src="{$snackyConfig.preloadImage}" data-src="{$entry->cBild}">
		{if $entry->cCaption != ""}
		{/if}
	</span>
    <span class="block caption">{$entry->cCaption}</span>
	{if $entry->cLink != ""}</a>{/if}
</div>