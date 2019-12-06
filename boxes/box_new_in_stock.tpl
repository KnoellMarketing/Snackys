{if isset($oBox->Artikel->elemente)}
    {lang key="newProducts" section="global" assign='slidertitle'}
    
    {assign var='moreLink' value=null}
    {assign var='moreTitle' value=null}
    {if isset($oBox->cURL)}
        {assign var='moreLink' value=$oBox->cURL}
        {lang key='showAllNewProducts' section='global' assign='moreTitle'}
    {/if}
    
    {include file='snippets/product_slider.tpl' id='boxslider-newproducts' productlist=$oBox->Artikel->elemente title=$slidertitle tplscope='box' moreLink=$moreLink moreTitle=$moreTitle isBox="1"}
    {*
    <a href="{$Boxen.NeuImSortiment->cURL}" class="artikelnamelink">{lang key="showAllNewProducts" section="global"}</a>
    *}
{elseif isset($Boxen.NeuImSortiment)}
    {lang key="newProducts" section="global" assign='slidertitle'}
    {include file='snippets/product_slider.tpl' id='boxslider-newproducts' productlist=$Boxen.NeuImSortiment->Artikel->elemente title=$slidertitle tplscope='box' isBox="1"}
    {*
    <a href="{$Boxen.NeuImSortiment->cURL}" class="artikelnamelink">{lang key="showAllNewProducts" section="global"}</a>
    *}
{/if}