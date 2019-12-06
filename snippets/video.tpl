<div class="video-background">
	<video class="video-foreground" autoplay loop muted preload="auto" {if !empty($snackyConfig.videoPhURL)}poster="{$snackyConfig.videoPhURL}"{/if} playsinline>
		<source src="{$snackyConfig.youtubeID}" type="video/mp4">
	</video>
</div>