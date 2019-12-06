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

{if $useDescription || $useDownloads || $useMediaFiles || $useVotes || $useQuestionOnItem || $usePriceFlow
    || $useAvailabilityNotification || $useMediaGroup || $useTags || !empty($separatedTabs)}
    {if $tabanzeige}
        <ul class="nav nav-tabs bottom15" role="tablist" id="article-tab-nav">
            {if $useDescription}
                <li role="presentation" {if $setActiveClass.description} class="active"{/if}>
                    <span aria-controls="tab-description" role="tab" data-toggle="tab">
                        {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                    </span>
                </li>
            {/if}
            {if $useDownloads}
                <li role="presentation" {if $setActiveClass.downloads} class="active"{/if}>
                    <span aria-controls="tab-downloads" role="tab" data-toggle="tab">
                        {lang section="productDownloads" key="downloadSection"}
                    </span>
                </li>
            {/if}
            {if !empty($separatedTabs)}
                {foreach from=$separatedTabs item=separatedTab name="separatedTabsHeader"}
                    <li role="presentation"
                        {if $setActiveClass.separatedTabs && $smarty.foreach.separatedTabsHeader.first}
                            class="active"
                        {/if}>
                        <span aria-controls="tab-{$separatedTab.id}" role="tab" data-toggle="tab">
                            {$separatedTab.name}
                        </span>
                    </li>
                {/foreach}
            {/if}
            {if $useVotes}
                <li role="presentation" {if $setActiveClass.votes} class="active"{/if}>
                    <span aria-controls="tab-votes" role="tab" data-toggle="tab">
                        {lang key="Votes" section="global"}
                    </span>
                </li>
            {/if}
            {if $useQuestionOnItem}
                <li role="presentation" {if $setActiveClass.questionOnItem} class="active" {/if}>
                    <span aria-controls="tab-questionOnItem" role="tab" data-toggle="tab">
                        {lang key="productQuestion" section="productDetails"}
                    </span>
                </li>
            {/if}
            {if $usePriceFlow}
                <li role="presentation" {if $setActiveClass.priceFlow} class="active"{/if}>
                    <span aria-controls="tab-priceFlow" role="tab" data-toggle="tab">
                        {lang key="priceFlow" section="productDetails"}
                    </span>
                </li>
            {/if}
            {if $useAvailabilityNotification}
                <li role="presentation"
                    {if $setActiveClass.availabilityNotification} class="active"{/if}>
                    <span aria-controls="tab-availabilityNotification" role="tab" data-toggle="tab">
                        {lang key="notifyMeWhenProductAvailableAgain" section="global"}
                    </span>
                </li>
            {/if}
            {if $useMediaGroup}
                {foreach name="mediendateigruppen" from=$Artikel->cMedienTyp_arr item=cMedienTyp}
                    {$cMedienTypId = $cMedienTyp|@seofy}
                    <li role="presentation"
                        {if $setActiveClass.mediaGroup && $smarty.foreach.mediendateigruppen.first} class="active"{/if}>
                        <span aria-controls="tab-{$cMedienTypId}" role="tab" data-toggle="tab">
                            {$cMedienTyp}
                        </span>
                    </li>
                {/foreach}
            {/if}
            {if $useTags}
                <li role="presentation" {if $setActiveClass.tags} class="active"{/if}>
                    <span aria-controls="tab-tags" role="tab" data-toggle="tab">
                        {lang key="productTags" section="productDetails"}
                    </span>
                </li>
            {/if}
		
			{if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                <li role="presentation" {if $setActiveClass.tags} class="active"{/if}>
                    <span aria-controls="p-slider-related" role="tab" data-toggle="tab">
						{lang key='RelatedProducts' section='productDetails'}
                    </span>
                </li>

			{/if}	
			
			
			
			<!-- DUPLICATE! -->
			{*
            {if $useDescription}
                <li role="presentation" {if $setActiveClass.description} class="active"{/if}>
                    <span aria-controls="tab-description" role="tab" data-toggle="tab">
                        {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                    </span>
                </li>
            {/if}
            {if $useDownloads}
                <li role="presentation" {if $setActiveClass.downloads} class="active"{/if}>
                    <span aria-controls="tab-downloads" role="tab" data-toggle="tab">
                        {lang section="productDownloads" key="downloadSection"}
                    </span>
                </li>
            {/if}
            {if !empty($separatedTabs)}
                {foreach from=$separatedTabs item=separatedTab name="separatedTabsHeader"}
                    <li role="presentation"
                        {if $setActiveClass.separatedTabs && $smarty.foreach.separatedTabsHeader.first}
                            class="active"
                        {/if}>
                        <span aria-controls="tab-{$separatedTab.id}" role="tab" data-toggle="tab">
                            {$separatedTab.name}
                        </span>
                    </li>
                {/foreach}
            {/if}
            {if $useVotes}
                <li role="presentation" {if $setActiveClass.votes} class="active"{/if}>
                    <span aria-controls="tab-votes" role="tab" data-toggle="tab">
                        {lang key="Votes" section="global"}
                    </span>
                </li>
            {/if}
            {if $useQuestionOnItem}
                <li role="presentation" {if $setActiveClass.questionOnItem} class="active" {/if}>
                    <span aria-controls="tab-questionOnItem" role="tab" data-toggle="tab">
                        {lang key="productQuestion" section="productDetails"}
                    </span>
                </li>
            {/if}
            {if $usePriceFlow}
                <li role="presentation" {if $setActiveClass.priceFlow} class="active"{/if}>
                    <span aria-controls="tab-priceFlow" role="tab" data-toggle="tab">
                        {lang key="priceFlow" section="productDetails"}
                    </span>
                </li>
            {/if}
            {if $useAvailabilityNotification}
                <li role="presentation"
                    {if $setActiveClass.availabilityNotification} class="active"{/if}>
                    <span aria-controls="tab-availabilityNotification" role="tab" data-toggle="tab">
                        {lang key="notifyMeWhenProductAvailableAgain" section="global"}
                    </span>
                </li>
            {/if}
            {if $useMediaGroup}
                {foreach name="mediendateigruppen" from=$Artikel->cMedienTyp_arr item=cMedienTyp}
                    {$cMedienTypId = $cMedienTyp|@seofy}
                    <li role="presentation"
                        {if $setActiveClass.mediaGroup && $smarty.foreach.mediendateigruppen.first} class="active"{/if}>
                        <span aria-controls="tab-{$cMedienTypId}" role="tab" data-toggle="tab">
                            {$cMedienTyp}
                        </span>
                    </li>
                {/foreach}
            {/if}
            {if $useTags}
                <li role="presentation" {if $setActiveClass.tags} class="active"{/if}>
                    <span aria-controls="tab-tags" role="tab" data-toggle="tab">
                        {lang key="productTags" section="productDetails"}
                    </span>
                </li>
            {/if}
		
			{if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
                <li role="presentation" {if $setActiveClass.tags} class="active"{/if}>
                    <span aria-controls="p-slider-related" role="tab" data-toggle="tab">
						{lang key='RelatedProducts' section='productDetails'}
                    </span>
                </li>

			{/if}	
			*}
        </ul>
    {/if}
    <div class="tab-content" id="article-tabs">
        {if $useDescription}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.description} in active{/if}" id="tab-description">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">
                            {block name='tab-description-title'}{lang key='description' section='productDetails'}{/block}
                        </h3>
                    </div>
                    <div class="panel-body" id="tab-description">
            {/if}
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
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
        {if $useDownloads}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.downloads} in active{/if}"
                    id="tab-downloads">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{lang section="productDownloads" key="downloadSection"}</h3>
                    </div>
                    <div class="panel-body" id="tab-downloads">
            {/if}
            {include file="productdetails/download.tpl"}
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
        {if !empty($separatedTabs)}
            {foreach from=$separatedTabs item=separatedTab name=separatedTabsBody}
                {if $tabanzeige}
                    <div role="tabpanel" class="tab-pane fade
                        {if $setActiveClass.separatedTabs && $smarty.foreach.separatedTabsBody.first} in active{/if}"
                        id="tab-{$separatedTab.id}">
                {else}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">{$separatedTab.name}</h3>
                        </div>
                        <div class="panel-body" id="tab-{$separatedTab.id}">
                {/if}
                {$separatedTab.content}
                {if $tabanzeige}
                    </div>
                {else}
                        </div>
                    </div>
                {/if}
            {/foreach}
        {/if}
        {if $useVotes}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.votes} in active{/if}" id="tab-votes">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{lang section="productDownloads" key="downloadSection"}</h3>
                    </div>
                    <div class="panel-body" id="tab-votes">
            {/if}
            {include file="productdetails/reviews.tpl" stars=$Artikel->Bewertungen->oBewertungGesamt->fDurchschnitt}
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
        {if $useQuestionOnItem}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.questionOnItem} in active{/if}"
                    id="tab-questionOnItem">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{lang key="productQuestion" section="productDetails"}</h3>
                    </div>
                    <div class="panel-body" id="tab-questionOnItem">
            {/if}
            {include file="productdetails/question_on_item.tpl" position="tab"}
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
        {if $usePriceFlow}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.priceFlow} in active{/if}"
                    id="tab-priceFlow">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{lang key="priceFlow" section="productDetails"}</h3>
                    </div>
                    <div class="panel-body" id="tab-priceFlow">
            {/if}
            {include file="productdetails/price_history.tpl"}
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
        {if $useAvailabilityNotification}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.availabilityNotification} in active{/if}"
                    id="tab-availabilityNotification">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{lang key="notifyMeWhenProductAvailableAgain" section="global"}</h3>
                    </div>
                    <div class="panel-body" id="tab-availabilityNotification">
            {/if}
            {include file="productdetails/availability_notification_form.tpl" position="tab" tplscope="artikeldetails"}
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
        {if $useMediaGroup}
            {foreach name="mediendateigruppen" from=$Artikel->cMedienTyp_arr item=cMedienTyp}
                {$cMedienTypId = $cMedienTyp|@seofy}
                {if $tabanzeige}
                    <div role="tabpanel" class="tab-pane fade
                        {if $setActiveClass.mediaGroup && $smarty.foreach.mediendateigruppen.first} in active{/if}"
                        id="tab-{$cMedienTypId}">
                {else}
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">{$cMedienTyp}</h3>
                        </div>
                        <div class="panel-body" id="tab-{$cMedienTypId}">
                {/if}
                {include file="productdetails/mediafile.tpl"}
                {if $tabanzeige}
                    </div>
                {else}
                        </div>
                    </div>
                {/if}
            {/foreach}
        {/if}
        {if $useTags}
            {if $tabanzeige}
                <div role="tabpanel" class="tab-pane fade {if $setActiveClass.tags} in active{/if}" id="tab-tags">
            {else}
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">{lang key="productTags" section="productDetails"}</h3>
                    </div>
                    <div class="panel-body" id="tab-tags">
            {/if}
            {include file="productdetails/tags.tpl"}
            {if $tabanzeige}
                </div>
            {else}
                    </div>
                </div>
            {/if}
        {/if}
		
		{if isset($oAehnlicheArtikel_arr) && count($oAehnlicheArtikel_arr) > 0}
			<div role="tabpanel" class="tab-pane fade {if $setActiveClass.tags} in active{/if}" id="p-slider-related">
				{lang key='RelatedProducts' section='productDetails' assign='slidertitle'}
				{include file='snippets/product_slider.tpl' class='x-related' id='slider-related' productlist=$oAehnlicheArtikel_arr title=$slidertitle}
			</div>
		{/if}	
    </div>
{/if}