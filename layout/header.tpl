{block name="doctype"}<!DOCTYPE html>{/block}
<html {block name="html-attributes"}lang="{$meta_language}" itemscope {if $nSeitenTyp == URLART_ARTIKEL}itemtype="http://schema.org/ItemPage"
      {elseif $nSeitenTyp == URLART_KATEGORIE}itemtype="http://schema.org/CollectionPage"
      {else}itemtype="http://schema.org/WebPage"{/if}{/block} id="snackys-tpl">
{block name="head"}
<head>
	{snackys_content id="html_head_start" title="html_head_start"}
	{if $snackyConfig.pwa == 'Y'}<link rel="manifest" href="manifest.json">{/if}
	{if !empty($snackyConfig.gtag)}<link rel="dns-prefetch preconnect" href="https://www.googletagmanager.com">{/if}
	
    {block name="head-resources-jquery"}
	
        <script src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/jquery-1.12.4.min.js" defer></script>
		{if $device->version("IE") || $device->version("Opera Mini") || $device->version("baidubrowser") || $device->version("baiduboxapp") || $device->version("MQQBrowser")}
			<script type="text/javascript" data-inline=1>{readJs file="js/snackys/intersectionObserver.js"}</script>
		{/if}
		
		{if $device->version("IE")}<script data-inline="1">{readJs file="js/snackys/svg.min.js"}</script>{/if}
		
		{if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
			{if isset($cPluginJsHead_arr)}{foreach from=$cPluginJsHead_arr item="cJS"}<script src="{$cJS}?v={$nTemplateVersion}" type="text/javascript" defer></script>{/foreach}{/if}
			{foreach from=$cJS_arr item="cJS"}<script src="{$cJS}?v={$nTemplateVersion}" type="text/javascript" defer></script>{/foreach}
			{if isset($cPluginJsBody_arr)}{foreach from=$cPluginJsBody_arr item="cJS"}<script src="{$cJS}?v={$nTemplateVersion}" type="text/javascript" defer></script>{/foreach}{/if}
		{else}
			{if isset($cPluginJsHead_arr) && $cPluginJsHead_arr|@count > 0}<script src="asset/plugin_js_head?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
			<script src="asset/jtl3.js?v={$nTemplateVersion}" type="text/javascript" defer></script>
			{if isset($cPluginJsBody_arr) && $cPluginJsBody_arr|@count > 0}<script src="asset/plugin_js_body?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
		{/if}

		{assign var="customJSPath" value=$currentTemplateDir|cat:'/js/custom.js'}
		{if file_exists($customJSPath)}
			<script src=""{$customJSPath}?v={$nTemplateVersion}" type="text/javascript" defer></script>
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

    {block name="head-base"}
        <base href="{$ShopURL}/">
    {/block}

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
		{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 5 || $Einstellungen.template.theme.theme_default == 'darkmode'}
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
		{if $snackyConfig.posTrusted == 0}
			{append var='css3' value='/templates/snackys/themes/base/css/trusted-left.css'}
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
			{append var='css3' value='/templates/snackys/themes/base/css/manuslider.css'}
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
			{append var='css3' value='/templates/snackys/themes/base/css/banner.css'}
			{/if}
		   {if $nSeitenTyp === 25}
			{append var='css3' value='/templates/snackys/themes/base/css/404.css'}
		  {/if}
		   {getSliderPerDevice cAssign="oSliderDevice"}
			{if isset($oSliderDevice) && count($oSliderDevice->oSlide_arr) > 0}	
			{append var='css3' value='/templates/snackys/themes/base/css/slider.css'}
		   {/if}
			{if $snackyConfig.headerTopbar == 0 && !$device->isMobile()}
			{append var='css3' value='/templates/snackys/themes/base/css/topbar.css'}
			{/if}
			{if $snackyConfig.hover_productlist === 'Y' && !$device->isMobile() && $nSeitenTyp == 2}
			{append var='css3' value='/templates/snackys/themes/base/css/listing-jtl-hover.css'}
			 {/if}
			{if $snackyConfig.listShowCart != 1}
			{append var='css3' value='/templates/snackys/themes/base/css/listing-km-hover.css'}
			 {/if}
			  {if !empty($oAuswahlAssistent->kAuswahlAssistentGruppe) || isset($AWA)}
				{append var='css3' value='/templates/snackys/themes/base/css/selectionwizard.css'}
			  {/if}
			   {if $Einstellungen.artikeldetails.artikeldetails_navi_blaettern === 'Y' && isset($NavigationBlaettern) && $nSeitenTyp == 1}
				{append var='css3' value='/templates/snackys/themes/base/css/prevnext.css'}
			   {/if}
				{if $Artikel->bHasKonfig && $nSeitenTyp == 1}
				{append var='css3' value='/templates/snackys/themes/base/css/konfigurator.css'}
				{/if}
				 {if $snackyConfig.filterPos == 1 && $nSeitenTyp == 2}
				{append var='css3' value='/templates/snackys/themes/base/css/filter-above.css'}
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
			{if $snackyConfig.mobileTrusted == 1}
				_tsConfig.responsive = {ldelim}'variant': 'floating'{rdelim}; 
			{/if}
		</script>
		<script src="//widgets.trustedshops.com/js/{$snackyConfig.trustedID}.js" async data-inline="1"></script>
	{/if}
	
	<meta name="theme-color" content="{$snackyConfig.css_brand}">
	<link rel="apple-touch-icon" href="{if empty($snackyConfig.appleTouchIcon)}/templates/snackys/img/icons/apple-touch-icon.png{else}{$snackyConfig.appleTouchIcon}{/if}"/>
	{if !empty($snackyConfig.pwa_icon192) && $snackyConfig.pwa == 'Y'}<link rel="icon" sizes="192x192" href="{$snackyConfig.pwa_icon192}">{/if}
	{if !empty($snackyConfig.pwa_icon512) && $snackyConfig.pwa == 'Y'}<link rel="icon" sizes="512x512" href="{$snackyConfig.pwa_icon512}">{/if}

	{if $isShopFive}
        {if \JTL\Shop::isAdmin() && $opc->isEditMode() === false && $opc->isPreviewMode() === false}
            <link type="text/css" href="{$ShopURL}/admin/opc/css/startmenu.css" rel="stylesheet">
        {/if}
        {foreach $opcPageService->getCurPage()->getCssList($opc->isEditMode()) as $cssFile => $cssTrue}
            <link rel="stylesheet" href="{$cssFile}">
        {/foreach}
	{/if}

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
body-offcanvas{if $bSeiteNichtGefunden} error404{/if}{if empty($snackyConfig.youtubeID) && $nSeitenTyp == 18} no-yt{/if}{if $snackyConfig.headerUsps != 0} usps-visible{/if}
{if $Einstellungen.template.theme.theme_default == darkmode} darkmode{/if}{if $snackyConfig.designWidth == 1} boxed-layout{/if}
{if $snackyConfig.boxedMargin == 1} boxed-nomargin{/if}{if $snackyConfig.boxedBorder == 1} boxed-noborder{/if}
{if $snackyConfig.fwSlider == 1 && $nSeitenTyp == 18} boxed-slider{/if}
{if $snackyConfig.headerType == 4 || $snackyConfig.headerType == 4.5 || $snackyConfig.headerType == 5 || $snackyConfig.headerType == 5.5} full-head{/if}
{if $snackyConfig.productBorder == 1} product-border{/if}
{if $device->isMobile()} mobile{/if}
{if $device->isiOS()} ios{/if}
{if $device->is("Edge")} edge
{elseif $device->version("IE")} ie ie-{$device->version("IE")|number_format:0}{/if}
{if !empty($hinweis)}{if isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt} basked-added{/if}{/if}
{if $isShopFive && isset($bWarenkorbHinzugefuegt) && $bWarenkorbHinzugefuegt} basked-added{/if}
{if $snackyConfig.sidepanelEverywhere == 'Y'} sidebar-overall{/if}
"



{if isset($Link) && !empty($Link->cIdentifier)} id="{$Link->cIdentifier}"{/if}
{if !empty($snackyConfig.boxedImg) && $snackyConfig.designWidth == 1} style="background: url({$snackyConfig.boxedImg})no-repeat center center/cover;{if !$device->isMobile()} background-attachment: fixed"{/if}{/if}
>
{/strip}
	{if $isShopFive}
        {include file=$opcDir|cat:'tpl/startmenu.tpl'}
	{/if}
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
	<div id="km-fullscreen-wrapper">
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
		{include file="snippets/extension-fullscreen.tpl"}
		</div>
	{/if}
	{if $nSeitenTyp === 18 && ((isset($oSlider) && count($oSlider->oSlide_arr) > 0) || isset($oImageMap) || !empty($snackyConfig.youtubeID))}
		{include file="snippets/extension.tpl"}
	{/if}
{/if}
{block name="content-all-starttags"}
	
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
    
    {block name="content-starttag"}
        <div id="content" class="col-xs-12{if (isset($boxes.left) && !$bExclusive && !empty($boxes.left) && !$device->isMobile()) && (($snackyConfig.filterPos == 0 && $nSeitenTyp === 2) || $snackyConfig.sidepanelEverywhere == 'Y')} col-md-9 col-md-push-3 col-lg-9 col-lg-push-3 col-xl-10 col-xl-push-2{/if}">
		{include file="snippets/zonen.tpl" id="before_content" title="before_content"}
    {/block}
    
    {block name="header-bc"}
    {/block}
{/block}{* /content-all-starttags *}