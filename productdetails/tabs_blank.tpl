{$tabanzeige = $Einstellungen.artikeldetails.artikeldetails_tabs_nutzen !== 'N'}
{$useDescription = ($Artikel->cBeschreibung|strlen > 0 || $Einstellungen.artikeldetails.merkmale_anzeigen === 'Y'
    && $Artikel->oMerkmale_arr|count > 1)}
{$useDownloads = (isset($Artikel->oDownload_arr) && $Artikel->oDownload_arr|@count > 0)}
{$useMediaFiles = ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YA'
    && $Artikel->cMedienDateiAnzeige !== 'tab') || $Artikel->cMedienDateiAnzeige === 'beschreibung')
    && !empty($Artikel->cMedienTyp_arr))}
{$useVotes = $Einstellungen.bewertung.bewertung_anzeigen === 'Y'}
{$useQuestionOnItem = $Einstellungen.artikeldetails.artikeldetails_fragezumprodukt_anzeigen === 'Y'}
{$usePriceFlow = ($Einstellungen.preisverlauf.preisverlauf_anzeigen === 'Y' && $bPreisverlauf)}
{$useAvailabilityNotification = ($verfuegbarkeitsBenachrichtigung == 1 && $Artikel->cLagerBeachten === 'Y')}
{$useMediaGroup = ((($Einstellungen.artikeldetails.mediendatei_anzeigen === 'YM'
    && $Artikel->cMedienDateiAnzeige !== 'beschreibung') || $Artikel->cMedienDateiAnzeige === 'tab')
    && !empty($Artikel->cMedienTyp_arr))}
{$useTags = ($Einstellungen.artikeldetails.tagging_anzeigen === 'Y' && (count($ProduktTagging) > 0
    || $Einstellungen.artikeldetails.tagging_freischaltung !== 'N'))}
{$hasVotesHash = isset($smarty.get.ratings_nPage) && count($smarty.get.ratings_nPage) > 0
    || isset($smarty.get.bewertung_anzeigen) && count($smarty.get.bewertung_anzeigen) > 0
    || isset($smarty.get.ratings_nItemsPerPage) && count($smarty.get.ratings_nItemsPerPage) > 0
    || isset($smarty.get.ratings_nSortByDir) && count($smarty.get.ratings_nSortByDir) > 0
    || isset($smarty.get.btgsterne) && count($smarty.get.btgsterne) > 0}
{section name=iterator start=1 loop=10}
    {$tab = tab}
    {$tabname = $tab|cat:$smarty.section.iterator.index|cat:" name"}
    {$tabinhalt = $tab|cat:$smarty.section.iterator.index|cat:" inhalt"}
    {if isset($Artikel->AttributeAssoc[$tabname]) && $Artikel->AttributeAssoc[$tabname]
        && $Artikel->AttributeAssoc[$tabinhalt]}
        {$separatedTabs[{$tabname|replace:' ':'-'}] = [
        'id'      => {$tabname|replace:' ':'-'},
        'name'   => {$Artikel->AttributeAssoc[$tabname]},
        'content' => {$Artikel->AttributeAssoc[$tabinhalt]}
        ]}
    {/if}
{/section}
{$setActiveClass = [
    'description'    => (!$hasVotesHash),
    'downloads'      => (!$hasVotesHash && !$useDescription),
    'separatedTabs'  => (!$hasVotesHash && !$useDescription && !$useDownloads),
    'votes'          => ($hasVotesHash || !$useDescription && !$useDownloads && empty($separatedTabs)),
    'questionOnItem' => (!$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs) && !$useVotes),
    'priceFlow'      => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs)
        && !$useQuestionOnItem),
    'availabilityNotification' => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads
        && empty($separatedTabs) && !$useQuestionOnItem && !$usePriceFlow),
    'mediaGroup' => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs)
        && !$useQuestionOnItem && !$usePriceFlow && !$useAvailabilityNotification),
    'tags' => (!$useVotes && !$hasVotesHash && !$useDescription && !$useDownloads && empty($separatedTabs)
        && !$useQuestionOnItem && !$usePriceFlow && !$useAvailabilityNotification && !$useMediaGroup)
]}

{if useDescription || $useDownloads || $useMediaFiles || $useVotes || $useQuestionOnItem || $usePriceFlow
    || $useAvailabilityNotification || $useMediaGroup || $useTags || !empty($separatedTabs)}
    <div class="tab-content row" id="article-tabs">
        <div class="{if $useDownloads || $useMediaFiles || $usePriceFlow || $useMediaGroup || $useTags || $useAvailabilityNotification || (isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0)}col-xs-12 col-md-6 col-lg-7{else}col-xs-12{/if}">
        {if $useDescription}
        <div class="panel panel-default open-show" id="tab-description">
            <div class="panel-heading">
                <h3 class="panel-title">
                    {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                </h3>
            </div>
            <div class="panel-body">
            <div class="tab-content-wrapper">
                {block name="tab-description-content"}
                    <div class="desc">
                        {if $Einstellungen.template.general.optimize_artikel == "Y"}{$Artikel->cBeschreibung|optimize}{else}{$Artikel->cBeschreibung}{/if}
                        {if $useMediaFiles && !empty($Artikel->cMedienTyp_arr)}
                            {foreach name="mediendateigruppen" from=$Artikel->cMedienTyp_arr item=cMedienTyp}
                                <div class="media">
                                    {include file='productdetails/mediafile.tpl'}
                                </div>
                            {/foreach}
                        {/if}
                    </div>
                {/block}
                {block name="tab-description-attributes"}
                    {include file="productdetails/attributes.tpl" tplscope="details"}
                {/block}
            </div>
            </div>
        </div>
        {/if}
        {if !empty($separatedTabs)}
            {foreach from=$separatedTabs item=separatedTab name=separatedTabsBody}
            <div class="panel panel-default" id="tab-{$separatedTab.id}">
                <div class="panel-heading">
                    <h3 class="panel-title">{$separatedTab.name}</h3>
                </div>
                <div class="panel-body">
                {$separatedTab.content}
                </div>
            </div>
            {/foreach}
        {/if}
        {if $useVotes}
        <div class="panel panel-default" id="tab-votes">
            <div class="panel-heading">
                <h3 class="panel-title">{lang key="Votes" section="global"}</h3>
            </div>
            <div class="panel-body">
            {include file="productdetails/reviews.tpl" stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
            </div>
        </div>
        {/if}
        {if $useQuestionOnItem}
        <div class="panel panel-default" id="tab-questionOnItem">
            <div class="panel-heading">
                <h3 class="panel-title">{lang key="productQuestion" section="productDetails"}</h3>
            </div>
            <div class="panel-body">
            {include file="productdetails/question_on_item.tpl" position="tab"}
            </div>
        </div>
        {/if}
        </div>
        {if $useDownloads || $useMediaFiles || $usePriceFlow || $useMediaGroup || $useTags || $useAvailabilityNotification || (isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0)}
        <div class="col-xs-12 col-md-5 col-md-push-1 col-lg-4 col-lg-push-1">        
            {if $useAvailabilityNotification}
            <div class="panel panel-default" id="tab-availabilityNotification">
                <div class="panel-heading">
                    <h3 class="panel-title">{lang key="notifyMeWhenProductAvailableAgain" section="global"}</h3>
                </div>
                <div class="panel-body">
                {include file="productdetails/availability_notification_form.tpl" position="tab" tplscope="artikeldetails"}
                </div>
            </div>
            {/if}
            {if $useDownloads}
            <div class="panel panel-default" id="tab-downloads">
                <div class="panel-heading">
                    <h3 class="panel-title">{lang section="productDownloads" key="downloadSection"}</h3>
                </div>
                <div class="panel-body">
                {include file="productdetails/download.tpl"}
                </div>
            </div>
            {/if}
            {* Coming Soon – if $usePriceFlow} 
            <div class="panel panel-default" id="tab-priceFlow">
                <div class="panel-heading">
                    <h3 class="panel-title">{lang key="priceFlow" section="productDetails"}</h3>
                </div>
                <div class="panel-body">
                {include file="productdetails/price_history.tpl"}
                </div>
            </div>
            {/if *}
            {if $useMediaGroup}
                {foreach name="mediendateigruppen" from=$Artikel->cMedienTyp_arr item=cMedienTyp}
                    {$cMedienTypId = $cMedienTyp|@seofy}
                <div class="panel panel-default" id="tab-{$cMedienTypId}">
                    <div class="panel-heading">
                        <h3 class="panel-title">{$cMedienTyp}</h3>
                    </div>
                    <div class="panel-body">
                    {include file="productdetails/mediafile.tpl"}
                    </div>
                </div>
                {/foreach}
            {/if}
            {if $useTags}
            <div class="panel panel-default" id="tab-tags">
                <div class="panel-heading">
                    <h3 class="panel-title">{lang key="productTags" section="productDetails"}</h3>
                </div>
                <div class="panel-body">
                {include file="productdetails/tags.tpl"}
                </div>
            </div>
            {/if}
            {if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                {lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
                {include file='snippets/product_related.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
            {/if}
        </div>
        {/if}
    </div>
{/if}