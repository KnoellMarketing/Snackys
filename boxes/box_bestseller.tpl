{if isset($oBox->Artikel->elemente) && $oBox->Artikel->elemente|@count > 0}
    {assign var=bestsellerArticles value=$oBox->Artikel->elemente}
    
    {assign var='moreLink' value=null}
    {assign var='moreTitle' value=null}
    {if isset($oBox->cURL)}
        {assign var='moreLink' value=$oBox->cURL}
        {lang key='showAllBestsellers' section='global' assign='moreTitle'}
    {/if}
{elseif isset($Boxen.Bestseller->Artikel->elemente) && $Boxen.Bestseller->Artikel->elemente|@count > 0}
    {assign var=bestsellerArticles value=$Boxen.Bestseller->Artikel->elemente}
{/if}

{if isset($bestsellerArticles)}
    {lang key="bestsellers" section="global" assign='slidertitle'}
    {include file='snippets/product_slider.tpl' id='boxslider-bestsellers' productlist=$bestsellerArticles title=$slidertitle tplscope='box' moreLink=$moreLink moreTitle=$moreTitle isBox="1"}
{/if}
{*
 <a href="{$Boxen.Bestseller->cURL}">{lang key="showAllBestsellers" section="global"}</a>
*}