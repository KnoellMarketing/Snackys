
{block name="footer-sidepanel-left"}
	<aside id="sp-l"
		   class="hidden-print col-xs-12 {if $nSeitenTyp === 2 || $snackyConfig.sidepanelEverywhere == 'Y'} col-md-3 col-lg-3 col-xl-2{/if}{if $snackyConfig.scrollSidebox == 'Y'} scrollBoxes{/if}{if $snackyConfig.filterOpen == 1} collapse{/if}{if !isset($smarty.get.sidebar) & $device->isMobile()} lazy{/if}">
		{if isset($smarty.get.sidebar) || !$device->isMobile()}
			<div class="inside">
				<div class="visible-xs visible-sm">
					<span class="block h3">{lang key="filterBy" setion="global"}</span>
					<hr class="op0">
				</div>
				{block name="footer-sidepanel-left-content"}
					{$boxes.left}
				{/block}
			</div>
			<div class="visible-xs visible-sm overlay-bg"></div>
			<div class="visible-xs visible-sm close-sidebar close-btn"></div>
		{/if}
	</aside>
{/block}