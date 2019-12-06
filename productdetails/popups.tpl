{**
 * @copyright (c) JTL-Software-GmbH
 * @license http://jtl-url.de/jtlshoplicense
 *}

{assign var=kArtikel value=$Artikel->kArtikel}
{if $Artikel->kArtikelVariKombi > 0}
    {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
{/if}
{* if $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
    <div id="popupz{$kArtikel}" class="hidden">
        {include file='productdetails/question_on_item.tpl' position="popup"}
    </div>
{/if *}

{* if ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y'}
    <div id="popupn{$kArtikel}" class="hidden">
        {include file='productdetails/availability_notification_form.tpl' position="popup" tplscope='artikeldetails'}
    </div>
{/if *} 

{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt}
    {if !isset($kArtikel)}
        {assign var=kArtikel value=$Artikel->kArtikel}
        {if $Artikel->kArtikelVariKombi > 0}
            {assign var=kArtikel value=$Artikel->kArtikelVariKombi}
        {/if}
    {/if}
    <div id="popupa{$kArtikel}" class="hidden">
        {include file='productdetails/pushed.tpl' oArtikel=$Artikel fAnzahl=$bWarenkorbAnzahl}
    </div>
{/if}

{if (isset($fehlendeAngaben_benachrichtigung) && count($fehlendeAngaben_benachrichtigung) > 0 && ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y') ||
	(isset($fehlendeAngaben_fragezumprodukt) && $fehlendeAngaben_fragezumprodukt|@count > 0 && $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P')}
<script type="text/javascript">
    $(function() {ldelim}
        {if isset($fehlendeAngaben_benachrichtigung) && count($fehlendeAngaben_benachrichtigung) > 0 && ($verfuegbarkeitsBenachrichtigung == 2 || $verfuegbarkeitsBenachrichtigung == 3) && $Artikel->cLagerBeachten === 'Y'}
            show_popup('n{$kArtikel}', '{lang key="requestNotification" section="global"}');
        {/if}

        {if isset($fehlendeAngaben_fragezumprodukt) && $fehlendeAngaben_fragezumprodukt|@count > 0 && $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'P'}
            show_popup('z{$kArtikel}', '{lang key="productQuestion" section="productDetails"}');
        {/if}
    {rdelim});

    function show_popup(item, title) {ldelim}
        var html = $('#popup' + item).html();
        if (typeof title === 'undefined' || title.length === 0) {ldelim}
            title = $(html).find('h3').text();
        {rdelim}
		eModal(title,html);
    {rdelim}
</script>
{/if}
