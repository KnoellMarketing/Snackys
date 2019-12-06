<a href="{get_static_route id='warenkorb.php'}" class="basket-opener preload" data-toggle="dropdown" title="{lang key='basket'}">
    <span class="image-content icon icon-xl">
		<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
		  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-cart"></use>
		</svg>
    </span>
    {if $WarenkorbArtikelPositionenanzahl >= 1}
        <sup class="badge">
            <em>{$WarenkorbArtikelPositionenanzahl}</em>
        </sup>
    {/if}
</a>
<ul class="cart-dropdown dropdown-menu dropdown-menu-right{if $smarty.session.Warenkorb->PositionenArr|@count == 0} no-items{/if}">
    <li class="inside">
        <div class="items-list">
            {include file='checkout/inc_order_items.tpl' isSidebar="1"}
        </div>
        {* if $smarty.session.Warenkorb->PositionenArr|@count > 0 *}
        <div class="fixed-btn-group{if $Einstellungen.template.theme.shopBButton == 1} one-button{/if}">
            <a href="{get_static_route id='warenkorb.php'}" class="btn btn-block{if $Einstellungen.template.theme.shopBButton == 1} btn-primary btn-lg{/if}" title="{lang key='gotoBasket'}"> {lang key='gotoBasket'}</a>
			{if $Einstellungen.template.theme.shopBButton == 0}
            <a href="{get_static_route id='bestellvorgang.php'}" class="btn btn-primary btn-block btn-lg">{lang key="checkout" section="basketpreview"}</a>
			{/if}
        </div>
        {* /if *}
    </li>
    <li class="overlay-bg"></li>
    <li class="close-sidebar"></li>
</ul>