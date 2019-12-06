{checkShowMatrix kundengruppen=$snackyConfig.matrix_kundengruppe}
{block name="header"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/header.tpl'}
    {else}
        {if isset($smarty.get.quickView) && $smarty.get.quickView == 1}
            {include file='layout/modal_header.tpl'}
        {/if}
    {/if}
{/block}

{block name="content"}
    {if isset($bAjaxRequest) && $bAjaxRequest && isset($listStyle) && ($listStyle === 'list' || $listStyle === 'gallery')}
        {if $listStyle === 'list'}
            {assign var="tplscope" value="list"}
            {include file='productlist/item_list.tpl'}
        {/if}
        {if $listStyle === 'gallery'}
            {assign var="tplscope" value="gallery"}
            {assign var="class" value="thumbnail"}
            {include file='productlist/item_box.tpl'}
        {/if}
    {else}
        <div id="result-wrapper" itemprop="mainEntity" itemscope  itemtype="http://schema.org/Product" itemid="{$ShopURL}/{$Artikel->cSeo}" variations-type="{if $varKombiArr|@count > 0}varkombi{else if $Artikel->Variationen}simple{else}none{/if}">
            <meta itemprop="url" content="{$ShopURL}/{$Artikel->cSeo}">
        {include file="snippets/extension.tpl"}
        {if isset($Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELDETAILS_TPL]) && $currentTemplateDirFullPath|cat:'productdetails/'|cat:$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELDETAILS_TPL]|file_exists}
            {include file='productdetails/'|cat:$Artikel->FunktionsAttribute[$FKT_ATTRIBUT_ARTIKELDETAILS_TPL]}
        {else}
            {include file='productdetails/details.tpl'}
        {/if}
        </div>
    {/if}
{/block}

{block name="footer"}
    {if !isset($bAjaxRequest) || !$bAjaxRequest}
        {include file='layout/footer.tpl'}
    {else}
        {if isset($smarty.get.quickView) && $smarty.get.quickView == 1}
            {include file='layout/modal_footer.tpl'}
        {/if}
    {/if}
{/block}