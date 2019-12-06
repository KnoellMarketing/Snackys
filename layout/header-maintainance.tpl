{assign var="tDir" value=$currentTemplateDir}
{if isset($parentTemplateDir)}
	{if !file_exists('{$currentTemplateDir}/layout/header.tpl')}
		{assign var="tDir" value=$parentTemplateDir}
	{/if}
{/if}
{extends file="{$tDir}/layout/header.tpl"}

{block name="head-resources"}
		{loadCSS css1=$cCSS_arr css2=$cPluginCss_arr css3=$css3 cPageType=$nSeitenTyp}
		{append var='css3' value='/templates/snackys/themes/base/css/header_default.css'}
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
{block name="body-tag"}
<body data-page="{$nSeitenTyp}" class="body-offcanvas"{if !empty($snackyConfig.maintenanceBG)} style="background: url({$snackyConfig.maintenanceBG})no-repeat center center/cover;"{/if}>
{/block}

{block name="main-wrapper-starttag"}
<div id="main-wrapper" class="col-xs-12">
{/block}

{block name="header-branding-top-bar"}
{/block}

{block name="header-branding-content"}
    
{/block}
{block name="header"}
{/block}
{block name="header-category-nav"}
{/block}

{block name="header-bc"}
{/block}

{block name="content-starttag"}
    <div id="content" class="col-xs-12">
{/block}