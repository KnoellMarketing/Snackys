{lang key="basketAdded" section="messages" assign="pushed_msg"}
{if $nSeitenTyp != 1} {*if page == 1 no footer-popup*}
    {include file='productdetails/pushed_success.tpl' Artikel=$zuletztInWarenkorbGelegterArtikel hinweis=$pushed_msg}
{/if}
