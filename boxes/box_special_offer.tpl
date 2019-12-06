{if isset($oBox->Artikel->elemente) && $oBox->Artikel->elemente|@count > 0}
    {assign var=specialOfferArticles value=$oBox->Artikel->elemente}

    {assign var='moreLink' value=null}
    {assign var='moreTitle' value=null}
    {if isset($oBox->cURL)}
        {assign var='moreLink' value=$oBox->cURL}
        {lang key='showAllSpecialOffers' section='global' assign='moreTitle'}
    {/if}
{elseif isset($Boxen.Sonderangebote->Artikel->elemente) && $Boxen.Sonderangebote->Artikel->elemente|@count > 0}
    {assign var=specialOfferArticles value=$Boxen.Sonderangebote->Artikel->elemente}
{/if}

{if isset($specialOfferArticles)}
    {if $specialOfferArticles|@count>1}
        {lang key="specialOffers" section="global" assign='slidertitle'}
    {else}
        {lang key="specialOffer" section="global" assign='slidertitle'}
    {/if}
    {include file='snippets/product_slider.tpl' id='boxslider-topoffer' productlist=$specialOfferArticles title=$slidertitle tplscope='box' moreLink=$moreLink moreTitle=$moreTitle isBox="1"}
{/if}