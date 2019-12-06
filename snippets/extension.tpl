{if $snackyConfig.fwSlider == 1}
	{assign "fwSlider" "false"}
{else}
	{assign "fwSlider" "true"}
{/if}
{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5}
	{assign "fwHeader" "true"}
{else}
	{assign "fwHeader" "false"}
{/if}

<div id="extension-container">
{* if (($snackyConfig.fullscreenElement != 0 && $fwHeader == 'true') || $fwHeader == 'false') && $nSeitenTyp === 18 && !empty($snackyConfig.youtubeID)}
	{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}
		<div class="mw-container mb-spacer">
	{else}
		<div class="mb-spacer">
	{/if}
	{include file="snippets/video.tpl"}
	</div>
{/if *}
{if ($snackyConfig.fullscreenElement != 1 && $fwHeader == 'true') || $fwHeader == 'false'}
	{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}
		<div class="mw-container mb-spacer">
	{else}
		<div class="mb-spacer">
	{/if}
	{include file="snippets/slider.tpl"}
		</div>
{/if}
{if ($snackyConfig.fullscreenElement != 2 && $fwHeader == 'true') || $fwHeader == 'false'}
	{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}
		<div class="mw-container mb-spacer">
	{else}
		<div class="mb-spacer">
	{/if}
	{include file="snippets/banner.tpl"}
		</div>
{/if}
</div>