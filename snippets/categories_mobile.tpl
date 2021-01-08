{strip}
{assign var=max_subsub_items value=5}
{if $snackyConfig.megaHome == 0}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="home-icon mm-mainlink">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 26.25"><path d="M3.75 26.25h9.37v-7.5h3.76v7.5h9.37V15H30L15 0 0 15h3.75z"/></svg>
	</a>
</li>
{else if $snackyConfig.megaHome == 1}
<li class="is-lth{if $nSeitenTyp == 18} active{/if}">
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="mm-mainlink">
		{lang key="linkHome" section="custom"}
	</a>
</li>
{/if}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_recursive_mobile.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start'}
{/if}

{block name="megamenu-categories"}
{include file='snippets/categories_recursive_mobile.tpl' i=0 categoryId=0 limit={$snackyConfig.mmenu_subcats} caret='right'}
{/block}{* /megamenu-categories*}

{block name="megamenu-pages"}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_recursive_mobile.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
{/if}
{/block}{* megamenu-pages *}

{block name="megamenu-manufacturers"}
{if isset($snackyConfig.show_manufacturers) && $snackyConfig.show_manufacturers !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {get_manufacturers assign='manufacturers'}
    {if !empty($manufacturers)}
        <li class="dropdown-style mgm-fw{if (isset($NaviFilter->Hersteller) && !empty($NaviFilter->Hersteller->kHersteller)) || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
            {assign var="linkKeyHersteller" value=LinkHelper::getInstance()->getSpecialPageLinkKey(LINKTYP_HERSTELLER)}
            {if !empty($linkKeyHersteller)}{assign var="linkSEOHersteller" value=LinkHelper::getInstance()->getPageLinkLanguage($linkKeyHersteller)}{/if}
            {if isset($linkSEOHersteller)}
                <a href="{$linkSEOHersteller->cSeo}" class="mm-mainlink">
                    {$linkSEOHersteller->cName}
                    <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                </a>
            {else}
                <span class="mm-mainlink">
                    {lang key="manufacturers" section="global"}
                    <span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
                </span>
            {/if}
            <ul class="dropdown-menu keepopen{if $manufacturers|@count > 40} items-threecol{else if $manufacturers|@count > 20} items-twocol{/if}">
				{if isset($linkSEOHersteller) && $snackyConfig.mmenu_link_clickable == 'N'}
					<li class="title{if (isset($NaviFilter->Hersteller) && !empty($NaviFilter->Hersteller->kHersteller)) || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
						<a href="{$linkSEOHersteller->cSeo}" class="mm-mainlink">
							{lang key="showAll" section="global"}
						</a>
					</li>
				{/if}
				{foreach name=hersteller from=$manufacturers item=hst}
					<li class="title{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}"><a href="{$hst->cSeo}" class="dropdown-link defaultlink"><span class="notextov">{$hst->cName}</span></a></li>
				{/foreach}
            </ul>
        </li>
    {/if}
{/if}
{/block}{* megamenu-manufacturers *}
{if $snackyConfig.mmenu_show_shopnav == 'Y'}
<li class="visible-xs">
	<hr class="invisible">
</li>
<li class="dropdown-style visible-xs{if $nSeitenTyp == 4} active{/if}">
	<a href="jtl.php" title="{if empty($smarty.session.Kunde->kKunde)}{lang key='login'}{else}{lang key='hello'}{/if}" class="home-icon">
		<span class="dpflex-a-center">
			<span class="img-ct icon icon-wt op1">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-user"></use>
				</svg>
			</span>
			<span class="visible-xs text">
				{if empty($smarty.session.Kunde->kKunde)}
				{lang key="login"}
				{else}
				{lang key='myAccount'}
				{/if}
			</span>
		</span>
	</a>
</li>
{if isset($smarty.session.Wunschliste->kWunschliste) && $smarty.session.Wunschliste->CWunschlistePos_arr|count > 0}
<li class="dropdown-style visible-xs{if $nSeitenTyp == 16} active{/if}">
	<a href="{get_static_route id='wunschliste.php'}" title="{lang key="goToWishlist" sektion="global"}" class="home-icon">
		<span class="dpflex-a-center">
			<span class="img-ct icon icon-wt op1">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-heart"></use>
				</svg>
			</span>
			<span class="visible-xs text">
				{lang key="wishlist"}
			</span>
		</span>
	</a>
</li>
{/if}
{if isset($smarty.session.Vergleichsliste) && $smarty.session.Vergleichsliste->oArtikel_arr|count > 1}
<li class="dropdown-style visible-xs">
	<a href="{get_static_route id='vergleichsliste.php'}" title="{lang key="compare" sektion="global"}"{if $Einstellungen.vergleichsliste.vergleichsliste_target === 'blank'} target="_blank"{/if} class="popup home-icon">
		<span class="dpflex-a-center">
			<span class="img-ct icon icon-wt op1">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-compare"></use>
				</svg>
			</span>
			<span class="visible-xs text">
				{lang key="compare" sektion="global"}
			</span>
		</span>
	</a>
</li>
{/if}
<li class="dropdown-style visible-xs{if $nSeitenTyp == 3} active{/if}">
	<a href="{get_static_route id='warenkorb.php'}" title="{lang key='basket'}" class="home-icon">
		<span class="dpflex-a-center">
			<span class="img-ct icon icon-wt op1">
				<svg class="{if $darkHead == 'true' || $darkMode == 'true'}icon-darkmode{/if}">
				  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-cart"></use>
				</svg>
			</span>
			<span class="visible-xs text">{lang key='basket'}</span>
		</span>
	</a>
</li>
<li>
	<hr class="invisible">
</li>
{/if}
{/strip}
