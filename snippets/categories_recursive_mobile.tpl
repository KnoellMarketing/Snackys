{if (!empty($categories) ||isset($categoryId)) && (!isset($i) || isset($i) && isset($limit) && $i < $limit)}
    {strip}
        {if !isset($i)}
            {assign var='i' value=0}
        {/if}
		{assign var='limit' value=$snackyConfig.mmenu_subcats+1}
        {if !isset($caret)}
            {assign var='caret' value='down'}
        {/if}
        {if !isset($activeId)}
            {assign var='activeId' value='0'}
            {if isset($NaviFilter->Kategorie) && intval($NaviFilter->Kategorie->kKategorie) > 0}
                {assign var='activeId' value=$NaviFilter->Kategorie->kKategorie}
            {elseif $nSeitenTyp == 1 && isset($Artikel)}
                {assign var='activeId' value=$Artikel->gibKategorie()}
            {elseif $nSeitenTyp == 1 && isset($smarty.session.LetzteKategorie)}
                {assign var='activeId' value=$smarty.session.LetzteKategorie}
            {/if}
        {/if}
        {if !isset($activeParents) && ($nSeitenTyp == 1 || $nSeitenTyp == 2)}
            {get_category_parents categoryId=$activeId assign='activeParents'}
        {/if}
        {if !isset($activeParents)}
            {assign var="activeParents" value=null}
        {/if}
        {if empty($categories)}
            {if !isset($categoryBoxNumber)}
                {assign var='categoryBoxNumber' value=null}
            {/if}
            {get_category_array categoryId=$categoryId categoryBoxNumber=$categoryBoxNumber assign='categories'}
        {/if}
        {if !empty($categories)}
            {foreach name='categories' from=$categories item='category'}
                {assign var='hasItems' value=false}
                {if isset($category->bUnterKategorien) && $category->bUnterKategorien && (($i+1) < $limit)}
                    {assign var='hasItems' value=true}
                {/if}
                {if isset($activeParents) && is_array($activeParents) && isset($activeParents[$i])}
                    {assign var='activeParent' value=$activeParents[$i]}
                {/if}
                <li class="{if $hasItems}mgm-fw dropdown-style{/if}{if $category->kKategorie == $activeId || ((isset($activeParent) && isset($activeParent->kKategorie)) && $activeParent->kKategorie == $category->kKategorie)} active{/if}{if is_array($category->KategorieAttribute) && !empty($category->KategorieAttribute["css_klasse"])} {$category->KategorieAttribute["css_klasse"]}{/if}">
                    <a href="{$category->cURL}" class="mm-mainlink" data-ref="{$category->kKategorie}" title="{$category->cKurzbezeichnung}">
                        {$category->cKurzbezeichnung}
                        {if $hasItems}
							<span class="ar ar-r hidden-xs"></span>{include file='snippets/mobile-menu-arrow.tpl'}
						{/if}
                    </a>
                    {if $hasItems}
                        <ul class="dropdown-menu keepopen">
							{if $snackyConfig.mmenu_link_clickable == 'N'}
							<li class="title{if $category->kKategorie == $activeId} active{/if}">
								<a href="{$category->cURL}" class="mm-mainlink" data-ref="{$category->kKategorie}" title="{$category->cKurzbezeichnung}">
									{lang key="showAll" section="global"}
								</a>
							</li>
							{/if}
                            {if !empty($category->Unterkategorien)}
                                {include file='snippets/categories_recursive_mobile.tpl' i=$i+1 categories=$category->Unterkategorien limit=$limit activeId=$activeId activeParents=$activeParents}
                            {else}
                                {include file='snippets/categories_recursive_mobile.tpl' i=$i+1 categoryId=$category->kKategorie limit=$limit categories=null activeId=$activeId activeParents=$activeParents}
                            {/if}
                        </ul>
                    {/if}
                </li>
            {/foreach}
        {/if}
    {/strip}
{/if}