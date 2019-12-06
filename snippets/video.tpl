<div class="video-background">
	<video class="video-foreground" autoplay loop muted preload="auto" {if !empty($Einstellungen.template.header.videoPhURL)}poster="{$Einstellungen.template.header.videoPhURL}"{/if} playsinline>
		<source src="{$Einstellungen.template.header.youtubeID}" type="video/mp4">
	</video>
</div>