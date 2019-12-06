<header class="hidden-print {if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout === 'fluid'}container-block{/if}{if $Einstellungen.template.theme.static_header === 'Y'} fixed-navbar{/if}" id="evo-nav-wrapper">
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
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-search"></use>
									</svg>
								</span>
								<span class="close"></span>
							</div>
						</div>
						<div id="search" class="col-xs-12 col-sm-4">
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
						<div class="col-xs-12 col-sm-4 preload hidden-xs">		
						{if $Einstellungen.template.header.headerSocial == 0}
							<ul class="social-head-wrapper">
							{if !empty($Einstellungen.template.footer.facebook)}
								<li>
								<a href="{if $Einstellungen.template.footer.facebook|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.facebook}" class="image-content icon btn-facebook" title="Facebook" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-facebook"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.twitter)}
								<li>
								<a href="{if $Einstellungen.template.footer.twitter|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.twitter}" class="image-content icon btn-twitter" title="Twitter" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-twitter"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.googleplus)}
								<li>
								<a href="{if $Einstellungen.template.footer.googleplus|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.googleplus}" class="image-content icon btn-googleplus" title="Google+" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-google-plus"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.youtube)}
								<li>
								<a href="{if $Einstellungen.template.footer.youtube|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.youtube}" class="image-content icon btn-youtube" title="YouTube" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-youtube"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.vimeo)}
								<li>
								<a href="{if $Einstellungen.template.footer.vimeo|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.vimeo}" class="image-content icon btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-vimeo"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.pinterest)}
								<li>
								<a href="{if $Einstellungen.template.footer.pinterest|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.pinterest}" class="image-content icon btn-pinterest" title="PInterest" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-pinterest"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.instagram)}
								<li>
								<a href="{if $Einstellungen.template.footer.instagram|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.instagram}" class="image-content icon btn-instagram" title="Instagram" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-instagram"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.skype)}
								<li>
								<a href="{if $Einstellungen.template.footer.skype|strpos:'skype:' !== 0}skype:{$Einstellungen.template.footer.skype}?add{else}{$Einstellungen.template.footer.skype}{/if}" class="image-content icon btn-skype" title="Skype" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-skype"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.xing)}
								<li>
								<a href="{if $Einstellungen.template.footer.xing|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.xing}" class="image-content icon btn-xing" title="Xing" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-xing"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($Einstellungen.template.footer.linkedin)}
								<li>
								<a href="{if $Einstellungen.template.footer.linkedin|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.linkedin}" class="image-content icon btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-linkedin"></use>
									</svg>
								</a>
								</li>
							{/if}
							</ul>
						{/if}
						</div>
						<div class="col-xs-4" id="logo" itemprop="publisher" itemscope itemtype="http://schema.org/Organization" itemid="">
							{include file='layout/shoplogo.tpl'}
						</div>
						{block name="header-branding-shop-nav"}
							<div class="col-xs-4">
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

{if $nSeitenTyp !== 11}
	<div class="category-nav navbar-wrapper hidden-xs" id="category-nav-wrapper">
		{include file="layout/header_category_nav.tpl"}
	</div>{* /category-nav *}

	{include file='layout/breadcrumb.tpl'}
{/if}