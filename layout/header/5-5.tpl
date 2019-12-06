<header class="hidden-print {if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout === 'fluid'}container-block{/if}{if $Einstellungen.template.theme.static_header === 'Y'} fixed-navbar{/if}{if isset($oSlider) && count($oSlider->oSlide_arr) > 0} has-slider{/if}" id="evo-nav-wrapper">
	<div class="container">
		{block name="header-container-inner"}
			{block name="header-branding"}
				{block name="header-branding-content"}
					<div id="shop-nav">
						<div class="inside">
							<div class="col-xs-4 visible-xs">
								<div id="mobile-nav-toggle" class="preload">
									<div class="menu-toggle">
										<div class="hamburger">
											<span></span>
											<span></span>
											<span></span>
										</div>
										<div class="cross">
											<span></span>
											<span></span>
										</div>
									</div>
								</div>
								<div id="mobile-search-toggle" class="preload">
									<span class="image-content icon">
										<svg>
										  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-search"></use>
										</svg>
									</span>
									<span class="close"></span>
								</div>
							</div>
							<div class="col-xs-4 col-sm-6 col-md-6 col-lg-2" id="logo" itemprop="publisher" itemscope itemtype="http://schema.org/Organization" itemid="">
								{include file='layout/shoplogo.tpl'}
							</div>
							{if $nSeitenTyp !== 11}
								<div class="col-xs-12 col-sm-12 col-md-12 col-lg-8 header-shop-menu" id="search">	
									<div class="inside">
										<form action="navi.php" method="GET">
											<div class="input-group">
												<input name="qs" type="text" class="form-control ac_input" placeholder="{lang key='search'}" autocomplete="off" aria-label="{lang key='search'}"/>
												<span class="input-group-addon preload">
													<button type="submit" name="search" id="search-submit-button" aria-label="{lang key='search'}">
														<span class="image-content icon">
															<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
															  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-search"></use>
															</svg>
														</span>
													</button>
												</span>
											</div>
										</form>
									</div>
									<div class="category-nav navbar-wrapper hidden-xs" id="category-nav-wrapper">
										{include file="layout/header_category_nav.tpl"}
									</div>{* /category-nav *}
								</div>
							{/if}
							{block name="header-branding-shop-nav"}
								<div class="col-xs-4 col-sm-6 col-md-6 col-lg-2">
									{include file='layout/header_shop_nav.tpl'}
								</div>
							{/block}
						</div>
					</div>
				{/block}
			{/block}{* /header-branding *}
		{/block}
	</div>{* /container *}
	{if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout !== 'fluid'}
		<div class="container">
	{/if}

	{block name="header-category-nav"}
	{/block}


	{if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout !== 'fluid'}
		</div>{* /container-block *}
	{/if}
</header>


{if !empty($Einstellungen.template.header.youtubeID) && $nSeitenTyp == 18}
<div class="video-background">
	<video class="video-foreground" autoplay loop muted preload="auto" {if !empty($Einstellungen.template.header.youtubeID)}poster="{$Einstellungen.template.header.videoPhURL}"{/if} playsinline>
		<source src="{$Einstellungen.template.header.youtubeID}" type="video/mp4">
	</video>
</div>
{/if}
{if $nSeitenTyp !== 11}
	{include file='layout/breadcrumb.tpl'}
{/if}