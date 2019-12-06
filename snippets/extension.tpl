{if $Einstellungen.template.homepage.fwSlider == 1}
	{assign "fwSlider" "false"}
{else}
	{assign "fwSlider" "true"}
{/if}
{if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.header.headerType == 5.5}
	{assign "fwHeader" "true"}
{else}
	{assign "fwHeader" "false"}
{/if}

<div id="extension-container">
{if (($Einstellungen.template.header.fullscreenElement != 0 && $fwHeader == 'true') || $fwHeader == 'false') && $nSeitenTyp === 18 && !empty($Einstellungen.template.header.youtubeID)}
	{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}
		<div class="mw-container mb-spacer">
	{else}
		<div class="mb-spacer">
	{/if}
	{include file="snippets/video.tpl"}
	</div>
{/if}
{if ($Einstellungen.template.header.fullscreenElement != 1 && $fwHeader == 'true') || $fwHeader == 'false'}
	{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}
		<div class="mw-container mb-spacer">
	{else}
		<div class="mb-spacer">
	{/if}
	{include file="snippets/slider.tpl"}
		</div>
{/if}
{if ($Einstellungen.template.header.fullscreenElement != 2 && $fwHeader == 'true') || $fwHeader == 'false'}
	{if ($fwSlider == 'false' || $fwHeader == 'true') && $nSeitenTyp === 18}
		<div class="mw-container mb-spacer">
	{else}
		<div class="mb-spacer">
	{/if}
	{include file="snippets/banner.tpl"}
		</div>
{/if}
</div>