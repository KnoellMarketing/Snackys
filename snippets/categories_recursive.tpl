{if (!empty($categories) ||isset($categoryId)) && (!isset($i) || isset($i) && isset($limit) && $i < $limit)}
    {strip}
        {if !isset($i)}
            {assign var='i' value=0}
        {/if}
        {if !isset($limit)}
            {assign var='limit' value=3}
        {/if}
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
                <li class="{if $category->kKategorie == $activeId || ((isset($activeParent) && isset($activeParent->kKategorie)) && $activeParent->kKategorie == $category->kKategorie)} active open{/if}{if is_array($category->KategorieAttribute) && !empty($category->KategorieAttribute["css_klasse"])} {$category->KategorieAttribute["css_klasse"]}{/if}">
                    <a href="{$category->cURL}"{if $hasItems} class="nav-sub"{/if} data-ref="{$category->kKategorie}">
                        {$category->cKurzbezeichnung}
                        {if $hasItems}<i class="fa fa-caret-{$caret} nav-toggle"></i>{/if}
                    </a>
                    {if $hasItems}
                        <ul class="nav">
                            {if !empty($category->Unterkategorien)}
                                {include file='snippets/categories_recursive.tpl' i=$i+1 categories=$category->Unterkategorien limit=$limit activeId=$activeId activeParents=$activeParents}
                            {else}
                                {include file='snippets/categories_recursive.tpl' i=$i+1 categoryId=$category->kKategorie limit=$limit categories=null activeId=$activeId activeParents=$activeParents}
                            {/if}
                        </ul>
                    {/if}
                </li>
            {/foreach}
        {/if}
    {/strip}
{/if}