{* offcanvas navigation *}
<nav class="navbar navbar-default navbar-offcanvas" id="navbar-offcanvas">
    <div class="inside">
        <div class="inside-inside">
        {strip}
            <div class="container-fluid">
                {block name="megamenu-xs-nav"}
                <div class="navbar-collapse">
                    <ul class="nav navbar-nav navbar-right force-float action-nav preload">
                        {if isset($smarty.session.Kunde) && isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde > 0}
                            <li class="order-last">
                                <a href="{get_static_route id='jtl.php'}?logout=1" title="{lang key='logOut'}">
                                    <span class="image-content icon">
										<svg>
										  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-logout"></use>
										</svg>
									</span>
                                </a>
                            </li>
                        {/if}
                        <li>
                            <a href="{get_static_route id='jtl.php'}" title="{lang key='myAccount'}">
                                <span class="image-content icon">
									<svg>
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-user"></use>
									</svg>
								</span>
                            </a>
                        </li>
                        {*  WISH LIST *}
                        {if isset($smarty.session.Wunschliste->kWunschliste) && $smarty.session.Wunschliste->CWunschlistePos_arr|count > 0}
                        <li class="wish-list-menu preload visible-xxs">
                            <a href="{get_static_route id='wunschliste.php'}" title="{lang key="goToWishlist" sektion="global"}" class="link_to_wishlist">
                                    <span class="image-content icon">
										<svg>
										  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-heart"></use>
										</svg>
                                    </span>
                               {* <sup class="badge"><em>{$smarty.session.Wunschliste->CWunschlistePos_arr|count}</em></sup> *}
                            </a>
                        </li>
                        {/if}
                        {*  WISH LIST *}
                        <li>
                            <a href="{get_static_route id='warenkorb.php'}" title="{lang key='basket'}">
                                <span class="image-content icon">
									<svg>
									  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-cart"></use>
									</svg>
								</span>
                               {* {if $WarenkorbArtikelPositionenanzahl >= 1}
                                    <sup class="badge">
                                        <em>{$WarenkorbArtikelPositionenanzahl}</em>
                                    </sup>
                                {/if} *}
                                {*
                                <span class="shopping-cart-label">{$WarensummeLocalized[$NettoPreise]}</span>
                                *}
                            </a>
                        </li>
                    </ul>{* /row *}
                </div>
                {/block}{* /block megamenu-xs-nav *}
            </div>{* /container-fluid *}
        {/strip}
        {strip}
            {*
            <nav class="navbar navbar-inverse">
                <div class="container-fluid">
                    <div class="navbar-nav nav navbar-right text-right">
                        <a class="btn btn-offcanvas btn-default btn-close navbar-btn"></a>
                    </div>
                </div>
            </nav>
            *}
            <div class="container-fluid">
                <div class="sidebar-offcanvas">
                    {$firstelement = false}
					{if isset($Einstellungen.template.megamenu.show_pages) && $Einstellungen.template.megamenu.show_pages !== 'N'}
						{if $firstelement}
							<hr>
						{/if}
						{$firstelement = true}
						<ul class="nav navbar-nav">
							{include file='snippets/linkgroup_list-sidebar.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start' caret="fa fa-caret-down pull-right"}
						</ul>
					{/if}
					{if $firstelement}
						<hr>
					{/if}
                    {if isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
                        {$firstelement = true}
                        <div class="navbar-categories">
                            <ul class="nav navbar-nav">
                                {include file='snippets/categories_recursive-sidebar.tpl' i=0 categoryId=0 limit=3 caret='right'}
                            </ul>
                        </div>
                        {block name="megamenu-manufacturers"}
                            {if isset($Einstellungen.template.megamenu.show_manufacturers) && $Einstellungen.template.megamenu.show_manufacturers !== 'N'}
                                {get_manufacturers assign='manufacturers'}
                                {if !empty($manufacturers)}
                                    <hr>
                                    <div class="navbar-manufacturers">
                                        <ul class="nav navbar-nav navbar-right">
                                            <li class="">
                                                <span>
                                                    <a href="#" role="button" aria-haspopup="true" aria-expanded="false" title="{lang key='manufacturers'}">
                                                        {lang key='manufacturers'} 
                                                    </a>
                                                    
                                                </span>
                                                <ul class="">
                                                    {foreach name='hersteller' from=$manufacturers item='hst'}
                                                        <li role="presentation">
                                                            <a role="menuitem" tabindex="-1" href="{$hst->cSeo}" title="{$hst->cName|escape:"html"}">{$hst->cName|escape:"html"}</a>
                                                        </li>
                                                    {/foreach}
                                                </ul>
                                            </li>
                                        </ul>
                                    </div>
                                {/if}
                            {/if}
                        {/block}{* megamenu-manufacturers *}
                    {/if}
                    {block name="megamenu-pages"}
                        {if isset($Einstellungen.template.megamenu.show_pages) && $Einstellungen.template.megamenu.show_pages !== 'N'}
                            {$firstelement = true}
                            <ul class="nav navbar-nav">
                                {include file='snippets/linkgroup_list-sidebar.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu' caret="fa fa-caret-down pull-right"}
                            </ul>
                        {/if}
                    {/block}{* megamenu-pages *}
                    {block name="navbar-top-cms"}
                        {if !empty($linkgroups->Kopf)}
                            {if $firstelement}
                                <hr>
                            {/if}
                            <ul class="nav navbar-nav">
                                {foreach name=kopflinks from=$linkgroups->Kopf->Links item=Link}
                                    {if $Link->cLocalizedName|has_trans}
                                        <li class="{if isset($Link->aktiv) && $Link->aktiv == 1}active{/if}">
                                            <a href="{$Link->URL}" title="{$Link->cLocalizedName|trans}">{$Link->cLocalizedName|trans}</a>
                                        </li>
                                    {/if}
                                {/foreach}
                            </ul>
                        {/if}
                    {/block}{* /navbar-top *}
                </div>
            </div>
        {/strip}
        </div>
    </div>
    <div class="overlay-bg"></div>
</nav>