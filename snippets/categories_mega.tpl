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
    {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu_start' dropdownSupport=true tplscope='megamenu_start'}
{/if}

{block name="megamenu-categories"}
{if isset($snackyConfig.show_categories) && $snackyConfig.show_categories !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {assign var='show_subcategories' value=false}
    {if isset($snackyConfig.show_subcategories) && $snackyConfig.show_subcategories !== 'N'}
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
            <li class="{if $isDropdown}mgm-fw{/if}{if $category->kKategorie == $activeId || (isset($activeParents[0]) && $activeParents[0]->kKategorie == $category->kKategorie)} active{/if}">
                <a href="{$category->cURL}" class="mm-mainlink">
                    {$category->cKurzbezeichnung}
                    {if $isDropdown}<span class="caret hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}{/if}
                </a>
                {if $isDropdown}
                    <ul class="dropdown-menu keepopen">
                        <li class="mgm-c">
                                <div class="row dpflex-a-start">
                                    {assign var=hasInfoColumn value=false}
                                    {if isset($snackyConfig.show_maincategory_info) && $snackyConfig.show_maincategory_info !== 'N' && ($category->cBildURL !== 'gfx/keinBild.gif' || !empty($category->cBeschreibung))}
                                        {assign var=hasInfoColumn value=true}
                                        <div class="col-md-4 col-lg-3 hidden-xs hidden-sm info-col">
											{if $category->cBildURL !== 'gfx/keinBild.gif' && isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N' && !$device->isMobile()}
												<a href="{$category->cURL}" class="block">
													<span class="img-ct">
														<img src="{$snackyConfig.preloadImage}" data-src="{$category->cBildURL}" class="img-responsive"
														 alt="{$category->cKurzbezeichnung|escape:'html'}">
													</span>
												</a>
											{/if}
											<div class="description">
												<a class="h4 block m0" href="{$category->cURL}">
													{$category->cName}
												</a>
												<p>
													{$category->cBeschreibung}
												</p>
											</div>
                                        </div>
                                    {/if}
                                    <div class="col-xs-12 col-sm-12{if $hasInfoColumn} col-md-8 col-lg-9{/if} mega-categories{if $hasInfoColumn} hasInfoColumn{/if} row row-multi">
                                            {if $category->bUnterKategorien}
                                                {if !empty($category->Unterkategorien)}
                                                    {assign var=sub_categories value=$category->Unterkategorien}
                                                {else}
                                                    {get_category_array categoryId=$category->kKategorie assign='sub_categories'}
                                                {/if}
                                                {foreach name='sub_categories' from=$sub_categories item='sub'}
                                                    <div class="col-xs-12 col-sm-3 col-lg-3{if $sub->kKategorie == $activeId || (isset($activeParents[1]) && $activeParents[1]->kKategorie == $sub->kKategorie)} active{/if}">
                                                            {if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N' && !$device->isMobile()}
                                                                
															<a href="{$sub->cURL}" class="hidden-xs block">
																<span class="img-ct">
																<img src="{$snackyConfig.preloadImage}" data-src="{$sub->cBildURL}" class="image"
																	 alt="{$category->cKurzbezeichnung|escape:'html'}">
																</span>
															</a>
                                                            {/if}
															{if !empty($sub->Unterkategorien)}
																{assign var=subsub_categories value=$sub->Unterkategorien}
															{else}
																{get_category_array categoryId=$sub->kKategorie assign='subsub_categories'}
															{/if}
															<a class="defaultlink h6 title block" href="{$sub->cURL}">
																{$sub->cKurzbezeichnung}
																{if $show_subcategories && $sub->bUnterKategorien && count($subsub_categories)  > 0}
																{include file='snippets/mobile-menu-arrow.tpl'}
																{/if}
															</a>
                                                            {if $show_subcategories && $sub->bUnterKategorien}
																{if count($subsub_categories)  > 0} 
                                                                <ul class="blanklist small subsub">
                                                                    {foreach name='subsub_categories' from=$subsub_categories item='subsub'}
                                                                        {if $smarty.foreach.subsub_categories.iteration <= $max_subsub_items}
                                                                            <li{if $subsub->kKategorie == $activeId || (isset($activeParents[2]) && $activeParents[2]->kKategorie == $subsub->kKategorie)} class="active"{/if}>
                                                                                <a href="{$subsub->cURL}" class="defaultlink">
                                                                                    {$subsub->cKurzbezeichnung}
                                                                                </a>
                                                                            </li>
                                                                        {else}
                                                                            <li class="more"><a href="{$sub->cURL}">{lang key="more" section="global"} <span class="remaining">({math equation='total - max' total=$subsub_categories|count max=$max_subsub_items})</span></a></li>
                                                                            {break}
                                                                        {/if}
                                                                    {/foreach}
                                                                </ul>
																{/if}
                                                            {/if}
                                                    </div>
                                                {/foreach}
                                            {/if}
                                        {* /row *}
                                    </div>{* /mega-categories *}
                                </div>{* /row *}
                            {* /mgm-c *}
                        </li>
                    </ul>
                {/if}
            </li>
        {/foreach}
    {/if}
{/if}
{/block}{* /megamenu-categories*}

{block name="megamenu-pages"}
{if isset($snackyConfig.show_pages) && $snackyConfig.show_pages !== 'N'}
    {include file='snippets/linkgroup_list.tpl' linkgroupIdentifier='megamenu' dropdownSupport=true tplscope='megamenu'}
{/if}
{/block}{* megamenu-pages *}

{block name="megamenu-manufacturers"}
{if isset($snackyConfig.show_manufacturers) && $snackyConfig.show_manufacturers !== 'N' && isset($Einstellungen.global.global_sichtbarkeit) && ($Einstellungen.global.global_sichtbarkeit != 3 || isset($smarty.session.Kunde->kKunde) && $smarty.session.Kunde->kKunde != 0)}
    {get_manufacturers assign='manufacturers'}
    {if !empty($manufacturers)}
        <li class="mgm-fw mm-manu{if (isset($NaviFilter->Hersteller) && !empty($NaviFilter->Hersteller->kHersteller)) || $nSeitenTyp == PAGE_HERSTELLER} active{/if}">
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
            <ul class="dropdown-menu keepopen">
                <li class="mgm-c">
					<div class="row row-multi">
						{foreach name=hersteller from=$manufacturers item=hst}
							<div class="col-xs-12 col-sm-3 col-lg-3{if isset($NaviFilter->Hersteller) && $NaviFilter->Hersteller->kHersteller == $hst->kHersteller} active{/if}">
								{if isset($snackyConfig.show_category_images) && $snackyConfig.show_category_images !== 'N' && !$device->isMobile()}
									<a class="block hidden-xs img-w" href="{$hst->cSeo}">
										<span class="img-ct">
											<img src="{$snackyConfig.preloadImage}" data-src="{$hst->cBildpfadNormal}" class=image alt="{$hst->cName|escape:'html'}">
										</span>
									</a>
								{/if}
								<a class="defaultlink h6 title block" href="{$hst->cSeo}">
									<span>{$hst->cName}</span>
								</a>
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
{if isset($snackyConfig.show_global_characteristics) && $snackyConfig.show_global_characteristics !== 'N'}
    {get_global_characteristics assign='characteristics'}
    {if !empty($characteristics)}

    {/if}
{/if}
*}
{/block}{* megamenu-global-characteristics *}

{/strip}
