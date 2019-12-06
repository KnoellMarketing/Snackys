{if isset($oBox->oArtikel_arr)}
    {lang key="topReviews" section="global" assign='slidertitle'}
    
    {assign var='moreLink' value=null}
    {assign var='moreTitle' value=null}
    {if isset($oBox->cURL)}
        {assign var='moreLink' value=$oBox->cURL}
        {lang key='topReviews' section='global' assign='moreTitle'}
    {/if}
    {include file='snippets/product_slider.tpl' id='boxslider-toprated' productlist=$oBox->oArtikel_arr title=$slidertitle tplscope='box' moreLink=$moreLink moreTitle=$moreTitle isBox="1"}
    {*<a href="{$Boxen.TopBewertet->cURL}">{lang key="topReviews" section="global"}</a>*}
{elseif isset($Boxen.TopBewertet->oArtikel_arr)}
    {lang key="topReviews" section="global" assign='slidertitle'}
    {include file='snippets/product_slider.tpl' id='boxslider-toprated' productlist=$Boxen.TopBewertet->oArtikel_arr title=$slidertitle tplscope='box' isBox="1"}
    {*<a href="{$Boxen.TopBewertet->cURL}">{lang key="topReviews" section="global"}</a>*}
{/if}