{if isset($oBox->Artikel->elemente)}
    {lang key="topOffer" section="global" assign='slidertitle'}
    
    {assign var='moreLink' value=null}
    {assign var='moreTitle' value=null}
    {if isset($oBox->cURL)}
        {assign var='moreLink' value=$oBox->cURL}
        {lang key='showAllTopOffers' section='global' assign='moreTitle'}
    {/if}
    {include file='snippets/product_slider.tpl' id='boxslider-topoffer' productlist=$oBox->Artikel->elemente title=$slidertitle tplscope='box' moreLink=$moreLink moreTitle=$moreTitle isBox="1"}
{elseif isset($Boxen.TopAngebot->Artikel->elemente)}
    {lang key="topOffer" section="global" assign='slidertitle'}
    {include file='snippets/product_slider.tpl' id='boxslider-topoffer' productlist=$Boxen.TopAngebot->Artikel->elemente title=$slidertitle tplscope='box' isBox="1"}
{/if}