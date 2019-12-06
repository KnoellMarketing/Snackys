<header class="hidden-print {if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout === 'fluid'}container-block{/if}{if $snackyConfig.static_header === 'Y'} fixed-navbar{/if}" id="evo-nav-wrapper">
	<div class="container">
		{block name="header-container-inner"}
			{block name="header-branding"}
				{block name="header-branding-content"}
					<div id="shop-nav">
						<div class="inside">
						<div class="col-xs-4 visible-xs">
							<div id="mobile-nav-toggle" class="pr">
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
							<div id="sr-tg-m" class="pr">
								<span class="img-ct icon">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-search"></use>
									</svg>
								</span>
								<span class="close"></span>
							</div>
						</div>
						<div id="search" class="col-xs-12 col-sm-4">
							<form action="navi.php" method="GET">
								<div class="input-group">
									<input name="qs" type="text" class="form-control ac_input" placeholder="{lang key='search'}" autocomplete="off" aria-label="{lang key='search'}"/>
									<span class="input-group-addon pr">
										<button type="submit" name="search" id="search-submit-button" aria-label="{lang key='search'}">
											<span class="img-ct icon">
												<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
												  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-search"></use>
												</svg>
											</span>
										</button>
									</span>
								</div>
							</form>
						</div>
						<div class="col-xs-12 col-sm-4 pr hidden-xs">		
						{if $snackyConfig.headerSocial == 0}
							<ul class="social-head-wrapper">
							{if !empty($snackyConfig.facebook)}
								<li>
								<a href="{if $snackyConfig.facebook|strpos:'http' !== 0}https://{/if}{$snackyConfig.facebook}" class="img-ct icon btn-facebook" title="Facebook" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-facebook"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.twitter)}
								<li>
								<a href="{if $snackyConfig.twitter|strpos:'http' !== 0}https://{/if}{$snackyConfig.twitter}" class="img-ct icon btn-twitter" title="Twitter" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-twitter"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.googleplus)}
								<li>
								<a href="{if $snackyConfig.googleplus|strpos:'http' !== 0}https://{/if}{$snackyConfig.googleplus}" class="img-ct icon btn-googleplus" title="Google+" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-google-plus"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.youtube)}
								<li>
								<a href="{if $snackyConfig.youtube|strpos:'http' !== 0}https://{/if}{$snackyConfig.youtube}" class="img-ct icon btn-youtube" title="YouTube" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-youtube"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.vimeo)}
								<li>
								<a href="{if $snackyConfig.vimeo|strpos:'http' !== 0}https://{/if}{$snackyConfig.vimeo}" class="img-ct icon btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-vimeo"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.pinterest)}
								<li>
								<a href="{if $snackyConfig.pinterest|strpos:'http' !== 0}https://{/if}{$snackyConfig.pinterest}" class="img-ct icon btn-pinterest" title="PInterest" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pinterest"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.instagram)}
								<li>
								<a href="{if $snackyConfig.instagram|strpos:'http' !== 0}https://{/if}{$snackyConfig.instagram}" class="img-ct icon btn-instagram" title="Instagram" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-instagram"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.skype)}
								<li>
								<a href="{if $snackyConfig.skype|strpos:'skype:' !== 0}skype:{$snackyConfig.skype}?add{else}{$snackyConfig.skype}{/if}" class="img-ct icon btn-skype" title="Skype" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-skype"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.xing)}
								<li>
								<a href="{if $snackyConfig.xing|strpos:'http' !== 0}https://{/if}{$snackyConfig.xing}" class="img-ct icon btn-xing" title="Xing" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-xing"></use>
									</svg>
								</a>
								</li>
							{/if}
							{if !empty($snackyConfig.linkedin)}
								<li>
								<a href="{if $snackyConfig.linkedin|strpos:'http' !== 0}https://{/if}{$snackyConfig.linkedin}" class="img-ct icon btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
									<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
									  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-linkedin"></use>
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
	{if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout !== 'fluid'}
		<div class="container">
	{/if}

	{block name="header-category-nav"}
	{/block}


	{if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout !== 'fluid'}
		</div>{* /container-block *}
	{/if}
</header>

{if $nSeitenTyp !== 11}
	<div class="category-nav navbar-wrapper hidden-xs" id="cat-w">
		{include file="layout/header_category_nav.tpl"}
	</div>{* /category-nav *}

	{include file='layout/breadcrumb.tpl'}
{/if}