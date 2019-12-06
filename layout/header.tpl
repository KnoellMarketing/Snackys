{block name="doctype"}<!DOCTYPE html>{/block}
<html {block name="html-attributes"}lang="{$meta_language}" itemscope {if $nSeitenTyp == URLART_ARTIKEL}itemtype="http://schema.org/ItemPage"
      {elseif $nSeitenTyp == URLART_KATEGORIE}itemtype="http://schema.org/CollectionPage"
      {else}itemtype="http://schema.org/WebPage"{/if}{/block}>
{block name="head"}
<head>
	{snackysBasics}
	{$snackysBasics}
	{if $Einstellungen.template.theme.google_font != ''}
		<link rel="dns-prefetch preconnect" href="https://fonts.googleapis.com">
		<link rel="dns-prefetch preconnect" href="https://fonts.gstatic.com/" crossorigin>
	{/if}
	{if !empty($Einstellungen.template.general.cdnDomain)}<link rel="dns-prefetch preconnect" href="{$Einstellungen.template.general.cdnDomain}">{/if}
	
	{if !empty($Einstellungen.global.global_google_analytics_id) || !empty($Einstellungen.template.analytics.id1)}<link rel="dns-prefetch preconnect" href="https://www.googletagmanager.com"><link rel="dns-prefetch preconnect" href="https://www.google-analytics.com">
	{else if !empty($Einstellungen.template.analytics.gtag)}<link rel="dns-prefetch preconnect" href="https://www.googletagmanager.com">{/if}
	{if $Einstellungen.template.general.optimize_all_js == 'Y' || $Einstellungen.template.general.optimize_all_js == 'YD'}
		<meta http-equiv="Content-Security-Policy" content="script-src 'self' 'unsafe-inline' 'unsafe-eval' data: *;">
	{/if}
    {block name="head-resources-jquery"}
		{if $Einstellungen.template.general.optimize_jquery == 'E'}
		<script src="{$snackysTemplate}js/jquery.js" inline=1></script>
		{else}
		<script type="text/javascript" inline=1>{readJs file="js/jquery.js"}</script>
		{/if}
		
    {/block}
	{if $Einstellungen.template.trustedShops.showTrusted == 0 && !empty($Einstellungen.template.trustedShops.trustedID)}<link rel="dns-prefetch" href="//widgets.trustedshops.com">{/if}
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
		{if $Einstellungen.template.header.headerType == 1 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else if $Einstellungen.template.header.headerType == 2 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light-mmenu.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else if $Einstellungen.template.header.headerType == 3 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
	
		{else if $Einstellungen.template.header.headerType == 4 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/megamenu-fullscreen.css'}
	
		{else if $Einstellungen.template.header.headerType == 4.5 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/megamenu-fullscreen.css'}
	
		{else if $Einstellungen.template.header.headerType == 5 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter-fullscreen.css'}
	
		{else if $Einstellungen.template.header.headerType == 5.5 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-navcenter-fullscreen.css'}
	
		{else if $Einstellungen.template.header.headerType == 6 && $nSeitenTyp !== 11}
			{append var='css3' value='/templates/snackys/themes/base/css/header-light.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/header-fullscreen.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/search-toggle.css'}
			{append var='css3' value='/templates/snackys/themes/base/css/megamenu-fullscreen.css'}
	
		{else}
			{append var='css3' value='/templates/snackys/themes/base/css/header_default.css'}
		{/if}
		{if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.theme.theme_default == 'darkmode'}
			{append var='css3' value='/templates/snackys/themes/darkmode/css/header-darkmode.css'}
		{/if}
		{if $Einstellungen.template.theme.theme_default == 'darkmode'}
			{append var='css3' value='/templates/snackys/themes/darkmode/css/footer-darkmode.css'}
		{/if}
		{if $Einstellungen.template.theme.designWidth == 1}
			{append var='css3' value='/templates/snackys/themes/base/css/boxed-layout.css'}
		{/if}
		{if $Einstellungen.template.header.headerUsps != 0}
			{append var='css3' value='/templates/snackys/themes/base/css/usps-header.css'}
		{/if}
		{if $Einstellungen.template.trustedShops.posTrusted == 0}
			{append var='css3' value='/templates/snackys/themes/base/css/trusted-left.css'}
		{/if}
		{if $Einstellungen.template.footer.paymentWall != 0}
			{append var='css3' value='/templates/snackys/themes/base/css/payment-wall.css'}
		{/if}
		{loadCSS css1=$cCSS_arr css2=$cPluginCss_arr css3=$css3 cPageType=$nSeitenTyp}
        {* RSS *}
        {if isset($Einstellungen.rss.rss_nutzen) && $Einstellungen.rss.rss_nutzen === 'Y'}
            <link rel="alternate" type="application/rss+xml" title="Newsfeed {$Einstellungen.global.global_shopname}" href="rss.xml">
        {/if}
        {* Languages *}
        {if !empty($smarty.session.Sprachen) && count($smarty.session.Sprachen) > 1}
            {foreach item=oSprache from=$smarty.session.Sprachen}
                    <link rel="alternate" hreflang="{$oSprache->cISO639}" href="{$oSprache->cURL}">
            {/foreach}
        {/if}
    {/block}

    {* Pagination *}
    {if isset($Suchergebnisse->Seitenzahlen->maxSeite) && $Suchergebnisse->Seitenzahlen->maxSeite > 1 && isset($oNaviSeite_arr) && $oNaviSeite_arr|@count > 0}
        {if $Suchergebnisse->Seitenzahlen->AktuelleSeite>1}
            <link rel="prev" href="{$oNaviSeite_arr.zurueck->cURL}">
        {/if}
        {if $Suchergebnisse->Seitenzahlen->AktuelleSeite < $Suchergebnisse->Seitenzahlen->maxSeite}
            <link rel="next" href="{$oNaviSeite_arr.vor->cURL}">
        {/if}
    {/if}

    {if !empty($Einstellungen.template.theme.backgroundcolor) && $Einstellungen.template.theme.backgroundcolor|strlen > 1}
        <style>
            body { background-color: {$Einstellungen.template.theme.backgroundcolor}!important; }
        </style>
    {/if}
	{* Config for JavaScript Functions, loaded into $.snackys.data.config.VARIABLENAME *}
	<script id="snacky-config" type="application/json">
	{strip}
	{ldelim}
		{* if $Einstellungen.template.theme.font_path == 'custom'}
			"font": "{$currentTemplateDir}themes/{$Einstellungen.template.theme.theme_default}/fonts/fonts.css"
		{else}
			"font": "{$snackysTemplate}themes/{$Einstellungen.template.theme.theme_default}/fonts/fonts.css"
		{/if *}
		"a":"b"
		{if $Einstellungen.template.theme.google_font != ''}
			,"googlefont":"{$Einstellungen.template.theme.google_font|strip}"
		{/if}
		{if !empty($Einstellungen.global.global_google_analytics_id) && empty($Einstellungen.template.analytics.id1)},"analytics":"{$Einstellungen.global.global_google_analytics_id}"
		{else if !empty($Einstellungen.template.analytics.id1)},"analytics":"{$Einstellungen.template.analytics.id1}"{/if}
		{if !empty($Einstellungen.template.analytics.id2)},"analytics2":"{$Einstellungen.template.analytics.id2}"{/if}
		{if !empty($Einstellungen.template.analytics.id3)},"analytics3":"{$Einstellungen.template.analytics.id3}"{/if}
		{if !empty($Einstellungen.template.analytics.id4)},"analytics4":"{$Einstellungen.template.analytics.id4}"{/if}
		{if !empty($Einstellungen.template.analytics.id5)},"analytics5":"{$Einstellungen.template.analytics.id5}"{/if}
		{if !empty($Einstellungen.template.analytics.gtag)},"tagmanager":"{$Einstellungen.template.analytics.gtag}"{/if}
		{if $Einstellungen.template.general.use_image_optimizer=='Y'},"imageOptimizer":1{/if}
		{if $Einstellungen.template.trustedShops.showTrusted == 0 && !empty($Einstellungen.template.trustedShops.trustedID)}
			,"trustedID":"{$Einstellungen.template.trustedShops.trustedID}"
			,"mobileTrusted":{$Einstellungen.template.trustedShops.mobileTrusted}
			,"variantTrusted":{$Einstellungen.template.trustedShops.varTrusted}
		{/if}
		,"listElmLg": {$Einstellungen.template.pdListing.listElmLg}
		,"listElmMd": {$Einstellungen.template.pdListing.listElmMd}
		,"listElmSm": {$Einstellungen.template.pdListing.listElmSm}
		,"listElmXs": {$Einstellungen.template.pdListing.listElmXs}
		,"listElmXl": {$Einstellungen.template.pdListing.listElmXl}
		,"imageQuality": "{$Einstellungen.template.general.use_image_quality}"
		{if $Einstellungen.template.general.use_image_webp=='Y'} {*  && $smarty.server.HTTP_ACCEPT|strpos:"image/webp" *}
		,"webp":1
		{/if}
		{if $Einstellungen.template.general.mod_pagespeed=='Y'},"modPagespeed":1{/if}
	{rdelim}
	{/strip}
	</script>
{if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
	{if isset($cPluginJsHead_arr)}{foreach from=$cPluginJsHead_arr item="cJS"}<script src="{$snackysTemplate}{$cJS}?v={$nTemplateVersion}" type="text/javascript"{if $Einstellungen.template.general.optimize_all_js == 'Y' || $Einstellungen.template.general.optimize_all_js == 'YD'} defer{/if}></script>{/foreach}{/if}
{else}
	{if isset($cPluginJsHead_arr) && $cPluginJsHead_arr|@count > 0}<script src="{$snackysTemplateAsset}asset/plugin_js_head?v={$nTemplateVersion}" type="text/javascript"{if $Einstellungen.template.general.optimize_all_js == 'Y' || $Einstellungen.template.general.optimize_all_js == 'YD'} defer{/if}></script>{/if}
{/if}
<!--[if IE]>
<script src="{$snackysTemplate}js/svg.min.js"></script>
<![endif]-->
</head>
{/block}

{assign var="isFluidContent" value=false}
{if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout === 'fluid' && isset($Link) && $Link->bIsFluid}
    {assign var="isFluidContent" value=true}
{/if}
{has_boxes position='left' assign='hasLeftPanel'}
{block name="body-tag"}
<body data-headtype="{$Einstellungen.template.header.headerType}" data-page="{$nSeitenTyp}" class="body-offcanvas{if empty($Einstellungen.template.header.youtubeID) && $nSeitenTyp == 18} no-yt{/if}{if $Einstellungen.template.header.headerUsps != 0} usps-visible{/if}{if $Einstellungen.template.theme.theme_default == darkmode} darkmode{/if}{if $Einstellungen.template.theme.designWidth == 1} boxed-layout{/if}{if $Einstellungen.template.theme.boxedMargin == 1} boxed-nomargin{/if}{if $Einstellungen.template.theme.boxedBorder == 1} boxed-noborder{/if}{if $Einstellungen.template.homepage.fwSlider == 1 && $nSeitenTyp == 18} boxed-slider{/if}{if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.header.headerType == 5.5} full-head{/if}{if $Einstellungen.template.theme.productBorder == 1} product-border{/if}"{if isset($Link) && !empty($Link->cIdentifier)} id="{$Link->cIdentifier}"{/if}{if !empty($Einstellungen.template.theme.boxedImg) && $Einstellungen.template.theme.designWidth == 1} style="background: url({$Einstellungen.template.theme.boxedImg})no-repeat center center/cover; background-attachment: fixed"{/if}>
    <!--[if IE]>
    <div id="outdatedbrowser" class="text-center">
        {if isset($ShopLogoURL)}
            {image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
        {else}
            <span class="h1">{$Einstellungen.global.global_shopname}</span>
        {/if}
        <span class="h2">Your browser is out-of-date</span>
        <p>update your browser to view this website</p>
        <a href="http://outdatedbrowser.com" class="btn btn-primary" target="_blank">update my browser now</a>
    </div>
    <![endif]-->
{/block}
{if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 5}
	{assign "darkHead" "true"}
{else}
	{assign "darkHead" "false"}
{/if}
{if $Einstellungen.template.theme.theme_default == darkmode}
	{assign "darkMode" "true"}
{else}
	{assign "darkMode" "false"}
{/if}
{if $Einstellungen.template.theme.designWidth == 1}
<div id="boxed-layout-wrapper">
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
	
	{if ($Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.header.headerType == 5.5) && $nSeitenTyp === 18}
	<div id="km-fullscreen-wrapper">
	{/if}
	
	{if $Einstellungen.template.header.headerUsps != 0 && $nSeitenTyp !== 11}
    {include file="layout/header_usps.tpl"}
	{/if}
	{block name="header-branding-top-bar"}
		{if $Einstellungen.template.header.headerTopbar == 0}
			<div id="top-bar-wrapper" class="hidden-xs">
				<div id="top-bar" class="dpflex-j-between dpflex-a-center small mw-container">
					{include file="layout/header_top_bar.tpl"}
				</div>
			</div>
		{/if}
	{/block}
    {block name="header"}
		{if $Einstellungen.template.header.headerType == 1  && $nSeitenTyp !== 11}
            {include file="layout/header/1.tpl"}
		{else if $Einstellungen.template.header.headerType == 2 || $Einstellungen.template.header.headerType == 3 && $nSeitenTyp !== 11}
            {include file="layout/header/2.tpl"}
		{else if $Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 6 && $nSeitenTyp !== 11}
            {include file="layout/header/4-5.tpl"}
		{else if $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.header.headerType == 5.5 && $nSeitenTyp !== 11}
            {include file="layout/header/1.tpl"}
		{else}
            {include file="layout/header/default.tpl"}
		{/if}
    {/block}
	
	{if ($Einstellungen.template.header.headerType == 4 || $Einstellungen.template.header.headerType == 4.5 || $Einstellungen.template.header.headerType == 5 || $Einstellungen.template.header.headerType == 5.5) && $nSeitenTyp === 18}
		{include file="snippets/extension-fullscreen.tpl"}
		</div>
	{/if}
	{if $nSeitenTyp === 18 && ((isset($oSlider) && count($oSlider->oSlide_arr) > 0) || isset($oImageMap) || !empty($Einstellungen.template.header.youtubeID))}
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
    <div class="row">
    {/block}
    
    {block name="content-starttag"}
        <div id="content" class="col-xs-12{if (isset($boxes.left) && !$bExclusive && !empty($boxes.left) && $Einstellungen.template.pdListing.filterPos == 0) && $nSeitenTyp === 2} col-md-9 col-md-push-3 col-lg-9 col-lg-push-3 col-xl-10 col-xl-push-2{/if}">
    {/block}
    
    {block name="header-breadcrumb"}
    {/block}
{/block}{* /content-all-starttags *}