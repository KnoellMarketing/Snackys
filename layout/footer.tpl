{block name="content-all-closingtags"}
    {block name="content-closingtag"}
		{include file="snippets/zonen.tpl" id="after_content" title="after_content"}
    </div>{* /content *}
    {/block}
    
    {block name="aside"}
	{if isset($boxes.left) && !$bExclusive && !empty($boxes.left) && $nSeitenTyp == 2}
		{assign var="hasFilters" value="true"}	
	{else}
		{assign var="hasFilters" value=false}	
	{/if}
	{if $hasFilters == true && (($snackyConfig.filterPos == 0 && $nSeitenTyp === 2) || $snackyConfig.sidepanelEverywhere == 'Y' || isset($smarty.get.sidebar))}
		{include file="layout/sidebar.tpl"}
    {/if}
    {/block}
    
    {block name="content-row-closingtag"}
    </div>{* /row *}
    {/block}
    
    {block name="content-container-block-closingtag"}
    {/block}
    
    {block name="content-container-closingtag"}
    {/block}
    
    {block name="content-wrapper-closingtag"}
    </div>{* /content-wrapper*}
    {/block}
{/block}

{block name="footer"}
{if !$bExclusive}
    <div class="clearfix"></div>
	{if $snackyConfig.paymentWall != 0 && $nSeitenTyp!=11 && !$device->isMobile()}
		{getZahlungsarten cAssign="zahlungsartenFooter"}
		{if $zahlungsartenFooter}
			<div id="pay-f" class="hidden-xs">
				<ul class="mw-container">
				{foreach from=$zahlungsartenFooter item=zahlungsart}
					{if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && !empty($zahlungsart->cBild) && $snackyConfig.paymentWall != 3}
						<li class="img"><img src="{$snackyConfig.preloadImage}" data-src="{$zahlungsart->cBild}" alt="{$zahlungsart->cName}"></li>
					{else if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && $snackyConfig.paymentWall != 2}
						<li class="text">{$zahlungsart->cName}</li>
					{/if}	
				{/foreach}
				</ul>
			</div>	
		{/if}
	{/if}

    <footer id="footer"{if isset($snackyConfig.pagelayout) && $snackyConfig.pagelayout === 'fluid'} class="container-block"{/if}>

            {block name="footer-boxes"}
				{load_boxes_raw type='bottom' assign='arrBoxBottom' array=true}
                {if isset($arrBoxBottom) && count($arrBoxBottom) > 0}
                    <div id="footer-boxes" class="mw-container{if $snackyConfig.footerBoxesOpen === '0'} collapsable{/if}">
                        <div class="row row-multi">
							 {if $snackyConfig.logoFooter == 0}
                             {if isset($ShopLogoURL) || !empty($snackyConfig.svgLogo)}
                                <div class="col-xs-12 col-sm-6 col-md-3 col-lg-2" id="logo-footer">  
                                    
									{if !empty($snackyConfig.svgLogo)}
										<img src="{$snackyConfig.preloadImage}" data-src="{$snackyConfig.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
									{else}
										{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
									{/if}
                                </div>
                            {/if}
							{/if}
                            {foreach name=bottomBoxes from=$arrBoxBottom item=box}
								{if (isset($box.obj->kBoxvorlage) && isset($box.obj->anzeigen) && $box.obj->kBoxvorlage != 0 && $box.obj->anzeigen === 'Y' ) ||
								($box.obj->kBoxvorlage == 0 && !empty($box.obj->oContainer_arr))}
										{if isset($box.obj) && isset($box.tpl)}
											{if $smarty.foreach.bottomBoxes.iteration < 10}
									           <div class="{block name="footer-boxes-class"}col-xs-12 col-sm-6 col-md-3 col-lg-2{/block}">
												{assign var=oBox value=$box.obj}
												{include file=$box.tpl}
									           </div>
											{/if}
										{/if}
								{/if}
                            {/foreach}
							{if $snackyConfig.newsletter_footer === 'Y'}
                            	<div class="col-xs-12 col-sm-6 col-md-3 col-lg-2">    
                                    <div class="panel box{block name="footer-newsletter-class"} newsletter-footer{/block}">
										{block name="footer-newsletter"}
											<div class="panel-heading">
												<span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">{lang key="newsletter" section="newsletter"} {lang key="newsletterSendSubscribe" section="newsletter"}
												{include file="snippets/careticon.tpl"} 
												</span>
											</div>
											<div class="box-body">
												<p class="info small">
													{lang key="unsubscribeAnytime" section="newsletter"}
												</p>
												<a href="{get_static_route id='newsletter.php'}" title="{lang key="newsletterSendSubscribe" section="newsletter"}" class="btn btn-xl btn-block btn-primary">
													{lang key="newsletterSendSubscribe" section="newsletter"}
												</a>
											</div>
										{/block}
                                    </div>
                            	</div>
							{/if}
							{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) || (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1)) && $snackyConfig.lgcu_footer != N}
								<div class="col-xs-12 col-sm-6 col-md-3 col-lg-2">
									<div class="panel box box-lng-cur">
										<div class="panel-heading">
											<span class="panel-title h5 m0 dpflex-a-center dpflex-j-between">
												{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
												{lang key="language" section="custom"}
												{/if}
												{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) && (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1))}
												&
												{/if}
												{if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
												{lang key="currency" section="global"}
												{/if}
												{include file="snippets/careticon.tpl"} 
											</span>
										</div>
										<div class="box-body">
										{block name="footer-language"}
										{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
										<div class="language-dropdown dropdown">
											<a href="#" class="dropdown-toggle btn btn-primary dpflex-a-center dpflex-j-between" data-toggle="dropdown" itemprop="inLanguage" itemscope itemtype="http://schema.org/Language" title="{lang key='selectLang'}">
												{foreach from=$smarty.session.Sprachen item=Sprache}
													{if $Sprache->kSprache == $smarty.session.kSprache}
														<span class="lang-{$lang}" itemprop="name">{if $lang === 'ger'}{$Sprache->cNameDeutsch}{else}{$Sprache->cNameEnglisch}{/if}</span>
													{/if}
												{/foreach}
												<span class="caret"></span>
											</a>
											<ul id="language-dropdown" class="dropdown-menu dropdown-menu-left">
											{foreach from=$smarty.session.Sprachen item=oSprache}
												{if $oSprache->kSprache != $smarty.session.kSprache}
													<li>
														<a href="{if isset($oSprache->cURLFull)}{$oSprache->cURLFull}{else}{$oSprache->cURL}{/if}" class="link_lang {$oSprache->cISO}" rel="nofollow">
															<span>{if $lang === 'ger'}{$oSprache->cNameDeutsch}{else}{$oSprache->cNameEnglisch}{/if}</span>
														</a>
													</li>
												{/if}
												{/foreach}
											</ul>
										</div>
										{/if}
										{/block}
										{block name="footer-currency"}
										{if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
										<div class="dropdown">
											<a href="#" class="dropdown-toggle btn btn-primary dpflex-a-center dpflex-j-between" data-toggle="dropdown" title="{lang key='selectCurrency'}">
												{$smarty.session.Waehrung->cName}
												<span class="caret"></span></a>
											<ul id="currency-dropdown" class="dropdown-menu dropdown-menu-left">
											{foreach from=$smarty.session.Waehrungen item=oWaehrung}
												<li>
													<a href="{$oWaehrung->cURL}" rel="nofollow">{$oWaehrung->cName}</a>
												</li>
											{/foreach}
											</ul>
										</div>
										{/if}
										{/block}
										</div>
									</div>
								</div>
							{/if}
                        </div>
                    </div>
                {/if}
            {/block}
		  {include file="snippets/zonen.tpl" id="after_footerboxes" title="after_footerboxes"}

            {block name="footer-additional"}
                    {if $snackyConfig.socialmedia_footer === 'Y'}
                        <div id="footer-social" class="mw-container">
                            <div class="footer-additional-wrapper dpflex-a-center dpflex-j-center dpflex-wrap">
                                {block name="footer-socialmedia"}
                                    {if !empty($snackyConfig.facebook)}
                                        <a href="{if $snackyConfig.facebook|strpos:'http' !== 0}https://{/if}{$snackyConfig.facebook}" class="btn-social btn-facebook dpflex-a-center dpflex-j-center" title="Facebook" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-facebook"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.twitter)}
                                        <a href="{if $snackyConfig.twitter|strpos:'http' !== 0}https://{/if}{$snackyConfig.twitter}" class="btn-social btn-twitter dpflex-a-center dpflex-j-center" title="Twitter" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-twitter"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.googleplus)}
                                        <a href="{if $snackyConfig.googleplus|strpos:'http' !== 0}https://{/if}{$snackyConfig.googleplus}" class="btn-social btn-googleplus dpflex-a-center dpflex-j-center" title="Google+" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-google-plus"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.youtube)}
                                        <a href="{if $snackyConfig.youtube|strpos:'http' !== 0}https://{/if}{$snackyConfig.youtube}" class="btn-social btn-youtube dpflex-a-center dpflex-j-center" title="YouTube" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-youtube"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.vimeo)}
                                        <a href="{if $snackyConfig.vimeo|strpos:'http' !== 0}https://{/if}{$snackyConfig.vimeo}" class="btn-social btn-vimeo dpflex-a-center dpflex-j-center" title="Vimeo" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-vimeo"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.pinterest)}
                                        <a href="{if $snackyConfig.pinterest|strpos:'http' !== 0}https://{/if}{$snackyConfig.pinterest}" class="btn-social btn-pinterest dpflex-a-center dpflex-j-center" title="PInterest" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-pinterest"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.instagram)}
                                        <a href="{if $snackyConfig.instagram|strpos:'http' !== 0}https://{/if}{$snackyConfig.instagram}" class="btn-social btn-instagram dpflex-a-center dpflex-j-center" title="Instagram" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-instagram"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.skype)}
                                        <a href="{if $snackyConfig.skype|strpos:'skype:' !== 0}skype:{$snackyConfig.skype}?add{else}{$snackyConfig.skype}{/if}" class="btn-social btn-skype dpflex-a-center dpflex-j-center" title="Skype" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-skype"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.xing)}
                                        <a href="{if $snackyConfig.xing|strpos:'http' !== 0}https://{/if}{$snackyConfig.xing}" class="btn-social btn-xing dpflex-a-center dpflex-j-center" title="Xing" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-xing"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($snackyConfig.linkedin)}
                                        <a href="{if $snackyConfig.linkedin|strpos:'http' !== 0}https://{/if}{$snackyConfig.linkedin}" class="btn-social btn-linkedin dpflex-a-center dpflex-j-center" title="Linkedin" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}img/icons/icons.svg#icon-linkedin"></use>
											</svg>
										</a>
                                    {/if}
                                {/block}
                            </div>
                        </div>
                    {/if}
            {/block}{* /footer-additional *}
			
        <div id="copyright" class="mw-container text-center small">
            {block name="footer-copyright"}
				<ul class="blanklist{if $snackyConfig.footerCopyright == 1 && !$device->isMobile()} list-inline{/if}">
					{if $NettoPreise == 1}
						<li>{lang key="footnoteExclusiveVat" section="global" assign="footnoteVat"}</li>
					{else}
						<li>{lang key="footnoteInclusiveVat" section="global" assign="footnoteVat"}</li>
					{/if}
					{if $Einstellungen.global.global_versandhinweis === 'zzgl'}
						<li>{lang key="footnoteExclusiveShipping" section="global" printf=$oSpezialseiten_arr[6]->cURL assign="footnoteShipping"}</li>
					{elseif $Einstellungen.global.global_versandhinweis === 'inkl'}
						<li>{lang key="footnoteInclusiveShipping" section="global" printf=$oSpezialseiten_arr[6]->cURL assign="footnoteShipping"}</li>
					{/if}
					{block name="footer-vat-notice"}
						<li>
							<span class="footnote-reference">*</span> {$footnoteVat}{if isset($footnoteShipping)}{$footnoteShipping}{/if}
						</li>
					{/block}
					{if !empty($meta_copyright)}
						<li><span itemprop="copyrightHolder">&copy; {$meta_copyright}</span></li>
					{/if}
					{if $Einstellungen.global.global_zaehler_anzeigen === 'Y'}
						<li>{lang key="counter" section="global"}: {$Besucherzaehler}</li>
					{/if}
					{if !empty($Einstellungen.global.global_fusszeilehinweis)}
						<li>{$Einstellungen.global.global_fusszeilehinweis}</li>
					{/if}
					{if !Shop::isBrandfree()}
						<li id="system-credits">
						Powered by <a href="http://jtl-url.de/jtlshop" title="JTL-Shop" target="_blank" rel="noopener nofollow">JTL-Shop</a>
						</li>
					{/if}
					{if $snackyConfig.noCopyright|checkCopyfree}
						<li id="template-copyright">
							Made with <span class="color-brand">&hearts;</span> by <a href="https://www.knoell-marketing.de/" title="Werbeagentur - Knoell marketing">Knoell Marketing</a>
						</li>
					{/if}
				</ul>
            {/block}
        </div>
      {include file="snippets/zonen.tpl" id="after_footer" title="after_footer"}
    </footer>
{/if}
{/block}

{block name="main-wrapper-closingtag"}
{/block}
{if $snackyConfig.designWidth == 1}
</div>
{/if}
{* JavaScripts *}
{block name="footer-js"}
	<script data-inline=1>
	{include file="js/snackys/lazyImages.js"}
	</script>
	{if $nSeitenTyp==11}<script src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/checkout.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
	{*
		{if $nSeitenTyp==2}<script src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/listing.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
	*}

	{if !empty($snackyConfig.gtag) || !empty($snackyConfig.matomo)}
		<script data-inline=1>{if !empty($snackyConfig.gtag)}var gtagId="{$snackyConfig.gtag}";{/if}{if !empty($snackyConfig.matomo)}var matomoUrl="{$snackyConfig.matomo}";var matomoSiteId="{$snackyConfig.matomoSiteId}";{/if}</script>
		<script src="{if empty($parentTemplateDir)}{$currentTemplateDir}{else}{$parentTemplateDir}{/if}js/snackys/analytics.min.js?v={$nTemplateVersion}" type="text/javascript" async></script>
	{/if}
	{if $device->version("IE")}
	<script>svg4everybody();</script>
	{/if}

	{if (!isset($Einstellungen.template.general.use_cron) || $Einstellungen.template.general.use_cron === 'Y') && $smarty.now % 10 === 0}
		<script>$.get('includes/cron_inc.php');</script>
	{/if}
{/block}

<div class="overlay-bg"></div>
<div id="bodyloader" class="text-center">
	<strong class="small">Loading ...</strong>
</div>
	{if $snackyConfig.pwa == 'Y'}
		<script data-inline=1>
			if ('serviceWorker' in navigator) {ldelim}
			  window.addEventListener('load', () => {ldelim}
				navigator.serviceWorker.register('/pwa.js?v={$nTemplateVersion}');
			  {rdelim});
			{rdelim}
		</script>
	{/if}
	{snackys_content id="html_body_end" title="html_body_end"}

</body>
</html>