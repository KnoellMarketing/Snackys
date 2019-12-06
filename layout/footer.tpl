{block name="content-all-closingtags"}
    {block name="content-closingtag"}
    </div>{* /content *}
    {/block}
    
    {block name="aside"}
    {has_boxes position='left' assign='hasLeftBox'}
    {if $nSeitenTyp === 2 && (!$bExclusive && $hasLeftBox && isset($boxes) && !empty($boxes.left) && $Einstellungen.template.pdListing.filterPos == 0)}
        {block name="footer-sidepanel-left"}
            <aside id="sidepanel_left"
                   class="hidden-print col-xs-12 {if $nSeitenTyp === 2} col-md-3 col-md-pull-9 col-lg-3 col-lg-pull-9 col-xl-2 col-xl-pull-10{/if}">
                <div class="inside">
                    <div class="visible-xs visible-sm">
						<h3>{lang key="filterBy" setion="global"}</h3>
						<hr class="op0">
					</div>
                	{block name="footer-sidepanel-left-content"}
						{$boxes.left}
					{/block}
				</div>
            	<div class="visible-xs visible-sm overlay-bg"></div>
            	<div class="visible-xs visible-sm close-sidebar"></div>
            </aside>
        {/block}
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
	{if $Einstellungen.template.footer.paymentWall != 0 && $nSeitenTyp!=11}
		{getZahlungsarten cAssign="zahlungsartenFooter"}
		{if $zahlungsartenFooter}
			<div id="payment-wall-footer" class="hidden-xs">
				<ul class="mw-container">
				{foreach from=$zahlungsartenFooter item=zahlungsart}
					{if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && !empty($zahlungsart->cBild) && $Einstellungen.template.footer.paymentWall != 3}
						<li class="img"><img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$zahlungsart->cBild}" alt="{$zahlungsart->cName}"></li>
					{else if $zahlungsart->nActive == 1 && $zahlungsart->nNutzbar==1 && $Einstellungen.template.footer.paymentWall != 2}
						<li class="text">{$zahlungsart->cName}</li>
					{/if}	
				{/foreach}
				</ul>
			</div>	
		{/if}
	{/if}

    <footer id="footer"{if isset($Einstellungen.template.theme.pagelayout) && $Einstellungen.template.theme.pagelayout === 'fluid'} class="container-block"{/if}>

            {block name="footer-boxes"}
                {load_boxes_raw type='bottom' assign='arrBoxBottom' array=true}
                {if isset($arrBoxBottom) && count($arrBoxBottom) > 0}
                    <div id="footer-boxes" class="mw-container">
                        <div class="row">
							 {if $Einstellungen.template.footer.logoFooter == 0}
                             {if isset($ShopLogoURL) || !empty($Einstellungen.template.header.svgLogo)}
                                <div class="col-xs-6 col-sm-6 col-md-3 col-lg-2" id="logo-footer">  
                                    
									{if !empty($Einstellungen.template.header.svgLogo)}
										<img src="{$snackysTemplate}img/preload/1x1.png" data-src="{$Einstellungen.template.header.svgLogo}" alt="{$Einstellungen.global.global_shopname}">
									{else}
										{image src=$ShopLogoURL alt=$Einstellungen.global.global_shopname class="img-responsive"}
									{/if}
                                </div>
                            {/if}
							{/if}
                            {foreach name=bottomBoxes from=$arrBoxBottom item=box}
                                {if ($box.obj->kBoxvorlage != 0 && $box.obj->anzeigen === 'Y' ) ||
                                ($box.obj->kBoxvorlage == 0 && !empty($box.obj->oContainer_arr))}
                                    <div class="{block name="footer-boxes-class"}col-xs-6 col-sm-6 col-md-3 col-lg-2{/block}">
                                        {if isset($box.obj) && isset($box.tpl)}
                                            {if $smarty.foreach.bottomBoxes.iteration < 10}
                                                {assign var=oBox value=$box.obj}
                                                {include file=$box.tpl}
                                            {/if}
                                        {/if}
                                    </div>
                                {/if}
                            {/foreach}
                            <div class="col-xs-6 col-sm-6 col-md-3 col-lg-2">    
                                {if $Einstellungen.template.footer.newsletter_footer === 'Y'}
                                    <div class="panel box{block name="footer-newsletter-class"} newsletter-footer{/block}">
                                            {block name="footer-newsletter"}
                                                <div class="panel-heading">
                                                    <h5 class="panel-title">{lang key="newsletter" section="newsletter"} {lang key="newsletterSendSubscribe" section="newsletter"}
                                                    </h5>
                                                </div>
                                                <div class="panel-body">
                                                    <p class="info small">
                                                        {lang key="unsubscribeAnytime" section="newsletter"}
                                                    </p>
                                                    <a href="{get_static_route id='newsletter.php'}" title="{lang key="newsletterSendSubscribe" section="newsletter"}" class="btn btn-xl btn-block btn-primary">
                                                        {lang key="newsletterSendSubscribe" section="newsletter"}
                                                    </a>
                                                </div>
                                            {/block}
                                    </div>
                                {/if}
                            </div>
							{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) || (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1)) && $Einstellungen.template.footer.lgcu_footer != N}
								<div class="col-xs-6 col-sm-6 col-md-3 col-lg-2">
									<div class="panel box box-lng-cur">
										<div class="panel-heading">
											<h5 class="panel-title">
												{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
												{lang key="language" section="custom"}
												{/if}
												{if ((isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1) && (isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1))}
												&
												{/if}
												{if isset($smarty.session.Waehrungen) && $smarty.session.Waehrungen|@count > 1}
												{lang key="currency" section="global"}
												{/if}
											</h5>
										</div>
										<div class="panel-body">
										{block name="footer-language"}
										{if isset($smarty.session.Sprachen) && $smarty.session.Sprachen|@count > 1}
										<div class="language-dropdown dropdown">
											<a href="#" class="dropdown-toggle btn btn-primary" data-toggle="dropdown" itemprop="inLanguage" itemscope itemtype="http://schema.org/Language" title="{lang key='selectLang'}">
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
											<a href="#" class="dropdown-toggle btn btn-primary" data-toggle="dropdown" title="{lang key='selectCurrency'}">
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
                    {if $Einstellungen.template.footer.socialmedia_footer === 'Y'}
                        <div id="footer-social" class="mw-container">
                            <div class="footer-additional-wrapper">
                                {block name="footer-socialmedia"}
                                    {if !empty($Einstellungen.template.footer.facebook)}
                                        <a href="{if $Einstellungen.template.footer.facebook|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.facebook}" class="btn-social btn-facebook" title="Facebook" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-facebook"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.twitter)}
                                        <a href="{if $Einstellungen.template.footer.twitter|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.twitter}" class="btn-social btn-twitter" title="Twitter" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-twitter"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.googleplus)}
                                        <a href="{if $Einstellungen.template.footer.googleplus|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.googleplus}" class="btn-social btn-googleplus" title="Google+" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-google-plus"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.youtube)}
                                        <a href="{if $Einstellungen.template.footer.youtube|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.youtube}" class="btn-social btn-youtube" title="YouTube" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-youtube"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.vimeo)}
                                        <a href="{if $Einstellungen.template.footer.vimeo|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.vimeo}" class="btn-social btn-vimeo" title="Vimeo" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-vimeo"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.pinterest)}
                                        <a href="{if $Einstellungen.template.footer.pinterest|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.pinterest}" class="btn-social btn-pinterest" title="PInterest" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-pinterest"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.instagram)}
                                        <a href="{if $Einstellungen.template.footer.instagram|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.instagram}" class="btn-social btn-instagram" title="Instagram" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-instagram"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.skype)}
                                        <a href="{if $Einstellungen.template.footer.skype|strpos:'skype:' !== 0}skype:{$Einstellungen.template.footer.skype}?add{else}{$Einstellungen.template.footer.skype}{/if}" class="btn-social btn-skype" title="Skype" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-skype"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.xing)}
                                        <a href="{if $Einstellungen.template.footer.xing|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.xing}" class="btn-social btn-xing" title="Xing" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-xing"></use>
											</svg>
										</a>
                                    {/if}
                                    {if !empty($Einstellungen.template.footer.linkedin)}
                                        <a href="{if $Einstellungen.template.footer.linkedin|strpos:'http' !== 0}https://{/if}{$Einstellungen.template.footer.linkedin}" class="btn-social btn-linkedin" title="Linkedin" target="_blank" rel="noopener">
											<svg class="icon-darkmode">
											  <use xlink:href="{$snackysTemplate}img/icons/icons.svg#icon-linkedin"></use>
											</svg>
										</a>
                                    {/if}
                                {/block}
                            </div>
                        </div>
                    {/if}
                {/if}
            {/block}

            {block name="footer-additional"}
            {/block}{* /footer-additional *}
			
        <div id="copyright" class="mw-container">
            {block name="footer-copyright"}
				<ul class="list-unstyled">
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
					{if $Einstellungen.template.general.noCopyright|checkCopyfree}
						<li id="template-copyright">
							Made with <span class="heart">&hearts;</span> by <a href="https://www.knoell-marketing.de/" title="Werbeagentur - Knoell marketing">Knoell Marketing</a>
						</li>
					{/if}
				</ul>
            {/block}
        </div>
    </footer>
{/if}
{/block}

{block name="main-wrapper-closingtag"}
{/block}
{if $Einstellungen.template.theme.designWidth == 1}
</div>
{/if}
{* JavaScripts *}
{block name="footer-js"}
{if !isset($Einstellungen.template.general.use_minify) || $Einstellungen.template.general.use_minify === 'N'}
	{if isset($cJS_arr)}{foreach from=$cJS_arr item="cJS"}<script src="{$snackysTemplate}{$cJS}?v={$nTemplateVersion}" type="text/javascript" defer></script>{/foreach}{/if}
	{if isset($cPluginJsBody_arr)}{foreach from=$cPluginJsBody_arr item="cJS"}<script src="{$snackysTemplate}{$cJS}?v={$nTemplateVersion}" type="text/javascript" defer></script>{/foreach}{/if}
{else}
	{if isset($cJS_arr)}{if isset($cJS_arr) && $cJS_arr|@count > 0}<script src="{$snackysTemplateAsset}asset/jtl3.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}{/if}
	{if isset($cPluginJsBody_arr)}{if isset($cPluginJsBody_arr) && $cPluginJsBody_arr|@count > 0}<script src="{$snackysTemplateAsset}asset/plugin_js_body?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}{/if}
{/if}
{if $nSeitenTyp==1}<script src="{$snackysTemplate}js/article.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
{if $nSeitenTyp==1 && $Artikel->bHasKonfig}<script src="{$snackysTemplate}js/configurator.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
{if $nSeitenTyp==11}<script src="{$snackysTemplate}js/checkout.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}
{if $nSeitenTyp==2}<script src="{$snackysTemplate}js/listing.min.js?v={$nTemplateVersion}" type="text/javascript" defer></script>{/if}

{if !empty($Einstellungen.template.analytics.id1) ||  !empty($Einstellungen.template.analytics.gtag) || !empty($Einstellungen.global.global_google_analytics_id)}<script src="{$snackysTemplate}js/analytics.min.js?v={$nTemplateVersion}" type="text/javascript" async></script>{/if}
{/block}

{if isset($cookieHinweisLink) && $Einstellungen.template.general.use_cookie_hint=='Y'}{include file='snippets/cookie-hinweis.tpl'}{/if}
<div class="overlay-bg"></div>
</body>
</html>