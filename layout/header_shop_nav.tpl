{strip}
<div class="header-shop-nav dpflex-a-center dpflex-j-end">
{if $Einstellungen.template.header.headerType == 1 || $Einstellungen.template.header.headerType == 2 || $Einstellungen.template.header.headerType == 3 || $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.header.headerType == 6 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 5.5}
{block name="navbar-productsearch"}
	<div class="search-toggle hidden-xs">
		<span class="image-content icon icon-xl">
			<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
			  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-search"></use>
			</svg>
		</span>
		<span class="image-content icon icon-xl">
			<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
			  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-close"></use>
			</svg>
		</span>
	</div>
{/block}
{/if}
{block name="navbar-top-user"}
	
	{*  ACCOUNT *}
	<div class="dropdown">
		<a href="#" data-toggle="modal" data-target="#login-popup" {if empty($smarty.session.Kunde->kKunde)}title="{lang key='login'}"{else}title="{lang key='hello'}"{/if}>
			<span class="image-content icon icon-xl">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-user"></use>
				</svg>
			</span>
		</a>
		{include file='layout/header_shopnav_user.tpl'}
	</div>
	{*  ACCOUNT END *}

{*  COMPARE LIST *}
{include file='layout/header_shop_nav_compare.tpl'}
{*  COMPARE LIST *}

{*  WISH LIST *}
{if isset($smarty.session.Wunschliste->kWunschliste) && $smarty.session.Wunschliste->CWunschlistePos_arr|count > 0}
<div class="wish-list-menu hidden-xs">
    <a href="{get_static_route id='wunschliste.php'}" title="{lang key="goToWishlist" sektion="global"}" class="link_to_wishlist">
            <span class="image-content icon icon-xl">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-heart"></use>
				</svg>
            </span>
        <sup class="badge"><em>{$smarty.session.Wunschliste->CWunschlistePos_arr|count}</em></sup>
    </a>
</div>
{/if}
{*  WISH LIST *}

{*  CART *}
<div class="cart-menu dropdown{if $WarenkorbArtikelanzahl >= 1} items{/if}{if $nSeitenTyp == 3} current{/if}{if !empty($hinweis)}{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt} open{/if}{/if}" data-toggle="basket-items">
    {include file='basket/cart_dropdown_label.tpl'}
</div>
{*  CART END *}
{/block}{* /navbar-top-user *}
</div>{* /shop-nav *}
{/strip}