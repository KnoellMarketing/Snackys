{strip}
{assign var=max_subsub_items value=5}
{if $Einstellungen.template.megamenu.megaHome == 0}
<li{if $nSeitenTyp == 18} class="active"{/if}>
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}" class="home-icon">
		<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 30 26.25"><path d="M3.75 26.25h9.37v-7.5h3.76v7.5h9.37V15H30L15 0 0 15h3.75z"/></svg>
	</a>
</li>
{else if $Einstellungen.template.megamenu.megaHome == 1}
<li{if $nSeitenTyp == 18} class="active"{/if}>
	<a href="{$ShopURL}" title="{$Einstellungen.global.global_shopname}">
		{lang key="linkHome" section="custom"}
	</a>
</li>
{/if}
{if isset($Einstellungen.template.megamenu.show_pages) && $Einstellungen.template.megamenu.show_pages !== 'N'}
    {include file='snippets/linkgroup_list_fullscreen.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start'}
{/if}

{block name="megamenu-categories"}
{if isset($Einstellungen.template.megamenu.show_categories) && $Einstellungen.template.megamenu.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {assign var='show_subcategories' value=false}
    {if isset($Einstellungen.template.megamenu.show_subcategories) && $Einstellungen.template.megamenu.show_subcategories !== 'N'}
        {assign var='show_subcategories' value=true}
    {/if}

    {get_category_array categoryId=0 assign='categories'}
    {if !empty($categories)}
        {if !isset($activeId)}
            {if isset($NaviFilter->Kategorie) && intval($NaviFilter->Kategorie->kKategorie) > 0}
                {$activeId = $NaviFilter->Kategorie->kKategorie}
            {elseif $nSeitenTyp == 1 && isset($Artikel)}
                {assign var='activeId' value=$Artikel->gibKategorie()}
            {elseif $nSeitenTyp == 1 && isset($smarty.session.LetzteKategorie)}
                {$activeId = $smarty.session.LetzteKategorie}
            {else}
                {$activeId = 0}
            {/if}
        {/if}
        {if !isset($activeParents) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
            {get_category_parents categoryId=$activeId assign='activeParents'}
        {/if}
        {foreach name='categories' from=$categories item='category'}
            {assign var='isDropdown' value=false}
            {if isset($category->bUnterKategorien) && $category->bUnterKategorien}
                {assign var='isDropdown' value=true}
            {/if}
            <li class="{if $isDropdown}megamenu-fw{/if}{if $category->kKategorie == $activeId || (isset($activeParents[0]) && $activeParents[0]->kKategorie == $category->kKategorie)} active{/if}">
                <a href="{$category->cURL}"{if $isDropdown} data-toggle="dropdown" data-hover="dropdown" data-delay="300" data-hover-delay="100" data-close-others="true"{/if}>
                    {$category->cKurzbezeichnung}
                    {if $isDropdown}<span class="css-arrow css-arrow-right"></span><span class="fa-caret-down visible-xs"></span>{/if}
                </a>
                {if $isDropdown}
                    <ul class="mm-fullscreen">
                        <li>
								<a class="category-title block" href="{$category->cURL}">
									{$category->cName}
								</a>
                                    {assign var=hasInfoColumn value=false}
                                    {if isset($Einstellungen.template.megamenu.show_maincategory_info) && $Einstellungen.template.megamenu.show_maincategory_info !== 'N' && ($category->cBildURL !== 'gfx/keinBild.gif' || !empty($category->cBeschreibung))}
                                        {assign var=hasInfoColumn value=true}
                                        <div class="visible-lg mega-info-lg top15 preload hiden-xs">
                                                {if $category->cBildURL !== 'gfx/keinBild.gif'}
                                                    <a class="image-content" href="{$category->cURL}">
                                                        <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$category->cBildURL}" class="img-responsive"
                                                             alt="{$category->cKurzbezeichnung|escape:'html'}">
                                                    </a>
                                                    <div class="clearall top15"></div>
                                                {/if}
                                                {if $category->cBildURL !== 'gfx/keinBild.gif'}<div class="description text-muted">{/if}{$category->cBeschreibung}{if $category->cBildURL !== 'gfx/keinBild.gif'}</div>{/if}
                                        </div>
                                    {/if}
                                        <div class="row row-eq-height row-eq-img-height {if $hasInfoColumn} hasInfoColumn{/if} subcat-list">
                                            {if $category->bUnterKategorien}
                                                {if !empty($category->Unterkategorien)}
                                                    {assign var=sub_categories value=$category->Unterkategorien}
                                                {else}
                                                    {get_category_array categoryId=$category->kKategorie assign='sub_categories'}
                                                {/if}
                                                {foreach name='sub_categories' from=$sub_categories item='sub'}
                                                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 category-wrapper top15{if $sub->kKategorie == $activeId || (isset($activeParents[1]) && $activeParents[1]->kKategorie == $sub->kKategorie)} active{/if}">
                                                            {if isset($Einstellungen.template.megamenu.show_category_images) && $Einstellungen.template.megamenu.show_category_images !== 'N'}
                                                                    <a class="img text-center preload block hidden-xs" href="{$sub->cURL}">
                                                                        <span class="image-content">
                                                                        <img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$sub->cBildURL}" class="image"
                                                                             alt="{$category->cKurzbezeichnung|escape:'html'}">
                                                                        </span>
                                                                    </a>
                                                            {/if}
                                                                    <a class="h5 title caption{if isset($Einstellungen.template.megamenu.show_category_images) && $Einstellungen.template.megamenu.show_category_images !== 'N'} text-center{/if}" href="{$sub->cURL}">
                                                                            {$sub->cKurzbezeichnung}
																		{if $show_subcategories && $sub->bUnterKategorien}
																		<span class="fa-caret-down visible-xs"></span>
																		{/if}
                                                                    </a>
                                                            {if $show_subcategories && $sub->bUnterKategorien}
                                                                {if !empty($sub->Unterkategorien)}
                                                                    {assign var=subsub_categories value=$sub->Unterkategorien}
                                                                {else}
                                                                    {get_category_array categoryId=$sub->kKategorie assign='subsub_categories'}
                                                                {/if}
                                                                <hr class="hr-sm hidden-xs">
                                                                <ul class="list-unstyled small subsub">
                                                                    {foreach name='subsub_categories' from=$subsub_categories item='subsub'}
                                                                        {if $smarty.foreach.subsub_categories.iteration <= $max_subsub_items}
                                                                            <li{if $subsub->kKategorie == $activeId || (isset($activeParents[2]) && $activeParents[2]->kKategorie == $subsub->kKategorie)} class="active"{/if}>
                                                                                <a href="{$subsub->cURL}">
                                                                                    {$subsub->cKurzbezeichnung}
                                                                                </a>
                                                                            </li>
                                                                        {else}
                                                                            <li class="more"><a href="{$sub->cURL}"><i class="fa fa-chevron-circle-right"></i> {lang key="more" section="global"} <span class="remaining">({math equation='total - max' total=$subsub_categories|count max=$max_subsub_items})</span></a></li>
                                                                            {break}
                                                                        {/if}
                                                                    {/foreach}
                                                                </ul>
                                                            {/if}
                                                    </div>
                                                {/foreach}
                                            {/if}
                                        </div>{* /row *}
                                    {* /mega-categories *}
                                {* /row *}
                            {* /megamenu-content *}
                        </li>
                    </ul>
                {/if}
            </li>
        {/foreach}
    {/if}
{/if}
{/block}{* /megamenu-categories*}

{block name="megamenu-pages"}
{if isset($Einstellungen.template.megamenu.show_pages) && $Einstellungen.template.megamenu.show_pages !== 'N'}
    {include file='snippets/linkgroup_list_fullscreen.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
{/if}
{/block}{* megamenu-pages *}

{block name="megamenu-manufacturers"}
{if isset($Einstellungen.template.megamenu.show_manufacturers) && $Einstellungen.template.megamenu.show_manufacturers !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {get_manufacturers assign='manufacturers'}
    {if !empty($manufacturers)}
        <li class="megamenu-fw{if (isset($NaviFilter->Hersteller) && !empty($NaviFilter->Hersteller->kHersteller)) || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
            {assign var="linkKeyHersteller" value=LinkHelper::getInstance()->getSpecialPageLinkKey(LINKTYP_HERSTELLER)}
            {if !empty($linkKeyHersteller)}{assign var="linkSEOHersteller" value=LinkHelper::getInstance()->getPageLinkLanguage($linkKeyHersteller)}{/if}
            {if isset($linkSEOHersteller)}
                <a href="{$linkSEOHersteller->cSeo}" data-toggle="dropdown" data-hover="dropdown" data-delay="300" data-hover-delay="100" data-close-others="true">
                    {$linkSEOHersteller->cName}
                    <span class="caret"></span>
                </a>
            {else}
                <a class="no-link" data-toggle="dropdown" data-hover="dropdown" data-delay="300" data-hover-delay="100" data-close-others="true">
                    {lang key="manufacturers" section="global"}
                    <span class="css-arrow css-arrow-right"></span><span class="fa-caret-down visible-xs"></span>
                </a>
            {/if}
            <ul class="mm-fullscreen">
                <li>
                        <div class="category-title manufacturer">
                            {if isset($linkSEOHersteller)}
                                <a href="{$linkSEOHersteller->cSeo}">{$linkSEOHersteller->cName}</a>
                            {else}
                                <span>{lang key="manufacturers" section="global"}</span>
                            {/if}
                        </div>
						<div class="row row-eq-height row-eq-img-height hasInfoColumn subcat-list">
							{foreach name=hersteller from=$manufacturers item=hst}
								<div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 category-wrapper manufacturer top15{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}">
										{if isset($Einstellungen.template.megamenu.show_category_images) && $Einstellungen.template.megamenu.show_category_images !== 'N'}
									
												<a class="img text-center preload block hidden-xs" href="{$hst->cSeo}"><span class="image-content"><img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$hst->cBildpfadNormal}" class=image alt="{$hst->cName|escape:'html'}"></span></a>
										{/if}
											<a class="title h5 caption{if isset($Einstellungen.template.megamenu.show_category_images) && $Einstellungen.template.megamenu.show_category_images !== 'N'} text-center{/if}" href="{$hst->cSeo}"><span>{$hst->cName}</span></a>
								</div>
							{/foreach}
						</div>{* /row *}
                </li>
            </ul>
        </li>
    {/if}
{/if}
{/block}{* megamenu-manufacturers *}


{block name="megamenu-global-characteristics"}
{*
{if isset($Einstellungen.template.megamenu.show_global_characteristics) && $Einstellungen.template.megamenu.show_global_characteristics !== 'N'}
    {get_global_characteristics assign='characteristics'}
    {if !empty($characteristics)}

    {/if}
{/if}
*}
{/block}{* megamenu-global-characteristics *}
{/strip}
