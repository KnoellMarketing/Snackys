{block name="doctype"}<!DOCTYPE html>{/block}
<html {block name="html-attributes"}lang="{$meta_language}" itemscope {if $nSeitenTyp == URLART_ARTIKEL}itemtype="http://schema.org/ItemPage"
      {elseif $nSeitenTyp == URLART_KATEGORIE}itemtype="http://schema.org/CollectionPage"
      {else}itemtype="http://schema.org/WebPage"{/if}{/block} id="snackys-tpl">
{block name="head"}
<head>
    {block name="head-base"}
        <base href="{$ShopURL}/">
    {/block}
	{snackys_content id="html_head_start" title="html_head_start"}
	{if $snackyConfig.pwa == 'Y'}<link rel="manifest" href="manifest.json">{/if}
	{if !empty($snackyConfig.gtag)}<link rel="dns-prefetch preconnect" href="https://www.googletagmanager.com">{/if}
	
    {block name="head-resources-jquery"}
	
		{include file="layout/inc_remarketing.tpl"}
        <script src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/jquery-1.12.4.min.js"></script>
		{if $device->version("IE") || $device->version("Opera Mini") || $device->version("baidubrowser") || $device->version("baiduboxapp") || $device->version("MQQBrowser") || $device->version('Safari')<=12.1}
			<script type="text/javascript" data-inline=1>{readJs file="js/snackys/intersectionObserver.js"}</script>
		{/if}
		
		{if $device->version("IE")}<script data-inline="1">{readJs file="js/snackys/svg.min.js"}</script>{/if}
		
		{if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
			{if isset($cPluginJsHead_arr)}{foreach from=$cPluginJsHead_arr item="cJS"}<script src="{$cJS}?v={$nTemplateVersion}" type="text/javascript"></script>{/foreach}{/if}
			{foreach from=$cJS_arr item="cJS"}<script src="{$cJS}?v={$nTemplateVersion}" type="text/javascript"></script>{/foreach}
			{if isset($cPluginJsBody_arr)}{foreach from=$cPluginJsBody_arr item="cJS"}<script src="{$cJS}?v={$nTemplateVersion}" type="text/javascript" defer></script>{/foreach}{/if}
		{else}
			{if isset($cPluginJsHead_arr) && $cPluginJsHead_arr|@count > 0}
				<script src="asset/plugin_js_head,jtl3.js?v={$nTemplateVersion}" type="text/javascript" defer></script>
			{else}
				<script src="asset/jtl3.js?v={$nTemplateVersion}" type="text/javascript" defer></script>
			{/if}
			{if isset($cPluginJsBody_arr) && $cPluginJsBody_arr|@count > 0}<script src="asset/plugin_js_body?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
		{/if}

		{assign var="customJSPath" value=$currentTemplateDir|cat:'/js/custom.js'}
		{if file_exists($customJSPath)}
			<script src="{$customJSPath}?v={$nTemplateVersion}" type="text/javascript" defer></script>
		{/if}
    {/block}
	{if $snackyConfig.showTrusted == 0 && !empty($snackyConfig.trustedID)}<link rel="dns-prefetch" href="//widgets.trustedshops.com">{/if}
    {block name="head-meta"}
        <meta http-equiv="content-type" content="text/html; charset={$smarty.const.JTL_CHARSET}">
        <meta name="description" itemprop="description" content={block name="head-meta-description"}"{$meta_description|truncate:1000:"":true}{/block}">
        {* Keywords are deprecated! no use for search engines!
		<meta name="keywords" itemprop="keywords" content="{block name="head-meta-keywords"}{$meta_keywords|truncate:255:"":true}{/block}">
		*}
        <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=no">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="robots" content="{if $bNoIndex === true  || (isset($Link->cNoFollow) && $Link->cNoFollow === 'Y')}noindex{else}index, follow{/if}">

        <meta itemprop="image" content="{$ShopURL}/{$ShopLogoURL}" />
        <meta itemprop="url" content="{$cCanonicalURL}"/>
        <meta property="og:type" content="website" />
        <meta property="og:site_name" content="{$meta_title}" />
        <meta property="og:title" content="{$meta_title}" />
        <meta property="og:description" content="{$meta_description|truncate:1000:"":true}" />
        <meta property="og:image" content="{$ShopLogoURL}" />
        <meta property="og:url" content="{$cCanonicalURL}"/>
    {/block}

    <title itemprop="name">{block name="head-title"}{$meta_title}{/block}</title>

    {if !empty($cCanonicalURL)}
        <link rel="canonical" href="{$cCanonicalURL}">
    {/if}

    {block name="head-icons"}
        {if !empty($Einstellungen.template.theme.favicon)}
            {if file_exists("{$currentTemplateDir}{$Einstellungen.template.theme.favicon}")}
                <link type="image/x-icon" href="{$currentTemplateDir}{$Einstellungen.template.theme.favicon}"
                    rel="shortcut icon">
            {else}
                <link type="image/x-icon"
                    href="{$currentTemplateDir}themes/base/images/{$Einstellungen.template.theme.favicon}"
                        rel="shortcut icon">
            {/if}
        {else}
            <link type="image/x-icon" href="favicon-default.ico" rel="shortcut icon">
        {/if}
        {if $nSeitenTyp == 1 && isset($Artikel) && !empty($Artikel->Bilder)}
            <link rel="image_src" href="{$ShopURL}/{$Artikel->Bilder[0]->cPfadGross}">
            <meta property="og:image" content="{$ShopURL}/{$Artikel->Bilder[0]->cPfadGross}">
        {/if}
    {/block}

		{php}
		  Shop::Smarty()->assign("css3", array());
		{/php}
    {block name="head-resources"}
		{if $snackyConfig.fontawesome == 'Y'}
			<link rel="stylesheet" href="templates/snackys/themes/base/fontawesome.css?v={$nTemplateVersion}" type="text/css">
		{/if}
		{if $snackyConfig.full_bootstrap == 'Y'}
			<link rel="stylesheet" href="templates/snackys/themes/base/full_bootstrap.css?v={$nTemplateVersion}" type="text/css">
		{/if}
		
		{assign var='hasMobileSlider' value='false'}
		 {getSliderPerDevice cAssign="oSliderDevice"}
		{if $snackyConfig.fullscreenElement == 1 && $device->isMobile()}
			{if isset($oSliderDevice) && count($oSliderDevice->oSlide_arr) > 0}
				{assign var='hasMobileSlider' value='true'}
			{/if}
		{/if}
		 
		{if $snackyConfig.headerType == 1 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else if $snackyConfig.headerType == 2 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light-mmenu.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else if $snackyConfig.headerType == 3 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else if $snackyConfig.headerType == 4 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/megamenu-fullscreen.css'}
	
		{else if $snackyConfig.headerType == 4.5 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/megamenu-fullscreen.css'}
	
		{else if $snackyConfig.headerType == 5 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter-fullscreen.css'}
	
		{else if $snackyConfig.headerType == 5.5 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter-fullscreen.css'}
	
		{else if $snackyConfig.headerType == 6 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/megamenu-fullscreen.css'}
	
		{else if $snackyConfig.headerType == 7 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-ultrathin.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else}
			{append var='css3' value='/templates/snackys/themes/base/css/header_default.css'}
		{/if}
		{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 5 || $Einstellungen.template.theme.theme_default == 'darkmode' || ($device->isMobile() && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'false' && ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 5))}
			{append var='css3' value='/templates/snackys/themes/darkmode/css/header-darkmode.css'}
		{/if}
		{if $Einstellungen.template.theme.theme_default == 'darkmode'}
			{append var='css3' value='/templates/snackys/themes/darkmode/css/footer-darkmode.css'}
		{/if}
		{if $snackyConfig.designWidth == 1}
			{append var='css3' value='/templates/snackys/themes/base/css/boxed-layout.css'}
		{/if}
		{if $snackyConfig.headerUsps != 0}
			{append var='css3' value='/templates/snackys/themes/base/css/usps-header.css'}
		{/if}
		{if $snackyConfig.headerPromo != 0 && !isset($smarty.session.km_promo)}
			{append var='css3' value='/templates/snackys/themes/base/css/header-promo.css'}
		{/if}
        {if $snackyConfig.showTrusted == 0 && !empty($snackyConfig.trustedID)}
			{append var='css3' value='/templates/snackys/themes/base/css/trusted.css'}
        {/if}
		{if $snackyConfig.posTrusted == 0}
			{append var='css3' value='/templates/snackys/themes/base/css/trusted-left.css'}
        {else}
			{append var='css3' value='/templates/snackys/themes/base/css/trusted-right.css'}
		{/if}
		{if $snackyConfig.paymentWall != 0}
			{append var='css3' value='/templates/snackys/themes/base/css/payment-wall.css'}
		{/if}
		{if $device->isMobile()}
			{append var='css3' value='/templates/snackys/themes/base/css/mobile.css'}
		 {else}
			{append var='css3' value='/templates/snackys/themes/base/css/desktop.css'}
		{/if}
		 {if $device->version("IE") && $device->version("IE")|number_format:0 <= '9'}
			{append var='css3' value='/templates/snackys/themes/base/css/oldbrowser.css'}
		 {/if}
		  {if $snackyConfig.manSlider == 0}
			{append var='css3' value='/templates/snackys/themes/base/css/index/manuslider.css'}
		  {/if}
		  {if $snackyConfig.sidepanelEverywhere == 'Y'}
			{append var='css3' value='/templates/snackys/themes/base/css/sidepanel.css'}
		   {elseif $nSeitenTyp === 2}
			{append var='css3' value='/templates/snackys/themes/base/css/sidepanel.css'}
		  {/if}
		   {if !empty($oUploadSchema_arr) && $nSeitenTyp === 3}
			{append var='css3' value='/templates/snackys/themes/base/css/fileupload.css'}
		   {/if}
			{if isset($oImageMap)}
			{append var='css3' value='/templates/snackys/themes/base/css/elements/banner.css'}
			{/if}
		   {if $nSeitenTyp === 25}
			{append var='css3' value='/templates/snackys/themes/base/css/error404/404.css'}
		  {/if}
		   {getSliderPerDevice cAssign="oSliderDevice"}
			{if isset($oSliderDevice) && count($oSliderDevice->oSlide_arr) > 0}	
			{append var='css3' value='/templates/snackys/themes/base/css/elements/slider.css'}
		   {/if}
			{if $snackyConfig.headerTopbar == 0 && !$device->isMobile()}
			{append var='css3' value='/templates/snackys/themes/extended/css/layout/topbar.css'}
			{/if}
			{if $snackyConfig.hover_productlist === 'Y' && !$device->isMobile() && $nSeitenTyp == 2}
			{append var='css3' value='/templates/snackys/themes/base/css/listing/product-hover-jtl.css'}
			 {/if}
			{if $snackyConfig.listShowCart != 1}
			{append var='css3' value='/templates/snackys/themes/base/css/listing/product-hover-km.css'}
			 {/if}
			  {if !empty($oAuswahlAssistent->kAuswahlAssistentGruppe) || isset($AWA)}
				{append var='css3' value='/templates/snackys/themes/base/css/selectionwizard.css'}
			  {/if}
			   {if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern) && $nSeitenTyp == 1}
				{append var='css3' value='/templates/snackys/themes/base/css/prevnext.css'}
			   {/if}
				{if $nSeitenTyp == 1}
				{append var='css3' value='/templates/snackys/themes/base/css/details/configurator.css'}
				{/if}
				 {if $snackyConfig.filterPos == 1 && $nSeitenTyp == 2}
				{append var='css3' value='/templates/snackys/themes/base/css/filter-above.css'}
				 {/if}
				 
			{if $snackyConfig.useConsentManager == 'Y'}
			{append var='css3' value='/templates/snackys/themes/base/css/consent.css'}
			 {/if}
		{loadCSS css1=$cCSS_arr css2=$cPluginCss_arr css3=$css3 cPageType=$nSeitenTyp}
        {* RSS *}
        {if isset($Einstellungen.rss.rss_nutzen) && $Einstellungen.rss.rss_nutzen === 'Y'}
            <link rel="alternate" type="application/rss+xml" title="Newsfeed {$Einstellungen.global.global_shopname}" href="rss.xml">
        {/if}
        {* Languages *}
        {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
            {foreach item=oSprache from=$smarty.session.Sprachen}
                    <link rel="alternate" hreflang="{if $oSprache->cStandard === "Y"}x-default{else}{$oSprache->cISO639}{/if}" href="{if $nSeitenTyp === 18 && $oSprache->cStandard === "Y"}{$cCanonicalURL}{else}{$oSprache->cURLFull}{/if}">
            {/foreach}
        {/if}



    {/block}

    {if !empty($snackyConfig.backgroundcolor) && $snackyConfig.backgroundcolor|strlen > 1}
        <style>
            body { background-color: {$snackyConfig.backgroundcolor}!important; }
        </style>
    {/if}
	
	{* Trusted Shops without DOM manipulation! *}
	{if $snackyConfig.showTrusted == 0 && !empty($snackyConfig.trustedID)}
		<script data-inline="1">
			var _tsConfig = { 
				'yOffset': '0', /* offset from page bottom */
				'customElementId': '', /* required for variants custom and custom_reviews */
				'trustcardDirection': '', /* for custom variants: topRight, topLeft, bottomRight, bottomLeft */
				'customBadgeWidth': '', /* for custom variants: 40 - 90 (in pixels) */
				'customBadgeHeight': '', /* for custom variants: 40 - 90 (in pixels) */
				'disableResponsive': 'false', /* deactivate responsive behaviour */
				'disableTrustbadge': 'false', /* deactivate trustbadge */
				'variant': {if $snackyConfig.varTrusted == 0}'reviews'{else}'default',{/if}
			};
		</script>
		<script src="//widgets.trustedshops.com/js/{$snackyConfig.trustedID}.js" charset="utf-8" async data-inline="1"></script>
	{/if}
	
	<meta name="theme-color" content="{$snackyConfig.css_brand}">
	<link rel="apple-touch-icon" href="{if empty($snackyConfig.appleTouchIcon)}/templates/snackys/img/icons/apple-touch-icon.png{else}{$snackyConfig.appleTouchIcon}{/if}"/>
	{if !empty($snackyConfig.pwa_icon192) && $snackyConfig.pwa == 'Y'}<link rel="icon" sizes="192x192" href="{$snackyConfig.pwa_icon192}">{/if}
	{if !empty($snackyConfig.pwa_icon512) && $snackyConfig.pwa == 'Y'}<link rel="icon" sizes="512x512" href="{$snackyConfig.pwa_icon512}">{/if}

	{snackys_content id="html_head_end" title="html_head_end"}
</head>
{/block}

{assign var="isFluidContent" value=false}
{if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout === 'fluid' && isset($Link) && $Link->bIsFluid}
    {assign var="isFluidContent" value=true}
{/if}
{has_boxes position='left' assign='hasLeftPanel'}
{block name="body-tag"}
{strip}
<body data-headtype="{$snackyConfig.headerType}" data-page="{$nSeitenTyp}" class="
body-offcanvas{if isset($bSeiteNichtGefunden) && $bSeiteNichtGefunden} error404{/if}{if empty($snackyConfig.youtubeID) && $nSeitenTyp == 18} no-yt{/if}{if $snackyConfig.headerUsps != 0} usps-visible{/if}
{if $Einstellungen.template.theme.theme_default == darkmode} darkmode{/if}{if $snackyConfig.designWidth == 1} boxed-layout{/if}
{if $snackyConfig.boxedMargin == 1} boxed-nomargin{/if}{if $snackyConfig.boxedBorder == 1} boxed-noborder{/if}
{if $snackyConfig.fwSlider == 1 && $nSeitenTyp == 18} boxed-slider{/if}
{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5} full-head{/if}
{if $snackyConfig.productBorder == 1} product-border{/if}
{if $device->isMobile()} mobile{/if}
{if $device->isTablet()} tablet{/if}
{if $device->isiOS()} ios{/if}
{if $device->is("Edge")} edge
{elseif $device->version("IE")} ie ie-{$device->version("IE")|number_format:0}{/if}
{if !empty($hinweis)}{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt} basked-added sidebasket-open{/if}{/if}
{if $snackyConfig.sidepanelEverywhere == 'Y'} sidebar-overall{/if}
{if $device->isMobile() && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'false'} no-mb-sl{/if}
{if $snackyConfig.mmenu_link_clickable == 'N'} mmlca-n{/if}
"



{if isset($Link) && !empty($Link->cIdentifier)} id="{$Link->cIdentifier}"{/if}
{if !empty($snackyConfig.boxedImg) && $snackyConfig.designWidth == 1} style="background: url({$snackyConfig.boxedImg})no-repeat center center/cover;{if !$device->isMobile()} background-attachment: fixed{/if}"{/if}
>
{/strip}
	{snackys_content id="html_body_start" title="html_body_start"}
    {if $device->version("IE") && $device->version("IE")|number_format:0 <= '9'}
    <div id="outdatedbrowser" class="text-center">
        {if isset($ShopLogoURL)}
            {image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
        {else}
            <span class="h1">{$Einstellungen.global.global_shopname}</span>
        {/if}<br><br>
        <h1 class="h3">{lang key="oldBrowserHeadline" section="custom"}</h1>
        <p class="text-lg">{lang key="oldBrowserSubline" section="custom"}</p>
        <a href="http://outdatedbrowser.com/de" class="btn btn-primary" target="_blank">{lang key="oldBrowserButton" section="custom"}</a>
    </div>
    {/if}
{/block}
{block name="consent-manager"}
	{isBot cAssign="isBot"}
	{if $snackyConfig.useConsentManager == 'Y' && !$isBot}
		<div id="consentmanager" class="modal {if isset($smarty.cookies.consentState)}hidden{else}modal-dialog{/if}">
			<div class="modal-content" id="consentmanagerBasic">
				<div class="modal-header">
					<span class="modal-title block h5">{lang key="consentHeadline"}</span>
				</div>
				<div class="modal-body">
					<div id="consentIntro">
						{lang key="consentIntro"}
					</div>
					<div id="consentDetail" class="hidden">
						{lang key="consentDetailText"}
					</div>
					<input type="checkbox" class="consentNeeded" checked disabled> {lang key="consentNeeded"}
					<input type="checkbox" name="consentAccept" id="consentAccept" class="consentCheck" {if isset($smarty.cookies.consentState) && $smarty.cookies.consentState == 2} checked{/if}> <label for="consentAccept">{lang key="consentAnalytics"}</label><br>
					<button id="consentSave" name="consentSave" class="btn btn-default">{lang key="consentSave"}</button>
					<button id="consentAll" class="btn btn-primary">{lang key="consentAll"}</button>
					<p class="consentLinks">
						<a href="{lang key="consentPrivacyURL"}">{lang key="consentPrivacy"}</a> - 
						<a href="#" id="consentText">{lang key="consentDetail"}</a> - 
						<a href="{lang key="consentImprintURL"}">{lang key="consentImprint"}</a>
					</p>
				</div>
			</div>
		</div>
		<button id="consentPicker"{if !isset($smarty.cookies.consentState)} class="hidden"{/if}>
			<span class="img-ct icon icon-xl">
				<svg height='100px' width='100px'  fill="#000000" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" x="0px" y="0px" viewBox="0 0 24 24" style="enable-background:new 0 0 24 24;" xml:space="preserve"><g><g><path d="M7.21,1.954C8.588,1.321,10.2,1,12.001,1c1.789,0,3.401,0.321,4.793,0.955C16.861,1.986,16.932,2,17.001,2    c0.19,0,0.372-0.109,0.456-0.293c0.114-0.251,0.003-0.548-0.248-0.662C15.686,0.352,13.934,0,12.001,0    c-1.947,0-3.7,0.352-5.209,1.046C6.542,1.161,6.432,1.458,6.547,1.709C6.663,1.959,6.958,2.069,7.21,1.954z"></path><path d="M5.357,5.852C7.2,3.986,9.496,3,11.999,3c2.513,0,4.812,0.986,6.646,2.851C18.743,5.95,18.872,6,19.001,6    c0.126,0,0.253-0.048,0.351-0.144c0.197-0.194,0.2-0.51,0.006-0.707C17.331,3.089,14.786,2,11.999,2    C9.223,2,6.68,3.089,4.646,5.148C4.452,5.345,4.454,5.662,4.65,5.856C4.847,6.05,5.163,6.047,5.357,5.852z"></path><path d="M11.999,4c-0.713,0-1.421,0.088-2.105,0.262C9.626,4.33,9.464,4.602,9.532,4.87C9.6,5.138,9.874,5.298,10.14,5.231    C10.743,5.078,11.369,5,11.999,5c4.136,0,7.5,3.364,7.5,7.5c0,0.276,0.224,0.5,0.5,0.5s0.5-0.224,0.5-0.5    C20.499,7.813,16.686,4,11.999,4z"></path><path d="M4.501,12.508c0.032-2.02,0.806-3.897,2.181-5.287c0.468-0.474,0.991-0.88,1.554-1.209    c0.238-0.139,0.318-0.445,0.179-0.684C8.277,5.091,7.972,5.01,7.731,5.149C7.093,5.522,6.5,5.983,5.971,6.519    c-1.557,1.574-2.434,3.695-2.47,5.974C3.497,12.769,3.717,12.996,3.994,13c0.002,0,0.005,0,0.008,0    C4.274,13,4.497,12.782,4.501,12.508z"></path><path d="M6.5,12.623c0-1.531,0.569-2.949,1.604-3.995C9.142,7.578,10.524,7,11.999,7c1.587,0,3.099,0.689,4.146,1.891    c0.181,0.208,0.498,0.229,0.706,0.048c0.208-0.182,0.229-0.498,0.048-0.706C15.661,6.814,13.875,6,11.999,6    c-1.744,0-3.379,0.684-4.605,1.925C6.172,9.159,5.5,10.828,5.5,12.649c0.003,1.076-0.333,2.366-0.935,3.605l-0.281,0.5    c-0.135,0.241-0.05,0.545,0.191,0.681C4.553,17.479,4.637,17.5,4.72,17.5c0.175,0,0.345-0.092,0.436-0.255l0.295-0.526    C6.142,15.297,6.504,13.889,6.5,12.623z"></path><path d="M18.865,16.419c-0.317-1.447-0.344-2.828-0.361-3.654L18.499,12.5c0-0.741-0.125-1.469-0.371-2.164    c-0.092-0.26-0.375-0.396-0.638-0.304c-0.26,0.092-0.396,0.377-0.304,0.638c0.208,0.587,0.313,1.203,0.313,1.843l0.006,0.272    c0.018,0.862,0.046,2.305,0.394,3.886l0.572,1.884c0.065,0.216,0.264,0.354,0.479,0.354c0.048,0,0.097-0.007,0.146-0.021    c0.264-0.081,0.413-0.359,0.333-0.624L18.865,16.419z"></path><path d="M17.505,19.085c-0.825-2.576-0.979-5.472-1.006-6.585c0-2.481-2.019-4.5-4.5-4.5C9.518,8,7.5,10.05,7.5,12.587    c0.002,0.526-0.095,3.305-2.207,6.351c-0.158,0.227-0.101,0.539,0.125,0.696s0.539,0.101,0.696-0.125    c2.226-3.209,2.389-6.112,2.386-6.938c0-1.969,1.57-3.57,3.499-3.57c1.93,0,3.5,1.57,3.5,3.512    c0.036,1.452,0.221,4.276,1.053,6.875l0.462,1.483c0.067,0.214,0.264,0.351,0.478,0.351c0.049,0,0.099-0.007,0.149-0.022    c0.264-0.083,0.411-0.363,0.329-0.626L17.505,19.085z"></path><path d="M14.499,12.5c0-1.378-1.122-2.5-2.5-2.5s-2.5,1.122-2.5,2.519c0.006,0.165,0.117,4.093-3.059,8.226    c-0.168,0.219-0.127,0.533,0.092,0.701c0.22,0.169,0.533,0.126,0.701-0.092c3.393-4.416,3.271-8.693,3.265-8.854    c0-0.827,0.673-1.5,1.5-1.5s1.5,0.673,1.501,1.511c0.014,0.56,0.017,5.612-3.887,10.684c-0.168,0.219-0.128,0.533,0.091,0.701    C9.795,23.966,9.902,24,10.008,24c0.15,0,0.298-0.067,0.396-0.195C14.525,18.453,14.513,13.083,14.499,12.5z"></path><path d="M11.755,14.992c0.027,0.004,0.054,0.006,0.08,0.006c0.241,0,0.454-0.175,0.493-0.42c0.204-1.269,0.171-2.067,0.169-2.1    c-0.013-0.275-0.229-0.494-0.521-0.477c-0.275,0.012-0.489,0.245-0.478,0.521c0,0.007,0.028,0.739-0.158,1.896    C11.297,14.691,11.483,14.948,11.755,14.992z"></path><path d="M11.516,16.035c-0.266-0.079-0.543,0.073-0.622,0.337c-0.625,2.111-1.665,4.085-3.089,5.869    c-0.172,0.216-0.137,0.53,0.079,0.703c0.092,0.074,0.202,0.109,0.312,0.109c0.147,0,0.292-0.064,0.391-0.188    c1.505-1.884,2.604-3.973,3.267-6.208C11.932,16.392,11.781,16.113,11.516,16.035z"></path><path d="M15.759,20.111c-0.24-0.718-0.464-1.477-0.465-1.48c-0.06-0.203-0.24-0.346-0.451-0.358    c-0.216-0.015-0.407,0.109-0.489,0.304c-0.011,0.026-1.125,2.645-2.402,4.655c-0.148,0.233-0.079,0.542,0.154,0.69    C12.189,23.975,12.282,24,12.374,24c0.166,0,0.327-0.082,0.422-0.232c0.773-1.217,1.475-2.616,1.933-3.589    c0.026,0.08,0.053,0.161,0.08,0.241l0.599,1.906c0.083,0.263,0.361,0.411,0.627,0.327c0.263-0.083,0.41-0.363,0.327-0.627    L15.759,20.111z"></path></g></g></svg>
			</span>
		</button>
	{/if}
{/block}
{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 5}
	{assign "darkHead" "true"}
{else}
	{assign "darkHead" "false"}
{/if}
{if $Einstellungen.template.theme.theme_default == darkmode}
	{assign "darkMode" "true"}
{else}
	{assign "darkMode" "false"}
{/if}
{if $snackyConfig.designWidth == 1}
<div id="bxt-w">
{/if}
{block name="main-wrapper-starttag"}
{/block}
{if !$bExclusive}
    {if isset($bAdminWartungsmodus) && $bAdminWartungsmodus}
        <div id="maintenance-mode" class="navbar navbar-inverse">
            <div class="container">
                <div class="navbar-text text-center">
                    {lang key="adminMaintenanceMode" section="global"}
                </div>
            </div>
         </div>
    {/if}
	
	{if ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5) && $nSeitenTyp === 18}
		{if !$device->isMobile() || ($device->isMobile() && $snackyConfig.fullscreenElement != 1) || ($device->isMobile() && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'true')}
			<div id="km-fullscreen-wrapper">
		{/if}
	{/if}
	
	{if $snackyConfig.headerPromo != 0 && $nSeitenTyp !== 11 && !isset($smarty.session.km_promo)}
    {include file="layout/header_promo.tpl"}
	{/if}
	
	{if $snackyConfig.headerUsps != 0 && $nSeitenTyp !== 11 && !$device->isMobile()}
    {include file="layout/header_usps.tpl"}
	{/if}
	{block name="header-branding-top-bar"}
		{if $snackyConfig.headerTopbar == 0 && !$device->isMobile()}
			<div id="top-bar-wrapper" class="hidden-xs">
				<div id="top-bar" class="dpflex-j-between dpflex-a-center small mw-container">
					{include file="layout/header_top_bar.tpl"}
				</div>
			</div>
		{/if}
	{/block}
    {block name="header"}
		{if $snackyConfig.headerType == 1  && $nSeitenTyp !== 11}
            {include file="layout/header/1.tpl"}
		{else if $snackyConfig.headerType == 2 || $snackyConfig.headerType == 3 && $nSeitenTyp !== 11}
            {include file="layout/header/2.tpl"}
		{else if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 6 && $nSeitenTyp !== 11}
            {include file="layout/header/4-5.tpl"}
		{else if $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5 && $nSeitenTyp !== 11}
            {include file="layout/header/1.tpl"}
		{else if $snackyConfig.headerType == 7  && $nSeitenTyp !== 11}
            {include file="layout/header/1.tpl"}
		{else}
            {include file="layout/header/default.tpl"}
		{/if}
    {/block}
	
	{if ($snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5) && $nSeitenTyp === 18}
		{if !$device->isMobile() || ($device->isMobile() && $snackyConfig.fullscreenElement != 1) || ($device->isMobile() && $snackyConfig.fullscreenElement == 1 && $hasMobileSlider == 'true')}
				{include file="snippets/extension-fullscreen.tpl"}
			</div>
		{/if}
	{/if}
	{if $nSeitenTyp === 18 && ((isset($oSlider) && count($oSlider->oSlide_arr) > 0) || isset($oImageMap) || !empty($snackyConfig.youtubeID))}
		{include file="snippets/extension.tpl"}
	{/if}
{/if}
{block name="content-all-starttags"}
	
    {if $nSeitenTyp === 2}
    <div class="pl-heading">
        <div class="mw-container">
        {block name="productlist-header"}
            {include file='productlist/header.tpl' hasFilters=$hasFilters}
        {/block}
        </div>
    </div>
    {/if}
    
    {block name="content-wrapper-starttag"}
    <div id="content-wrapper" class="mw-container">
    {/block}

    {block name="content-container-starttag"}
    {/block}
    
    {block name="content-container-block-starttag"}
    {/block}

    {block name="product-pagination"}
    {if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern)}
        <div class="visible-lg product-pagination next">
            {if isset($NavigationBlaettern->naechsterArtikel) && $NavigationBlaettern->naechsterArtikel->kArtikel}<a href="{$NavigationBlaettern->naechsterArtikel->cURL}" title="{$NavigationBlaettern->naechsterArtikel->cName}"></a>{/if}
        </div>
        <div class="visible-lg product-pagination previous">
            {if isset($NavigationBlaettern->vorherigerArtikel) && $NavigationBlaettern->vorherigerArtikel->kArtikel}<a href="{$NavigationBlaettern->vorherigerArtikel->cURL}" title="{$NavigationBlaettern->vorherigerArtikel->cName}"></a>{/if}
        </div>
    {/if}
    {/block}
    
    {block name="content-row-starttag"}
    <div class="row{if $nSeitenTyp === 2} dpflex-j-between{/if}">
    {/block}
        
	{if isset($boxes.left) && !$bExclusive && !empty($boxes.left) && $nSeitenTyp == 2}
		{assign var="hasFilters" value="true"}	
	{else}
		{assign var="hasFilters" value=false}	
	{/if}
    {block name="content-starttag"}
        <div id="content" class="col-xs-12{if $hasFilters == true && (($snackyConfig.filterPos == 0 && $nSeitenTyp === 2) || $snackyConfig.sidepanelEverywhere == 'Y')} col-md-9 col-lg-9 col-xl-10{/if}">
		{include file="snippets/zonen.tpl" id="before_content" title="before_content"}
    {/block}
    
    {block name="header-bc"}
    {/block}
{/block}{* /content-all-starttags *}