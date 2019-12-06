{if isset($oBox->Artikel) && $oBox->Artikel|@count > 0}
    {assign var=recentlyViewedArticles value=$oBox->Artikel}
{elseif isset($Boxen.ZuletztAngesehen->Artikel) && $Boxen.ZuletztAngesehen->Artikel|@count > 0}
    {assign var=recentlyViewedArticles value=$Boxen.ZuletztAngesehen->Artikel}
{/if}
{if isset($recentlyViewedArticles)}
    {lang key="lastViewed" section="global" assign='slidertitle'}
    {include file='snippets/product_slider.tpl' id='boxslider-recently-viewed' productlist=$recentlyViewedArticles title=$slidertitle tplscope='box' hideOverlays=true isBox="1"}
{/if}